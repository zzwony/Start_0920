---- �������� ����
-- DML: select, insert, update, delete
-- DDL: create table, alter table, drop table
-- DCL: grant, revoke
-- TCL: commit(���� ����), rollback(���� ����)

--p73
DESC EMP;
DESC DEPT;

SELECT * FROM EMP;

SELECT EMPNO, DEPTNO
FROM EMP;

--DISTINCT
SELECT DISTINCT DEPTNO
FROM EMP;

--��Ī ���ϱ�
SELECT ENAME, SAL, SAL*12 AS ANNUAL
FROM EMP;

-- ORDER BY
SELECT ENAME, SAL, SAL*12 AS ANNUAL
    FROM EMP
ORDER BY SAL;
--��������, ��������
SELECT DEPTNO, SAL
    FROM EMP
ORDER BY DEPTNO ASC, SAL DESC;

-- WHERE
--�μ���ȣ�� 30�� ������
SELECT *
    FROM EMP
WHERE DEPTNO = 30;
-- AND,OR
SELECT *
    FROM EMP
WHERE DEPTNO = 30
    AND JOB = 'SALESMAN';

-- ��� ������
--�޿��� 2500�̻��̰� ������ ANALYST�� ��� ����
SELECT * 
    FROM EMP
WHERE SAL >= 2500
    AND JOB = 'ANALYST';
-- NOT EQUQL
SELECT * 
    FROM EMP
WHERE DEPTNO <> 10;

--NOT(�� ���� ������)
--�� IN ������
--BETWEEN A AND B

--LIKE �����ڿ� ���ϵ� ī��
-- %, '_'
-- ��� �̸��� �� ��° ���ڰ� A�� ���
SELECT ENAME
    FROM EMP
WHERE ENAME LIKE '_A%';

-- IS NULL ������
--COMM�� ���� ����ִ� �����
SELECT *
    FROM EMP
WHERE COMM IS NULL;
-- IS NOT NULL (�ݴ�)

--���� ������ UNION
--SUBSTR ���ڿ� �Ϻθ� ������(���� ������ ����)
--INSTR
--REPLACE
--LPAD, RPAD

--P142
SELECT CONCAT(EMPNO, DEPTNO),
    CONCAT(EMPNO, CONCAT(':', 'ENAME'))
    FROM EMP
WHERE ENAME = 'SCOTT';

--P146
-- 15�� 4�� ���� ������
SELECT MOD(15,4)
FROM DUAL;

-- ��¥ �����͸� �ٷ�� �Լ�
-- ���� �ý��۵���Ʈ��?
SELECT SYSDATE
FROM DUAL;
-- ADD_MONTHS

--P162
SELECT SAL,
    TO_CHAR(SAL, '$999,999') AS SAL_$
FROM EMP;
--TO_DATE

--NULL ó�� �Լ�
--NVL
-- COMM Į���� 0���� �ٲ㼭 ����ϱ�
SELECT EMPNO, ENAME, JOB, NVL(COMM, 0)
FROM EMP
WHERE COMM IS NULL;
-- NVL2
SELECT EMPNO, ENAME, JOB, NVL(COMM, 0), NVL2(COMM, 'O', 'X') AS NVL2 --���� ������ O, ������ X
FROM EMP;
