CREATE TABLE DEPT_TEMP
    AS SELECT * FROM DEPT;

SELECT * FROM DEPT_TEMP;

-- 50, 'DATABASE', 'SEOUL'�� �߰��ϱ�
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
    VALUES(50, 'DATABASE', 'SEOUL');

-- 60, 'BUSAN'�� �߰��ϱ�
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
    VALUES(60, NULL, 'BUSAN');

DROP TABLE EMP_TEMP;
COMMIT;

-- EMP_TEMP �� ���̺� �����
CREATE TABLE EMP_TEMP
    AS SELECT *
        FROM EMP
        WHERE 1 <> 1;

SELECT * FROM EMP_TEMP;

-- EMPNO���� 1, HIREDATE���� ���� ��¥ �ֱ�
INSERT INTO EMP_TEMP(EMPNO, HIREDATE)
    VALUES(1, SYSDATE);
    
-- EMP���� DEPTNO�� 30�� ����� EMP_TEMP�� �ֱ�
INSERT INTO EMP_TEMP
    SELECT * 
        FROM EMP
        WHERE DEPTNO = 30;

SELECT *
    FROM DEPT_TEMP;

DROP TABLE DEPT_TEMP;
COMMIT;
-- DEPTNO�� 10�� ����� LOC�� 'SEOUL'�� �����ϱ�
UPDATE DEPT_TEMP
    SET LOC = 'SEOUL'
    WHERE DEPTNO = 10;

-- LOC�� BUSAN�� ������� DEPTNO 50����, DNAME�� SALES�� �����ϱ�
UPDATE DEPT_TEMP
    SET DEPTNO = 50,
        DNAME = 'SALES'
    WHERE LOC = 'BUSAN'; 

SELECT *
    FROM EMP_TEMP;

-- JOB = 'SALESMAN'�� �����ϱ�
DELETE FROM EMP_TEMP
    WHERE JOB = 'SALESMAN';

---------------------------------���� ����---------------------------------------
SELECT * FROM DEPT_TEMP;

DELETE FROM DEPT_TEMP
    WHERE DEPTNO = 50;
COMMIT;  -- Ŀ���� �ϸ� ������ ������ ����Ǿ SQL_PLUS�� �ԷµǸ� ����Ǿ� �ִ�.

UPDATE DEPT_TEMP
    SET LOC = 'SEOUL'
    WHERE DEPTNO = 30;

UPDATE DEPT_TEMP
    SET LOC = 'NEW YORK'
    WHERE DEPTNO = 10;  -- ���⼭ SQL_PLUS�� ���� �����ϸ� �𺧷��ۿ��� ���� �������̿��� ��� ���°� �ȴ�.
    
SELECT * FROM DEPT_TEMP;
COMMIT; -- Ŀ������ ����������� �÷������� ������ �����ϴ�.

-- P318
CREATE TABLE EMP_ALTER
    AS SELECT * FROM EMP;
    
SELECT * FROM EMP_ALTER;

ALTER TABLE EMP_ALTER
    ADD HP VARCHAR2(20);

ALTER TABLE EMP_ALTER
    RENAME COLUMN HP TO TEL;

ALTER TABLE EMP_ALTER
    MODIFY EMPNO NUMBER(5);

ALTER TABLE EMP_ALTER
    DROP COLUMN TEL;

SELECT * FROM EMP_ALTER;

--���̺� �̸� ����
RENAME EMP_ALTER TO EMP_RENAME;
SELECT * FROM EMP_RENAME;

--���̺� ������ ����
TRUNCATE TABLE EMP_RENAME;

-- ���̺� ����
DROP TABLE EMP_RENAME;

--��P335 �ε���
SELECT * FROM USER_INDEXES;  -- �ε��� ����

SELECT *
    FROM USER_IND_COLUMNS;

--�ε��� �����
CREATE INDEX IDX_EMP_SAL
    ON EMP(SAL);

--��
-- ���� �ο��ϱ�  ���⼭���� �ٽ� �ϱ�
-- system���� ���� �ؿ� �ڵ� ġ�� ���� �޾ƾ���.
GRANT CREATE VIEW TO SCOTT;

