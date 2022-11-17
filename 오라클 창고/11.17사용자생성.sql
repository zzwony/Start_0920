CREATE VIEW VW_EMP20
    AS(SELECT EMPNO, ENAME, JOB, DEPTNO
        FROM EMP
        WHERE DEPTNO = 20);

SELECT * FROM VW_EMP20;

DROP VIEW VW_EMP20;

-- VIEW ���鶧 ORDER�� ������°ɷ� �˰� �ִµ�
-- ��ȣ�� �������� ���뵵 ���� ���ĵ� �����ϴ�.
CREATE VIEW VW_EMP20
    AS SELECT EMPNO, ENAME, JOB, DEPTNO
        FROM EMP
        WHERE DEPTNO = 20
        ORDER BY ENAME;
        
-- ROWNUM �޿��� ���� 10���� ������������ �����ϱ�
-- ROWNUM�� ����� ���ڰ� �ο��ȴ�.
SELECT ROWNUM, S.*
    FROM (SELECT *
            FROM EMP
            ORDER BY SAL DESC)S
    WHERE ROWNUM <= 10;

-- �޿��� ������������ ���ĵ� �並 �����, ���� 10���� ����ϱ�
CREATE VIEW DESC_VIEW
    AS SELECT * 
            FROM EMP
            ORDER BY SAL DESC;
SELECT ROWNUM, DESC_VIEW.*
    FROM DESC_VIEW
    WHERE ROWNUM <= 10;
    
DROP TABLE DEPT_TEMP;

    
-- ����
CREATE TABLE DEPT_TEMP
    AS (SELECT *
            FROM DEPT);
SELECT * FROM DEPT_TEMP;        
-- ��ī�� �λ����� �ٲٱ�
UPDATE DEPT_TEMP
    SET LOC = 'BUSAN'
    WHERE LOC = 'CHICAGO';
-- LOC Į���� ��� 'DAEGU'�� �ٲٱ�
UPDATE DEPT_TEMP
    SET LOC = 'DAEGU';
-- DEPT_TEMP ���̺��� ��� ������ �����ϱ�
TRUNCATE TABLE DEPT_TEMP;
-- DEPT_TEMP ���̺� DEPT�� ��� ROW�� �����ϱ�
INSERT INTO DEPT_TEMP
    SELECT * FROM DEPT; 


---------------------���� ����---------------------------------------------------
--ON DELETE CASCADE
--CHECK
--DEFAULT

--15. �����,����, �� ����
--��Ű��

-- ����� ����
-- �ؿ� �ڵ带 �ý��ۿ� �����Ű��
CREATE USER ORCLSTUDY
INDENTIFIED BY ORCLSTUDY;

--�н����� ����
--����

--�� ����


-- P405
-- SYSTEM�� �����Ű��
GRANT RESOURCE, CONNECT TO ORCLSTUDY;

--P414 �ǽ� 15-14
--SYSTEM�� �����Ű��
CREATE ROLE ROLE_NAME;
GRANT CONNECT, RESOURCE, CREATE VIEW TO ROLE_NAME;
GRANT ROLE_NAME TO ORCLSTUDY;


--------------------------------------------------------------------------------
--------------------����---------------------------------------------------------
-- ���� �߸����� ����� �ʹٸ� SYSTEM���� DROP USER MADANG; �����ϱ�
-- ����Ű
-- �������� CTRL + SHIFT + F
-- ��ũ��Ʈ ��� ���� ����(�Ϻ� �巡�� ���൵ ����) F5
-- �ּ� CTRL + -
-- �ּ� ���� CTRL + SHIFT + -
-- 1. MADANG ����ڸ� �����
-- �ý��ۿ� �����Ű��
CREATE USER MADANG
IDENTIFIED BY ORACLE;  -- ��������� �����
GRANT CREATE SESSION, CREATE TABLE TO MADANG;  -- ��������� ���Ѻο�

-- �� ���� ���� �������� ���� �������� �����ϱ�
-- ���� ÷���ϱ�

-- 2. BOOKS��� ���̺� ����� (������ ���翡�� �Է��ϱ�)
-- Į���� BNAME, PUB
CREATE TABLE BOOKS (
    BNAME   VARCHAR2(40),
    PUB     VARCHAR2(40)
);



--3. �ؿ� �ڵ带 ���� ���ٰ� �ٿ��ְ� �����Ű��
-- ó�� ����ô� �Ʒ� 4������ ������ �����Ѵ�.  
DROP TABLE Orders ;
DROP TABLE Book ;
DROP TABLE Customer ;
DROP TABLE Imported_Book ; 

CREATE TABLE Book (
  bookid      NUMBER(2) PRIMARY KEY,
  bookname    VARCHAR2(40),
  publisher   VARCHAR2(40),
  price       NUMBER(8) 
);

CREATE TABLE  Customer (
  custid      NUMBER(2) PRIMARY KEY,  
  name        VARCHAR2(40),
  address     VARCHAR2(50),
  phone       VARCHAR2(20)
);


CREATE TABLE Orders (
  orderid NUMBER(2) PRIMARY KEY,
  custid  NUMBER(2) REFERENCES Customer(custid),
  bookid  NUMBER(2) REFERENCES Book(bookid),
  saleprice NUMBER(8) ,
  orderdate DATE
);
-- Book, Customer, Orders ������ ����
INSERT INTO Book VALUES(1, '�౸�� ����', '�½�����', 7000);
INSERT INTO Book VALUES(2, '�౸�ƴ� ����', '������', 13000);
INSERT INTO Book VALUES(3, '�౸�� ����', '���ѹ̵��', 22000);
INSERT INTO Book VALUES(4, '���� ���̺�', '���ѹ̵��', 35000);
INSERT INTO Book VALUES(5, '�ǰ� ����', '�½�����', 8000);
INSERT INTO Book VALUES(6, '���� �ܰ躰���', '�½�����', 6000);
INSERT INTO Book VALUES(7, '�߱��� �߾�', '�̻�̵��', 20000);
INSERT INTO Book VALUES(8, '�߱��� ��Ź��', '�̻�̵��', 13000);
INSERT INTO Book VALUES(9, '�ø��� �̾߱�', '�Ｚ��', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

INSERT INTO Customer VALUES (1, '������', '���� ��ü��Ÿ', '000-5000-0001');
INSERT INTO Customer VALUES (2, '�迬��', '���ѹα� ����', '000-6000-0001');  
INSERT INTO Customer VALUES (3, '��̶�', '���ѹα� ������', '000-7000-0001');
INSERT INTO Customer VALUES (4, '�߽ż�', '�̱� Ŭ������', '000-8000-0001');
INSERT INTO Customer VALUES (5, '�ڼ���', '���ѹα� ����',  NULL);

-- �ֹ�(Orders) ���̺��� å���� ���� �ǸŸ� ������
INSERT INTO Orders VALUES (1, 1, 1, 6000, TO_DATE('2014-07-01','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (2, 1, 3, 21000, TO_DATE('2014-07-03','yyyy-mm-dd'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, TO_DATE('2014-07-03','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (4, 3, 6, 6000, TO_DATE('2014-07-04','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (5, 4, 7, 20000, TO_DATE('2014-07-05','yyyy-mm-dd'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, TO_DATE('2014-07-07','yyyy-mm-dd'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, TO_DATE( '2014-07-07','yyyy-mm-dd'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, TO_DATE('2014-07-08','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (9, 2, 10, 7000, TO_DATE('2014-07-09','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (10, 3, 8, 13000, TO_DATE('2014-07-10','yyyy-mm-dd'));

-- ����� 3�忡�� ���Ǵ� Imported_book ���̺�

CREATE TABLE Imported_Book (
  bookid      NUMBER ,
  bookname    VARCHAR(40),
  publisher   VARCHAR(40),
  price       NUMBER(8) 
);
INSERT INTO Imported_Book VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO Imported_Book VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);

COMMIT; 