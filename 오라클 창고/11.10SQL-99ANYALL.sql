SELECT * FROM EMP;
SELECT * FROM DEPT;

-- EMP의 ENAME, DEPT의 LOC를 출력하기
SELECT E.ENAME, D.LOC
FROM EMP E, DEPT D;

-- EMP의 ENAME, DEPT의 LOC, DEPTNO 3개의 칼럼을 출력하기
SELECT E.ENAME, E.DEPTNO, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- EMP의 ENAME, DEPT의 LOC, DEPTNO 3개의 칼럼을 SAL가 3000이상인 사람을 출력하기.
SELECT E.ENAME, E.DEPTNO, D.LOC, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND SAL >= 3000;

-- 모든 사람의 이름과 직책과 매니저 이름 이렇게 3개의 칼럼을 출력하기
SELECT E1.ENAME, E1.JOB, E2.ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO;

-- LEFT JOIN은 왼쪽은 빠짐없이 들어가고 오른쪽은 부가적
SELECT E1.ENAME, E1.JOB, E1.MGR, E2.EMPNO, E2.ENAME AS MGR_NAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+); --(+)안붙은쪽은 무조건 다 나오고 붙은쪽은 NULL값이여도 출력된다.

----------------------------진도 시작--------------------------------------------
--★ SQL-99 표준문법
-- 공통인 DEPTNO에 명시를 안해준게 포인트
SELECT E.EMPNO, E.ENAME, DEPTNO, D.DNAME, D.LOC
FROM EMP E NATURAL JOIN DEPT D;

-- JOIN~USING
SELECT E.EMPNO, E.ENAME, DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D
USING (DEPTNO)
WHERE E.SAL >= 3000;

-- JOIN~ON
SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D
ON (E.DEPTNO = D.DEPTNO);

-- 외부 조인을 SQL-99로 작성
SELECT E1.ENAME, E1.JOB, E1.MGR, E2.EMPNO, E2.ENAME
FROM EMP E1 LEFT OUTER JOIN EMP E2
ON (E1.MGR = E2.EMPNO);

SELECT E1.ENAME, E1.JOB, E1.MGR, E2.EMPNO, E2.ENAME
FROM EMP E1 RIGHT OUTER JOIN EMP E2
ON (E1.MGR = E2.EMPNO);

SELECT E1.ENAME, E1.JOB, E1.MGR, E2.EMPNO, E2.ENAME
FROM EMP E1 FULL OUTER JOIN EMP E2
ON (E1.MGR = E2.EMPNO);

-- SUBQUERY
SELECT * FROM EMP
WHERE SAL > 2975;

SELECT ENAME, SAL
FROM EMP
WHERE ENAME = 'JONES';
-- 합치기
SELECT * FROM EMP
WHERE SAL > (SELECT SAL
                FROM EMP
                WHERE ENAME = 'JONES');

-- 1분 복습
SELECT * FROM EMP
WHERE COMM > (SELECT COMM
                FROM EMP
                WHERE ENAME = 'ALLEN');

-- HIREDATE가 SCOTT 보다 이전 입사자 정보
SELECT * FROM EMP
WHERE HIREDATE > (SELECT HIREDATE
                    FROM EMP
                    WHERE ENAME = 'SCOTT');

-- 평균 SAL
SELECT * FROM EMP
WHERE SAL > (SELECT AVG(SAL)
                FROM EMP);

-- 서브쿼리 안에서 함수를 사용한 경우
-- 평균 급여보다 높은 사람의 이름, 직책, 부서이름(DNAME)과 근무지(LOC)를 출력하기
SELECT E.ENAME, E.JOB, D.DNAME, D.LOC 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO   -- 테이블을 이어주는 징검다리(매개)이다.
    AND SAL > (SELECT AVG(SAL) FROM EMP);

-- 평균 급여보다 작거나 같은 급여를 받고 있는 20번 부서의 사원 정보
SELECT E.ENAME, E.JOB, D.DNAME, D.LOC 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND SAL <= (SELECT AVG(SAL) FROM EMP)
    AND E.DEPTNO = 20;

-- 직책별로 그룹을 짓고 평균 내기
SELECT AVG(SAL)
FROM EMP
GROUP BY JOB;
-- 잘못된 예시
SELECT E.ENAME, E.JOB, D.DNAME, D.LOC 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND SAL <= (SELECT AVG(SAL) FROM EMP GROUP BY JOB) --GROUP BY를 붙였기 때문에 오류
                                                       --오류가 나는 이유는 왼쪽은 SAL이라고 비교대상이 1개이지만 GROUP BY JOB은 비교대상이 여러개이기 때문에 오류가 발생한다.
    AND E.DEPTNO = 20;

-- DEPTNO가 20번인 사원의 이름 급여는?
SELECT ENAME, SAL
FROM EMP
WHERE DEPTNO = 20;
-- 부서번호 30번
SELECT ENAME, SAL
FROM EMP
WHERE DEPTNO = 30;
-- 부서번호가 20번, 30번인 사원의 이름과 급여?
SELECT ENAME, SAL
FROM EMP
WHERE DEPTNO IN (20, 30);
-- WHERE DEPTNO == (20, 30); 도 가능

-- 단일행
SELECT * FROM EMP
WHERE SAL > (SELECT AVG(SAL)
                FROM EMP);
-- 다중행
SELECT * FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
                FROM EMP
                GROUP BY DEPTNO);

-- 부서별 최고금액


-- ANY, ALL, SOME
-- ANY
SELECT * FROM EMP
WHERE SAL = ANY (SELECT MAX(SAL)  -- = 하면 에러 = ANY 말 그대로 '하나라도'라는 뜻으로 오류가 발생하지 않는다.
                FROM EMP
                GROUP BY DEPTNO);

-- 30번 부서의 최대급여보다 작은 사람들
SELECT *FROM EMP
WHERE SAL < ANY (SELECT SAL  -- 30번 부서의 최대 급여인 2850보다 작은 월급을 받는 사람이 나온다.
                             -- 최대급여 보는 방법은 서브쿼리만 실행시키기
            FROM EMP
            WHERE DEPTNO = 30);
-- 30번 부서의 최소급여보다 큰 사람들
SELECT *FROM EMP
WHERE SAL > ANY (SELECT SAL  
            FROM EMP
            WHERE DEPTNO = 30);

-- ALL
-- 모든 값보다 작아야한다.
-- 최대치보다 큰 사람만 출력되야한다.
SELECT *FROM EMP
WHERE SAL > ALL (SELECT SAL  
            FROM EMP
            WHERE DEPTNO = 30);
-- > ANY~ : 최소보다 큰~
-- < ANY~ : 최대보다 작은~
-- > ALL : 최소치보다 작은
-- < ALL : 최대치보다 큰

-- EXISTS
SELECT * FROM EMP
WHERE EXISTS(SELECT DNAME
                FROM DEPT
                WHERE DEPTNO = 10);