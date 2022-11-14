---- 전반적인 복습
-- DML: select, insert, update, delete
-- DDL: create table, alter table, drop table
-- DCL: grant, revoke
-- TCL: commit(권한 승인), rollback(승인 뺏음)

--p73
DESC EMP;
DESC DEPT;

SELECT * FROM EMP;

SELECT EMPNO, DEPTNO
FROM EMP;

--DISTINCT
SELECT DISTINCT DEPTNO
FROM EMP;

--별칭 정하기
SELECT ENAME, SAL, SAL*12 AS ANNUAL
FROM EMP;

-- ORDER BY
SELECT ENAME, SAL, SAL*12 AS ANNUAL
    FROM EMP
ORDER BY SAL;
--내림차순, 오름차순
SELECT DEPTNO, SAL
    FROM EMP
ORDER BY DEPTNO ASC, SAL DESC;

-- WHERE
--부서번호가 30인 데이터
SELECT *
    FROM EMP
WHERE DEPTNO = 30;
-- AND,OR
SELECT *
    FROM EMP
WHERE DEPTNO = 30
    AND JOB = 'SALESMAN';

-- 산술 연산자
--급여가 2500이상이고 직업이 ANALYST인 사원 정보
SELECT * 
    FROM EMP
WHERE SAL >= 2500
    AND JOB = 'ANALYST';
-- NOT EQUQL
SELECT * 
    FROM EMP
WHERE DEPTNO <> 10;

--NOT(논리 부정 연산자)
--★ IN 연산자
--BETWEEN A AND B

--LIKE 연산자와 와일드 카드
-- %, '_'
-- 사원 이름의 두 번째 글자가 A인 사원
SELECT ENAME
    FROM EMP
WHERE ENAME LIKE '_A%';

-- IS NULL 연산자
--COMM의 값이 비어있는 사람들
SELECT *
    FROM EMP
WHERE COMM IS NULL;
-- IS NOT NULL (반댓말)

--집합 연산자 UNION
--SUBSTR 문자열 일부를 추출함(자주 쓰이진 않음)
--INSTR
--REPLACE
--LPAD, RPAD

--P142
SELECT CONCAT(EMPNO, DEPTNO),
    CONCAT(EMPNO, CONCAT(':', 'ENAME'))
    FROM EMP
WHERE ENAME = 'SCOTT';

--P146
-- 15를 4로 나눈 나머지
SELECT MOD(15,4)
FROM DUAL;

-- 날짜 데이터를 다루는 함수
-- 현재 시스템데이트는?
SELECT SYSDATE
FROM DUAL;
-- ADD_MONTHS

--P162
SELECT SAL,
    TO_CHAR(SAL, '$999,999') AS SAL_$
FROM EMP;
--TO_DATE

--NULL 처리 함수
--NVL
-- COMM 칼럼을 0으로 바꿔서 출력하기
SELECT EMPNO, ENAME, JOB, NVL(COMM, 0)
FROM EMP
WHERE COMM IS NULL;
-- NVL2
SELECT EMPNO, ENAME, JOB, NVL(COMM, 0), NVL2(COMM, 'O', 'X') AS NVL2 --값이 있으면 O, 없으면 X
FROM EMP;
