-- SYSDATE 로 오늘 날짜 시간은?
SELECT SYSDATE
FROM DUAL;

-- 입사 120개월인 사원의 이름과 입사날짜?
SELECT ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 120) AS YEARS_10
FROM EMP;

SELECT ENAME, HIREDATE
FROM EMP
WHERE ADD_MONTHS(HIREDATE, 120) = SYSDATE;  --출력이 안된다는것은 값이 없다는 뜻

-- 2022/11/08/ 09:21:23 으로 출력하기
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS')
FROM DUAL;

-- 달러표시가 있게 급여 출력하기
SELECT SAL,
    TO_CHAR(SAL, '$999,999') AS 달러표시
FROM EMP;

-- 문자를 숫자로
SELECT '1300' + '1500'   --1,300 + 1,500는 오류 발생
FROM DUAL;
-- , 넣어서 가능하게 만들기
SELECT TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999') AS TO_N
FROM DUAL;

-- 문자를 날짜로 
-- '2022-11-08'을 날짜 데이터로 바꾸기
SELECT TO_DATE('2022-11-08', 'YYYY-MM-DD') AS TODAY
FROM DUAL;

-- '1981-06-01' 이후에 입사한 사원들의 부서와 이름
SELECT ENAME, DEPTNO
FROM EMP
WHERE HIREDATE > TO_DATE('1981/06/01', 'YYYY-MM-DD');

-- COMM
SELECT COMM FROM EMP;
-- SAL 과 COMM의 합은?
-- COMM의 NULL을 0으로 바꾸기
SELECT SAL, COMM, SAL + NVL(COMM, 0)
FROM EMP;

-- SAL 급여 합계 총 합
SELECT SUM(SAL)
FROM EMP;
-- 사원은 모두 몇 명?
SELECT COUNT(ENAME)
FROM EMP;
-- 부서번호가 20번인 사람은 몇 병?
SELECT COUNT(DEPTNO)
FROM EMP
WHERE DEPTNO = 20;
-- COMM을 받지 못한(값이 NULL) 사람의 부서번호, 직책, 이름은?
SELECT DEPTNO, JOB, ENAME,
    NVL(COMM, 0)
FROM EMP;
-- 부서번호가 20번인 사람의 최고 급여는?
SELECT MAX(SAL)
FROM EMP
WHERE DEPTNO = 20;
-- 부서번호가 20번인 사람의 가장 최근 입사자는?
SELECT MAX(HIREDATE)
FROM EMP
WHERE DEPTNO = 20;
-- 부서번호가 20번의 평균급여는?
SELECT AVG(SAL)
FROM EMP
WHERE DEPTNO = 20;

-------------------------오늘 진도-----------------------------------------------
-- 부서별 평균 급여
SELECT DEPTNO, ROUND(AVG(SAL))
FROM EMP
GROUP BY DEPTNO;

-- 부서별 직책별 평균 급여
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB;

-- HAVING(ORDER BY는 가급적 사용을 피하기)
SELECT DEPTNO, JOB, ROUND(AVG(SAL))
FROM EMP
GROUP BY DEPTNO,JOB
HAVING AVG(SAL) >= 2000 -- 이 수는 부서와 직업별의 평균급여이다.
                        -- 그래서 여기 말고 위에 붙이면 에러 발생
ORDER BY DEPTNO;  -- 그저 정렬한다. 위치는 맨 마지막에!

-- WHERE과 HAVING 차이
SELECT DEPTNO, JOB, ROUND(AVG(SAL))
FROM EMP
WHERE SAL > 2000
GROUP BY DEPTNO,JOB;    -- WHERE과 GROUP BY가 같이 있어서 오류를 예상했지만 그러지 않았다.
                        -- 2000이상의 대해서 그룹을 짓는다는거니까 이상할것이 없다.
    
SELECT DEPTNO, JOB, ROUND(AVG(SAL))
FROM EMP
WHERE SAL > 2000
GROUP BY DEPTNO,JOB
HAVING AVG(SAL) > 2500  -- 출력결과: 정상
ORDER BY DEPTNO;

SELECT DEPTNO, JOB, ROUND(AVG(SAL))
FROM EMP
GROUP BY DEPTNO,JOB
HAVING AVG(SAL) > 2500
ORDER BY DEPTNO;

-- 부서별 직책의 평균 급여가 500이상인 사원들의 부서 번호, 직책, 부서별 직책의 평균 급여 출력하기
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 500
ORDER BY DEPTNO;
-- ROLLUP, CUBE
-- ROLLUP
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO), JOB
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL)
FROM EMP
GROUP BY DEPTNO, ROLLUP(JOB)
ORDER BY DEPTNO, JOB;

-- CUBE
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)  -- ROLLUP은 부분합인데 CUBE는 JOB 별로의 COUNT와 MAX(SAL)에 대한 정보가 더 나와있다.
ORDER BY DEPTNO, JOB;
