--
-- Copyright (c) Oracle Corporation 1988, 1999.  All Rights Reserved.
--
--  NAME
--    demobld.sql
--
-- DESCRIPTION
--   This script creates the SQL*Plus demonstration tables in the
--   current schema.  It should be STARTed by each user wishing to
--   access the tables.  To remove the tables use the demodrop.sql
--   script.
--
--  USAGE
--       SQL> START demobld.sql
--
--

SET TERMOUT ON
PROMPT Building demonstration tables.  Please wait.
SET TERMOUT OFF

CREATE TABLE BONUS
        (ENAME VARCHAR2(10),
         JOB   VARCHAR2(9),
         SAL   NUMBER,
         COMM  NUMBER);

CREATE TABLE EMP
       (EMPNO NUMBER(4) NOT NULL,
        ENAME VARCHAR2(10),
        JOB VARCHAR2(9),
        MGR NUMBER(4),
        HIREDATE DATE,
        SAL NUMBER(7, 2),
        COMM NUMBER(7, 2),
        DEPTNO NUMBER(2));

INSERT INTO EMP VALUES
        (7369, 'SMITH',  'CLERK',     7902,
        TO_DATE('17-12-1980', 'DD-MM-YYYY'),  800, NULL, 20);
INSERT INTO EMP VALUES
        (7499, 'ALLEN',  'SALESMAN',  7698,
        TO_DATE('20-02-1981', 'DD-MM-YYYY'), 1600,  300, 30);
INSERT INTO EMP VALUES
        (7521, 'WARD',   'SALESMAN',  7698,
        TO_DATE('22-02-1981', 'DD-MM-YYYY'), 1250,  500, 30);
INSERT INTO EMP VALUES
        (7566, 'JONES',  'MANAGER',   7839,
        TO_DATE('2-04-1981', 'DD-MM-YYYY'),  2975, NULL, 20);
INSERT INTO EMP VALUES
        (7654, 'MARTIN', 'SALESMAN',  7698,
        TO_DATE('28-09-1981', 'DD-MM-YYYY'), 1250, 1400, 30);
INSERT INTO EMP VALUES
        (7698, 'BLAKE',  'MANAGER',   7839,
        TO_DATE('1-05-1981', 'DD-MM-YYYY'),  2850, NULL, 30);
INSERT INTO EMP VALUES
        (7782, 'CLARK',  'MANAGER',   7839,
        TO_DATE('9-06-1981', 'DD-MM-YYYY'),  2450, NULL, 10);
INSERT INTO EMP VALUES
        (7788, 'SCOTT',  'ANALYST',   7566,
        TO_DATE('09-12-1982', 'DD-MM-YYYY'), 3000, NULL, 20);
INSERT INTO EMP VALUES
        (7839, 'KING',   'PRESIDENT', NULL,
        TO_DATE('17-11-1981', 'DD-MM-YYYY'), 5000, NULL, 10);
INSERT INTO EMP VALUES
        (7844, 'TURNER', 'SALESMAN',  7698,
        TO_DATE('8-09-1981', 'DD-MM-YYYY'),  1500, NULL, 30);
INSERT INTO EMP VALUES
        (7876, 'ADAMS',  'CLERK',     7788,
        TO_DATE('12-01-1983', 'DD-MM-YYYY'), 1100, NULL, 20);
INSERT INTO EMP VALUES
        (7900, 'JAMES',  'CLERK',     7698,
        TO_DATE('3-12-1981', 'DD-MM-YYYY'),   950, NULL, 30);
INSERT INTO EMP VALUES
        (7902, 'FORD',   'ANALYST',   7566,
        TO_DATE('3-12-1981', 'DD-MM-YYYY'),  3000, NULL, 20);
INSERT INTO EMP VALUES
        (7934, 'MILLER', 'CLERK',     7782,
        TO_DATE('23-01-1982', 'DD-MM-YYYY'), 1300, NULL, 10); 

CREATE TABLE DEPT
       (DEPTNO NUMBER(2),
        DNAME VARCHAR2(14),
        LOC VARCHAR2(13) );

INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');

CREATE TABLE SALGRADE
        (GRADE NUMBER,
         LOSAL NUMBER,
         HISAL NUMBER);

