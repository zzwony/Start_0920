-- 1981년 6월 1일 이후에 입사한 사원정보
SELECT * FROM EMP
WHERE HIREDATE >= TO_DATE('1981/06/01');

--P177
SELECT SUM(SAL) FROM EMP;
-- SUM은 NULL 값을 빼고 구해준다.
SELECT SUM(COMM) FROM EMP;

-- 사원 전체 수는?
SELECT COUNT(ENAME) FROM EMP;
-- 부서번호가 10번인 사원 전체 수는?
SELECT COUNT(ENAME) FROM EMP
WHERE DEPTNO = 10;
-- COMM을 받는 사원전체수
SELECT COUNT(ENAME)
    FROM EMP
    WHERE COMM IS NOT NULL;
-- 사원 급여 최댓값
SELECT MAX(SAL) FROM EMP;
-- 부서별 사원 급여 최댓값
SELECT MAX(SAL)
    FROM EMP
    GROUP BY DEPTNO;
-- 이름의 두번째 글자가 A인 사원
SELECT AVG(SAL)
    FROM EMP
    WHERE ENAME LIKE '_A%';

-- 부서별 급여의 최솟값은?
SELECT DEPTNO, JOB, MIN(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB;

-- SELECT ENAME, AVG(SAL)이렇게 시작하면 에러 발생.이름은 여러개인데 평균 값은 하나여서 갯수가 맞지 않는다.

-- 급여가 2000이상인 직운 중에서 부서별, 직책별 급여의 평균값?
SELECT AVG(SAL)
    FROM EMP
    WHERE SAL >= 2000
    GROUP BY DEPTNO, JOB;

--P191
-- 부서별, 직책별 급여의 평균이 2000이상인 그룹의 평균값?
SELECT DEPTNO, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 2000;
-- 급여가 2000 이상인 직원 중에서 부서별, 직책별 급여의 평균이 3000 이상인 그룹의 평균값
SELECT AVG(SAL), DEPTNO, JOB
    FROM EMP
    WHERE SAL >= 2000
    GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 3000
    ORDER BY AVG(SAL);

-- P195 ROLLUP
SELECT DEPTNO, JOB, ROUND(AVG(SAL))
    FROM EMP
    GROUP BY ROLLUP(DEPTNO, JOB);

-- 직책별로 인원이 2명 이상인 직책의 인원수?
SELECT JOB, COUNT(ENAME)
    FROM EMP
    GROUP BY JOB
    HAVING COUNT(ENAME) >= 2;

-- 두 테이블 이어주기
-- 사원 이름과, 직책, 근무지를 출력하기
SELECT E.ENAME, E.JOB, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- 급여가 2000 이상인 사원 이름과 직책, 근무지는?
SELECT E.ENAME, E.JOB, D.LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND SAL >= 2000
    AND COMM IS NULL;

-- P221 조인 종류
SELECT E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME, D.LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
        AND E.SAL <= 2500
        AND E.EMPNO <= 9999
    ORDER BY E.EMPNO;

-- 비등가 조인
SELECT *
    FROM SALGRADE;

SELECT ENAME, S.*
    FROM EMP, SALGRADE S;

SELECT *
    FROM EMP E, SALGRADE S
    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;
    
-- SELF JOIN
-- 사원이름, 직책, 매니저 이름을 출력하기
SELECT E1.ENAME, E1.JOB, E2.ENAME AS MGR_NAME
    FROM EMP E1, EMP E2
    WHERE E1.MGR = E2.EMPNO;

-- OUTER JOIN
SELECT E1.ENAME, E1.MGR, E2.EMPNO
    FROM EMP E1, EMP E2
    WHERE E1.MGR = E2.EMPNO(+);

SELECT E1.ENAME, E1.MGR, E2.EMPNO
    FROM EMP E1, EMP E2
    WHERE E1.MGR(+) = E2.EMPNO;

-- SQL 99 방식
-- 3가지의 방법이 있는데 원하는걸로 사용하면 된다.(3가지 다 똑같음)
-- NATURAL JOIN(방법1)
-- 공통컬럼에 대해서 E 등으로 명시를 하지 않으면 에러가 발생했지만
-- 이 조인은 오히려 써주면 에러가 발생한다.
-- 또 특이한 점은 WHERE에 써주는것이 아니라 FROM절에 써준다.
-- 공통된 칼럼이 1개가 아니라 2개가 되면 내가 의도하지 않은 조인 방식이 될 수 있다.(방법2,3을 사용하는것을 추천)
SELECT E.ENAME, D.LOC, DEPTNO
    FROM EMP E NATURAL JOIN DEPT D;

-- INNER JOIN(방법2, 디폴트가 INNER JOIN 이다.)
-- 명시적인 방법이다.
SELECT E.ENAME, D.LOC, DEPTNO
    FROM EMP E INNER JOIN DEPT D
    USING (DEPTNO); ---어느 칼럼인지 명시적으로 찾아가게 적어준것이다.
                    ---이 칼럼을 써서 조인해라
                    ---괄호가 꼭 들어가야하니 주의하기

-- JOIN ON(방법3)
-- 명시적인 방법이다.
SELECT E.ENAME, D.LOC
    FROM EMP E JOIN DEPT D 
        ON(E.DEPTNO = D.DEPTNO) ---WHERE절을 사용하지 않는다.(공통의 칼럼을 적어주고 있다.)
    WHERE E.SAL >= 2000     ---그 밑에 조건을 붙인다.(칼럼의 조건을 제한하고 있다.)
        AND D.DEPTNO = 10;

-- 외부조인
SELECT E1.ENAME, E1.MGR, E2.EMPNO
    FROM EMP E1 LEFT OUTER JOIN EMP E2  ---LEFT인지 RIGHT인지 명시해줘야한다.
                                        ---왼쪽 다 살리고 EMP E2가 값이 없으면 NULL값으로 채워라
        ON (E1.MGR = E2.EMPNO);

SELECT E1.ENAME, E1.MGR, E2.EMPNO
    FROM EMP E1 RIGHT JOIN EMP E2
        ON (E1.MGR = E2.EMPNO);

--P237
--SQL-99 조인 방식에서 새 개 이상의 테이블을 조인할 때
--A JOIN B ON (조건)
--  JOIN C ON (조건)
--  JOIN D ON (조건)

-- P239
-- Q1
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL
    FROM EMP E, DEPT D
    WHERE D.DEPTNO = E.DEPTNO
        AND SAL > 2000
    ORDER BY DEPTNO;

-- Q2
SELECT D.DEPTNO, D.DNAME, ROUND(AVG(SAL)) AS AVG_SAL, MAX(SAL) AS MAX_SAL, MIN(SAL) AS MIN_SAL, COUNT(*) AS CNT
    FROM EMP E, DEPT D
    WHERE D.DEPTNO = E.DEPTNO
    GROUP BY D.DEPTNO, D.DNAME;  --그룹을 지어주는것이 SELECT 절에 들어가야한다. 그래서 E.ENAME이라고 하면 오류발생

-- 서브쿼리 SUBQUERY
-- 급여가 2975 보다 큰 사원의 이름
SELECT ENAME
    FROM EMP
    WHERE SAL > 2975;
-- 급여가 10번 부서의 평균 급여 보다 큰 사원의 이름은?
SELECT ENAME
    FROM EMP
    WHERE SAL > (SELECT AVG(SAL)
                    FROM EMP
                    WHERE DEPTNO = 10);
-- 입사일이 10번 부서의 최근 신입보다 빨리 입사한 사원정보
SELECT *
    FROM EMP
    WHERE HIREDATE > (SELECT MAX(HIREDATE)
                        FROM EMP
                        WHERE DEPTNO = 10);

-- 근무부서가 10번이거나 20번이거나 30번인 사원 정보?
SELECT *
    FROM EMP
    WHERE DEPTNO IN (10,20,30);

-- 근무부서 번호가 15보다 큰 부서의 사원 이름과 부서번호
SELECT DEPTNO, ENAME
    FROM EMP
    WHERE DEPTNO > 15;

SELECT ENAME, DEPTNO
    FROM EMP
    WHERE DEPTNO IN (SELECT DEPTNO
                        FROM EMP
                        WHERE DEPTNO > 15);

-- P252
SELECT *
    FROM EMP
    WHERE SAL < ANY(SELECT SAL  --- 최댓값보다 작은 값이 하나라도 있으면 출력한다는 ANY(등호가 반대면 최솟값보다 큰 값이 있으면 출력
                        FROM EMP
                        WHERE DEPTNO = 30);
                        
-- 최댓값보다 큰, 최솟값보다 작으면 출력
SELECT *
    FROM EMP
    WHERE SAL > ALL(SELECT SAL  
                        FROM EMP
                        WHERE DEPTNO = 30);

-- 괄호 안에 값이 있는지 없는지 확인하는 용도가 EXISTS
SELECT*
    FROM EMP
    WHERE EXISTS (SELECT DNAME
                    FROM DEPT
                    WHERE DEPTNO = 50);

SELECT *
    FROM EMP
    WHERE HIREDATE < ALL (SELECT HIREDATE
                            FROM EMP
                            WHERE DEPTNO = 10);

SELECT *
    FROM EMP
    WHERE (DEPTNO, SAL) IN(SELECT DEPTNO, MAX(SAL)
                        FROM EMP
                        GROUP BY DEPTNO);

-- 인라인 뷰
-- FROM 절에 잇는 서브쿼리 이다.
SELECT E10.EMPNO, E10.ENAME, D.DNAME, D.LOC
    FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10,
            (SELECT * FROM DEPT) D
    WHERE E10.DEPTNO = D.DEPTNO;
-- WITH
-- 스칼라 서브쿼리

--P 262              
SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME
    FROM EMP E, DEPT D
    WHERE D.DEPTNO = E.DEPTNO
        AND JOB = (SELECT JOB FROM EMP 
                    WHERE ENAME = 'ALLEN'); 


--P266
CREATE TABLE DEPT_TEMP
    AS SELECT * FROM DEPT;

INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
                VALUES(50, 'DATABASE', 'SEOUL');

SELECT * FROM DEPT_TEMP;

