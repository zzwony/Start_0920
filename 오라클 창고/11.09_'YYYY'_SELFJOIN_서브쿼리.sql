SELECT COMM
FROM EMP;

-- NULL값이 0이 되도록 출력
SELECT NVL(COMM, 0)
    FROM EMP;

-- '1981/06/01' 이후인 사원정보
SELECT *
    FROM EMP
WHERE HIREDATE >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

SELECT *
    FROM EMP
WHERE HIREDATE >= '1981/06/01'; -- 동일코드

-- '1981년 이후인 사원정보
SELECT *
    FROM EMP
WHERE HIREDATE > TO_DATE('1981', 'YYYY');

-- 사원은 모두 몇 명입니까?
SELECT COUNT(ENAME)
FROM EMP;

-- 부서번호가 20인 부서의 최고급여는?


-- 부서별 최고급여?
SELECT DEPTNO, MAX(SAL)
FROM EMP
GROUP BY DEPTNO;

-- 급여가 1000 이상인 사람들의 부서별 평균급여는?
SELECT DEPTNO, AVG(SAL)
FROM EMP
WHERE SAL >= 1000
GROUP BY DEPTNO
ORDER BY DEPTNO; 

-- 부서별 직책별로 평균급여가 1000이상
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 1000  -- 그룹에 대한 조건이기 때문에 HAVING
ORDER BY DEPTNO;

-- 직책별로 인원이 3명 이상인 직책별 사원수?
SELECT JOB, COUNT(ENAME)
    FROM EMP
GROUP BY JOB
HAVING COUNT(ENAME) >= 3;

--★ 사원들의 입사 연도를 기준으로 부서별로 몇 명이 입사?
SELECT TO_CHAR(HIREDATE, 'YYYY'), DEPTNO, COUNT(ENAME)
    FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO;

----------------------------------진도 시작--------------------------------------
-- JOIN
SELECT *
    FROM EMP, DEPT
ORDER BY EMPNO;

SELECT *
    FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
ORDER BY EMP.DEPTNO;    --출력물의 결과를 보면 DEPTNO는 EMP.DEPTNO이고 DEPTNO_1은 DEOT.DEPTNO이다.

-- 줄이기
SELECT E.ENAME, E.JOB, D.LOC
    FROM EMP E, DEPT D  --별칭 지정
WHERE E.DEPTNO = D.DEPTNO -- 유일한 칼럼일때는 E.이라고 붙이지 않아도 출력된다.
                          -- 하지만 잘 써주자(출처를 알 수 있기 때문)
ORDER BY E.DEPTNO;

SELECT E.EMPNO, D.DEPTNO
    FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO;

-- 조인 종류 INNER JOIN, EQUI JOIN, SIMPLE JOIN
-- INNER JOIN은 내부 조인
-- EQUI JOIN은 등가 조인
-- SIMPLE JOIN은 단순 조인
-- 통상 INNER JOIN 이라고 부른다.

SELECT E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME, D.LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
        AND SAL >= 3000;

-- NON-EQUI JOIN 비등가 조인
SELECT *
    FROM EMP E, SALGRADE S
    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- 자체 조인 SELF JOIN
SELECT *
    FROM EMP; -- MGR은 직속상관의 사원번호이다.
    
SELECT E1.ENAME, E1.JOB, E2.ENAME AS MANAGER
    FROM EMP E1, EMP E2  -- EMP를 하나 더 만들기. SELF JOIN★
    WHERE E1.MGR = E2.EMPNO;

-- 왼쪽 외부 조인 사용하기
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
        E2.EMPNO AS MGR_EMPNO,
        E2.ENAME AS MGR_ENAME
    FROM EMP E1, EMP E2
    WHERE E1.MGR = E2.EMPNO(+)  -- + 기호 어느 한 쪽이 NULL이여도 강제로 출력하는 방식이다.
                                -- + 기호 있는 쪽은 전부 출력한다.
    ORDER BY E1.EMPNO;

-- 오른쪽 외부 조인 사용하기
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
        E2.EMPNO AS MGR_EMPNO,
        E2.ENAME AS MGR_ENAME
    FROM EMP E1, EMP E2
    WHERE E1.MGR(+) = E2.EMPNO
    ORDER BY E1.EMPNO;

-- 서브쿼리 SUBQUERY
-- 서브쿼리 특징 1. 괄호()로 묶어서 사용한다. 2. 아웃풋의 자료형과 서브쿼리의 자료형이 동일해야 한다.
-- 1. 사원 이름이 JONES인 사원의 급여?
SELECT ENAME, SAL
    FROM EMP
    WHERE ENAME = 'JONES';

-- 2. 급여가 2975 보다 높은 사원 정보?
SELECT *
    FROM EMP
    WHERE SAL > 2975;
    
-- 1번 문제와 2번 문제 합치기
-- 쿼리 안에 쿼리가 들어가 있다. = 서브쿼리
SELECT ENAME
    FROM EMP
    WHERE SAL > (SELECT SAL   -- 이 부분이 서브쿼리
                 FROM EMP
                 WHERE ENAME = 'JONES');

-- 사원 이름이 ALLEN인 사원의 추가 수당 보다 많은 추가 수당을 받는 사원 정보를 구하기
SELECT *
    FROM EMP
    WHERE COMM > (SELECT COMM
                    FROM EMP
                    WHERE ENAME = 'ALLEN');

-- 고용일이 ALLEN보다 늦은 사원정보는?
SELECT *
    FROM EMP
    WHERE HIREDATE > (SELECT HIREDATE
                        FROM EMP
                        WHERE ENAME = 'ALLEN');