INSERT INTO SALGRADE VALUES (1,  700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);

COMMIT;

SET TERMOUT ON
PROMPT Demonstration table build is complete. 




--(1) EMP???? ???? ?????? ????????
SELECT * FROM EMP;

--(2) ?????? ????(COMM ????)
SELECT ENAME, SAL*12 AS ANN
    FROM EMP;

--(3) ????(COMM ????)?? ???????????? ????
SELECT ENAME, SAL*12 AS ANN
    FROM EMP
    ORDER BY ANN DESC;

--(4) ????????, ????, ?????????? ???????????? ????, ?????? ????????
SELECT ENAME, DEPTNO, SAL*12 AS ANN
    FROM EMP
    ORDER BY DEPTNO DESC, ANN ASC;

--(5) ???? ?????? ????????(????????)
SELECT DISTINCT JOB
    FROM EMP;

--(6) ?????????? 30?? ???? ????
SELECT *
    FROM EMP
    WHERE DEPTNO = 30;

--(7) ?????????? 30???? ?????? 'CLERK'?? ????????
SELECT *
    FROM EMP
    WHERE DEPTNO = 30
        AND JOB = 'CLERK';

--(8) SAL ?? 3000 ???????? ?????? CLERK
SELECT *
    FROM EMP
    WHERE SAL >= 3000
        AND JOB = 'ANALYST';

--(9) ?????????? 30?? ???? ???? ????
SELECT *
    FROM EMP
    WHERE DEPTNO <> 30;

--(10) ?????? CLERK ?????? ANALYST ?????? MANAGER ?? ????
SELECT *
    FROM EMP
    WHERE JOB IN ('CLERK', 'ANALYST', 'MANAGER');

--(11) 10???? ????
SELECT *
    FROM EMP
    WHERE JOB NOT IN ('CLERK', 'ANALYST', 'MANAGER');

--(12) ?????? 2000 ~ 3000 ?? ????
SELECT *
    FROM EMP
    WHERE SAL BETWEEN 2000 AND 3000;

--(13) ENAME ?????? ?????? 'L'?? ????
SELECT *
    FROM EMP
    WHERE ENAME LIKE '_L%';

--(14) ENAME, SAL, COMM?? ????????
SELECT ENAME, SAL, COMM
    FROM EMP;

--(15) 14?? ?????? ?????? COMM?? ?????? ?????? ????????
SELECT ENAME, SAL, COMM
    FROM EMP
    WHERE COMM IS NULL;

--(16) 15?? ?????? ????
SELECT ENAME, SAL, COMM
    FROM EMP
    WHERE COMM IS NOT NULL;

--(17) ?????? ???????? ???????? 'SCOTT'?? ????
SELECT *
    FROM EMP
    WHERE UPPER(ENAME) = 'SCOTT';

--(18) 3*3?
SELECT 3*3
    FROM DUAL;

--(19) ???? ?????? ????
SELECT SYSDATE
    FROM DUAL;

--(20) ?????? ????
SELECT DEPTNO, SUM(SAL)
    FROM EMP
    GROUP BY DEPTNO;

--(21) ???????? 30???? ??????
SELECT COUNT(ENAME)
    FROM EMP
    WHERE DEPTNO = 30;

--(22) ?????????? 30???? SAL?
SELECT ENAME, SAL
    FROM EMP
    WHERE DEPTNO = 30;

--(23) 22?? ?????? ?????? ?????????? ???? ?????? SAL
SELECT ENAME, SAL
    FROM EMP
    WHERE SAL = (SELECT MAX(SAL)
                    FROM EMP
                    WHERE DEPTNO = 30);

--(24) ?????????? 2000 ?????? ?????? ????, ????????, ?????? ???????? ????
SELECT ENAME, AVG(SAL), DEPTNO
    FROM EMP
    GROUP BY ENAME, DEPTNO
    ORDER BY DEPTNO;

--(25) 24?? ?????? ?????? ?????? ?????? ?????????? 2500 ?????? ????
SELECT ENAME, AVG(SAL), DEPTNO
    FROM EMP
    WHERE SAL >= 2000
    GROUP BY ENAME, DEPTNO
    HAVING AVG(SAL) >= 2500
    ORDER BY DEPTNO;