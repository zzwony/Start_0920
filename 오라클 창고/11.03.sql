SELECT * FROM EMP
WHERE JOB = 'CLERK';

-- EMP ���̺��� ��å�� CLEARK�� ����� �̸���?
SELECT ENAME FROM EMP
WHERE JOB = 'CLERK';

-- EMP ���̺��� ��å�� CLERK�̰� ������� 1990������ ����� �̸���?
SELECT ENAME FROM EMP
WHERE JOB = 'CLERK'
AND HIREDATE < '1990/01/01';

-- TO_DATE
SELECT * FROM EMP 
WHERE JOB = 'CLERK' 
AND HIREDATE <= TO_DATE('01-01-90', 'DD-MM-YY'); 
                --P164   --���ڿ�       --���� ����

-- �޿��� 2500�̻��̰� ������ ANALYST�� ��� ������ �������� �ڵ带 ä������
SELECT * FROM EMP
WHERE SAL >= 2500
AND JOB = 'ANALYST';

-- �޿��� 3000�̸鼭 SALESMAN�� �ƴ� ����� ��ȸ�ϱ�
SELECT * FROM EMP
WHERE SAL <> 3000
AND JOB <> 'SALESMAN';

-- NOT ������
SELECT * FROM EMP
WHERE NOT SAL =3000;

-- JOB�� MANAGER �̰ų� SALESMAN �̰ų� CLERK �� �����?
SELECT * FROM EMP
WHERE JOB = 'MANAGER'
    OR JOB = 'SALESMAN'
    OR JOB = 'CLERK';

SELECT * FROM EMP
WHERE JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

-- NOT IN
SELECT * FROM EMP
WHERE JOB NOT IN ('MANAGER', 'SALESMAN', 'CLERK');

-- �μ� ��ȣ�� 10, 20���� ��� ������ ������
SELECT * FROM EMP
WHERE DEPTNO IN (10,20);

-- �޿��� 2000�̻��̰� 3000������ ���ڵ�
SELECT * FROM EMP
WHERE SAL >= 2000 AND SAL <=3000;

-- BETWEEN A AND B
SELECT * FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;

-- NOT ���̱�
SELECT * FROM EMP
WHERE SAL NOT BETWEEN 2000 AND 3000;

-- LIKE ������, '%', '_'
SELECT * FROM EMP
WHERE ENAME LIKE 'S%';

SELECT * FROM EMP
WHERE ENAME LIKE '_M%';

-- ��� �̸��� AM�� ���ԵǾ� �մ� ��� �����͸� ����ϱ�
SELECT * FROM EMP
WHERE ENAME LIKE '%AM%';

SELECT * FROM EMP
WHERE ENAME LIKE '_AM%';

-- IS NULL
SELECT * FROM EMP
WHERE COMM IS NULL;

SELECT * FROM EMP
WHERE COMM IS NOT NULL;

-- ���� ������
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 20;

SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, SAL, ENAME, DEPTNO FROM EMP
WHERE DEPTNO = 20;
--��°�� ������ ��Ÿ����.
--�������� �������°� ������ �ƴ϶� �������� ������ ���ƾ� �Ѵ�.\

SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, DEPTNO, SAL FROM EMP
WHERE DEPTNO = 20;
-- ������ ���� �ʴ´�. ������ ��� ����� ���� �߸��� ���� �� �� �ִ�.
-- ������ ������ SAL�� ���ڰ� DEPTNO�� �����̱� ������ �׳� �ٿ����ȴ�.
-- �׷��� ������ �߻����� �ʾҴ�.
-- �Ʊ� �ߴ� ���� ������ ��Ÿ���� ������ 
-- �ϳ��� ���ڰ� �ϳ��� ������ ������ ������ �߻���.

SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL FROM EMP
WHERE DEPTNO = 20;
-- ���� ������ ���� ������ ������ �߻���Ų��.


SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10
UNION ALL
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10;

SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10 OR DEPTNO = 20
MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10;
-- 20�ڸ� �����͸� ���Ҵ�.

SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10 OR DEPTNO = 20
INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10;






--06��
--UPPER. LOWER, INITCAP �Լ�
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME) FROM EMP;

--UPPER �Լ��� ���ڿ� ���ϱ�
-- ��� �̸��� SCOTT�� ������ ã��
SELECT * FROM EMP
WHERE UPPER(ENAME) = 'SCOTT';
-- ����� �Ǿ��ֵ�(sCOTT, SCOtt...) ������� SCOTT�� ã�Ƴ���.

SELECT * FROM EMP
WHERE UPPER(ENAME) LIKE UPPER('%co%');