CREATE VIEW VW_EMP20
    AS (SELECT EMPNO, ENAME, JOB, DEPTNO
         FROM EMP
         WHERE DEPTNO = 20);

SELECT ENAME
    FROM VW_EMP20
    WHERE JOB = 'CLERK';

-- DEPTNO�� 20�� ����߿��� JOB�� CLERK�� ����� �ٹ�����?
SELECT D.LOC, V.ENAME, V.JOB 
    FROM DEPT D, VW_EMP20 V    -- ���Ⱑ �ζ��� ��
    WHERE D.DEPTNO = V.DEPTNO
        AND JOB = 'CLERK'; 

SELECT * 
    FROM USER_VIEWS;

-- �ǽ� 13-18
SELECT *
    FROM VW_EMP20;

-- �� ����� DROP VIEW

-- �ǽ� 13-20
-- ROWNUM
-- �ǻ� ��(���� Į�� �̶�� �θ���)
SELECT *
    FROM EMP;
    
SELECT ROWNUM, *
    FROM EMP;  --��� �ϸ� ���� �߻�, ������ ���� Į���� ��� �����̴�.

SELECT ROWNUM, EMP.*
    FROM EMP;  -- ��°�� ROWNUM�� ����� �ڵ����� ��ȣ�� �ο��ߴ�.

SELECT ROWNUM, EMP.*
    FROM EMP
    ORDER BY ENAME;  -- ENAME�� A-Z������ ���ĵǾ����� ROWNUM�� �̸��� ���� �������� ���׹��� ���δ�.

--P347 
-- �޿�(SAL)�� ���� 10���� ������������ �����ϱ�
SELECT ROWNUM, S.*
FROM (SELECT *
        FROM EMP
        ORDER BY SAL DESC) S
WHERE ROWNUM <= 10;

-- �� ����� �̸� ����
CREATE VIEW VW_EMP_SAL
    AS (SELECT *
        FROM EMP
        ORDER BY SAL DESC);   -- �����ϸ� ������ ���ȣ ��� ���� �߻�
                              -- ��ȣ�� �ִµ� �� ���ٰ� �ұ�? �׷��� ORDER BY�� ���� ���� ��Ű�� �� �۵� �ȴ�.
                              -- �ᱹ ��ȣ�� ������ �ƴϿ���.
CREATE VIEW VW_EMP_SAL
    AS (SELECT *
        FROM EMP);            -- �� ���������.
                              -- ��ȣ ���� ������� �� ���鶩 ORDER�� ���� �� ���� ������ ������ �߻��ߴ�.
                              -- ORDER �������� ��ȣ �ȿ� �־�����Ѵ�.
        
--�� ��Ģ�� ���� ������ �����ϴ� ������
-- �ǽ� 13-26
CREATE TABLE DEPT_SEQUENCE
    AS SELECT *
        FROM DEPT
        WHERE 1 <> 1;  --�����⸸ �����Դ�.

SELECT * FROM DEPT_SEQUENCE; -- ��°�� �����Ⱑ �������

INSERT INTO DEPT_SEQUENCE
    VALUES (5, 'DATABASE', 'SEOUL');

INSERT INTO DEPT_SEQUENCE
    VALUES (5, 'DATABASE', 'BUSAN');

-- ������ �����ϱ�
CREATE SEQUENCE SEQ_DEPT_SEQUENCE
    INCREMENT BY 2
    START WITH 10;

INSERT INTO DEPT_SEQUENCE
    VALUES (SEQ_DEPT_SEQUENCE.NEXTVAL, 'DATABASE', 'BUSAN');

SELECT * FROM DEPT_SEQUENCE;  -- INCREMENT BY ���п� �ڵ����� �����Ѵ�.
-- ���� ���� �ٲٰ� ������ ����� �ٽ� �������Ѵ�.

-- ����
SELECT SEQ_DEPT_SEQUENCE.CURRVAL
    FROM DUAL;

