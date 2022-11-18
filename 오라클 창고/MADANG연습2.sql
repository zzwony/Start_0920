SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;

SELECT BOOKNAME
    FROM BOOK
    WHERE BOOKID = 1;

SELECT SUM(SALEPRICE)
    FROM ORDERS
    WHERE CUSTID = 1;

SELECT COUNT(CUSTID)
    FROM ORDERS
    WHERE CUSTID = (SELECT CUSTID
                    FROM CUSTOMER
                    WHERE NAME = '������');

SELECT DISTINCT B.PUBLISHER
FROM BOOK B, ORDERS O
WHERE B.BOOKID = O.BOOKID
AND O.CUSTID = (SELECT CUSTID
                FROM CUSTOMER
                WHERE NAME = '������'); 

SELECT COUNT(BOOKID)
    FROM BOOK;

SELECT NAME, ADDRESS
    FROM CUSTOMER;

SELECT NAME, ADDRESS
    FROM CUSTOMER
    WHERE NAME LIKE '��%';

--(4) ���� '��'���̰� �̸��� '��'�� ������ ���� �̸��� �ּ�
SELECT NAME, ADDRESS
    FROM CUSTOMER
    WHERE NAME LIKE '��%��';

--(5) �ֹ� �ݾ��� ���װ� �ֹ��� ��� �ݾ�
SELECT SUM(SALEPRICE), AVG(SALEPRICE)
    FROM ORDERS;

--(6) ���� �̸��� ���� ���ž�
SELECT NAME, SUM(SALEPRICE) 
    FROM ORDERS 
    JOIN CUSTOMER  USING (CUSTID) 
    GROUP BY NAME; 

--(7) �������� ������ ������ ���ǻ�� ���� ���ǻ翡�� ���� ������ ������ ���� �̸�
SELECT NAME
FROM CUSTOMER   JOIN ORDERS USING (CUSTID)
                JOIN BOOK USING (BOOKID)
    WHERE PUBLISHER IN (SELECT PUBLISHER
                             FROM BOOK JOIN ORDERS USING(BOOKID)
                             WHERE CUSTID = 1); 

--(8) ���ο� ���� (������ ����, ���ѹ̵��, 10000��)�� ���缭���� �԰�Ǿ���.
INSERT INTO BOOK
    VALUES ('������ ����', '���ѹ̵��', 10000);
-- ���� �ذ��ϱ�
INSERT INTO BOOK
    VALUES (11, '������ ����', '���ѹ̵��', 10000);

SELECT * FROM BOOK;

--(9) �Ｚ�� ���� ������ ������ �����ϱ�
DELETE FROM BOOK
    WHERE PUBLISHER = '�Ｚ��';

--(10)�̻� �̵� �ҷ����� å�� 2���� �ִ�. �� 2���� �����ϱ�
DELETE FROM BOOK
    WHERE PUBLISHER = '�̻�̵��';
-- ���� �ذ��ϱ�
-- ���������� ã�Ƽ� �� ��ü�� ���鶧 ��������� �Ѵ�.
-- �ذ� �ȉ�
SELECT * FROM BOOK WHERE PUBLISHER = '�̻�̵��';
DELETE FROM BOOK WHERE PUBLISHER = '�̻�̵��';

--��ȸ�ϱ�
SELECT * FROM ALL_CONSTRAINTS  --CONSTRAINT_NAME�� �ٲ�����Ѵ�.
    WHERE TABLE_NAME = 'BOOK';

SELECT * FROM ALL_CONSTRAINTS
    WHERE TABLE_NAME = 'ORDERS';



-- (11) ���ǻ� '���ѹ̵��'�� '���� ���ǻ�'�� �̸��� �ٲٱ�
UPDATE BOOK
    SET PUBLISHER = '�������ǻ�'
    WHERE PUBLISHER = '���ѹ̵��'; 