--������
SELECT SEQ_DEPT_SEQUENCE.NEXTVAL
    FROM DUAL;
    

-- ���Ǿ� 
-- �ǽ� p13-38
-- SYSYEM�� ���� �ο��ϱ�
CREATE SYNONYM E
    FOR EMP;

SELECT *
    FROM E;

SELECT *
    FROM VW_EMP_SAL;
    
CREATE SYNONYM V
    FOR VW_EMP_SAL;

SELECT * 
    FROM V;

DROP SYNONYM E;


-- P362
CREATE TABLE TABLE_NOTNULL(
      LOGIN_ID VARCHAR2(20)     NOT NULL,  --���̵�� ��й�ȣ�� NULL���� �Ǹ� �ȵȴٴ� ���������� �ɾ���.
      LOGIN_PWD VARCHAR2 (20)   NOT NULL,
      TEL       VARCHAR2 (20)
    );
    
INSERT INTO TABLE_NOTNULL
    VALUES('ID', 'PASS', '02-55');

SELECT *
    FROM TABLE_NOTNULL;

DROP TABLE TABLE_NOTNULL;
    
CREATE TABLE TABLE_NOTNULL(
      LOGIN_ID VARCHAR2(20)     UNIQUE,  --����ũ ������ �����ؾ��Ѵ�.
      LOGIN_PWD VARCHAR2 (20)   NOT NULL,
      TEL       VARCHAR2 (20)
    );
    
INSERT INTO TABLE_NOTNULL
    VALUES('ID', 'PASS', '');  -- ���� �߻�, �տ� ID�� ��� ������ ����ũ�� ����ǹǷ� ������ �߻��Ѵ�.
                                -- �׷��ٸ� ���̵� �Ⱦ���?
INSERT INTO TABLE_NOTNULL
    VALUES('', 'PASS', '');  -- �̷��� �ϸ� ���Եȴ�. ����ũ ���ǿ� ����� ������ NULL������ ��µȴ�.
                            -- ����ũ�� ������� �����鼭 NOT NULL�̷��� PRIMARY KEY(�⺻Ű)�� ������ �ȴ�.
                            
CREATE TABLE TABLE_NOTNULL(
      LOGIN_ID VARCHAR2(20)     PRIMARY KEY, -- �ߺ��Ǿ �ȵǰ� ���� ����־ �ȵȴ�.
      LOGIN_PWD VARCHAR2 (20)   NOT NULL,
      TEL       VARCHAR2 (20)
    );

INSERT INTO TABLE_NOTNULL
    VALUES('ID', 'PASS', '02-55');

INSERT INTO TABLE_NOTNULL
    VALUES('', 'PASS', '');  -- ������ �߻��Ҽ� �ۿ� ����. �⺻Ű ����.
    
-- P364 �ǽ� 14-5
-- ���� ���� Ȯ��
SELECT *
    FROM USER_CONSTRAINTS;

-- �ǽ� 14-39
CREATE TABLE DEPT_PK(
    DEPTNO NUMBER(2) PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC     VARCHAR2(13));

CREATE TABLE EMP_FK(
    EMPNO NUMBER(2) PRIMARY KEY,
    ENAME VARCHAR2(10),
    DEPTNO NUMBER(2) REFERENCES DEPT_PK (DEPTNO));  -- REFERENCES�� �ڿ��� �����ϰ� �ִٴ� ��

SELECT * FROM DEPT_PK;

INSERT INTO DEPT_PK
    VALUES(11, 'NAME', 'SEOUL');
INSERT INTO DEPT_PK
    VALUES(12, 'NAME', 'SEOUL');

INSERT INTO EMP_FK
    VALUES(50, 'NAME', 11);

INSERT INTO EMP_FK
    VALUES(52, 'SMITH', 12);

SELECT * FROM EMP_FK;

INSERT INTO EMP_FK
    VALUES(52, 'SMITH', 13);  -- ���� ��Ű�� ���� �߻�. �θ� �����ϱ� �ϴµ� �θ�Ű�� 13�̶�°� ����. �׷��� ���� �߻�

