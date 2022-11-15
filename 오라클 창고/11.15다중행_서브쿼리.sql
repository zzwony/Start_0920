-- 1981�� 6�� 1�� ���Ŀ� �Ի��� �������
SELECT * FROM EMP
WHERE HIREDATE >= TO_DATE('1981/06/01');

--P177
SELECT SUM(SAL) FROM EMP;
-- SUM�� NULL ���� ���� �����ش�.
SELECT SUM(COMM) FROM EMP;

-- ��� ��ü ����?
SELECT COUNT(ENAME) FROM EMP;
-- �μ���ȣ�� 10���� ��� ��ü ����?
SELECT COUNT(ENAME) FROM EMP
WHERE DEPTNO = 10;
-- COMM�� �޴� �����ü��
SELECT COUNT(ENAME)
    FROM EMP
    WHERE COMM IS NOT NULL;
-- ��� �޿� �ִ�
SELECT MAX(SAL) FROM EMP;
-- �μ��� ��� �޿� �ִ�
SELECT MAX(SAL)
    FROM EMP
    GROUP BY DEPTNO;
-- �̸��� �ι�° ���ڰ� A�� ���
SELECT AVG(SAL)
    FROM EMP
    WHERE ENAME LIKE '_A%';

-- �μ��� �޿��� �ּڰ���?
SELECT DEPTNO, JOB, MIN(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB;

-- SELECT ENAME, AVG(SAL)�̷��� �����ϸ� ���� �߻�.�̸��� �������ε� ��� ���� �ϳ����� ������ ���� �ʴ´�.

-- �޿��� 2000�̻��� ���� �߿��� �μ���, ��å�� �޿��� ��հ�?
SELECT AVG(SAL)
    FROM EMP
    WHERE SAL >= 2000
    GROUP BY DEPTNO, JOB;

--P191
-- �μ���, ��å�� �޿��� ����� 2000�̻��� �׷��� ��հ�?
SELECT DEPTNO, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 2000;
-- �޿��� 2000 �̻��� ���� �߿��� �μ���, ��å�� �޿��� ����� 3000 �̻��� �׷��� ��հ�
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

-- ��å���� �ο��� 2�� �̻��� ��å�� �ο���?
SELECT JOB, COUNT(ENAME)
    FROM EMP
    GROUP BY JOB
    HAVING COUNT(ENAME) >= 2;

-- �� ���̺� �̾��ֱ�
-- ��� �̸���, ��å, �ٹ����� ����ϱ�
SELECT E.ENAME, E.JOB, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- �޿��� 2000 �̻��� ��� �̸��� ��å, �ٹ�����?
SELECT E.ENAME, E.JOB, D.LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND SAL >= 2000
    AND COMM IS NULL;

-- P221 ���� ����
SELECT E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME, D.LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
        AND E.SAL <= 2500
        AND E.EMPNO <= 9999
    ORDER BY E.EMPNO;

-- �� ����
SELECT *
    FROM SALGRADE;

SELECT ENAME, S.*
    FROM EMP, SALGRADE S;

SELECT *
    FROM EMP E, SALGRADE S
    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;
    
-- SELF JOIN
-- ����̸�, ��å, �Ŵ��� �̸��� ����ϱ�
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

-- SQL 99 ���
-- 3������ ����� �ִµ� ���ϴ°ɷ� ����ϸ� �ȴ�.(3���� �� �Ȱ���)
-- NATURAL JOIN(���1)
-- �����÷��� ���ؼ� E ������ ��ø� ���� ������ ������ �߻�������
-- �� ������ ������ ���ָ� ������ �߻��Ѵ�.
-- �� Ư���� ���� WHERE�� ���ִ°��� �ƴ϶� FROM���� ���ش�.
-- ����� Į���� 1���� �ƴ϶� 2���� �Ǹ� ���� �ǵ����� ���� ���� ����� �� �� �ִ�.(���2,3�� ����ϴ°��� ��õ)
SELECT E.ENAME, D.LOC, DEPTNO
    FROM EMP E NATURAL JOIN DEPT D;

-- INNER JOIN(���2, ����Ʈ�� INNER JOIN �̴�.)
-- ������� ����̴�.
SELECT E.ENAME, D.LOC, DEPTNO
    FROM EMP E INNER JOIN DEPT D
    USING (DEPTNO); ---��� Į������ ��������� ã�ư��� �����ذ��̴�.
                    ---�� Į���� �Ἥ �����ض�
                    ---��ȣ�� �� �����ϴ� �����ϱ�

-- JOIN ON(���3)
-- ������� ����̴�.
SELECT E.ENAME, D.LOC
    FROM EMP E JOIN DEPT D 
        ON(E.DEPTNO = D.DEPTNO) ---WHERE���� ������� �ʴ´�.(������ Į���� �����ְ� �ִ�.)
    WHERE E.SAL >= 2000     ---�� �ؿ� ������ ���δ�.(Į���� ������ �����ϰ� �ִ�.)
        AND D.DEPTNO = 10;

-- �ܺ�����
SELECT E1.ENAME, E1.MGR, E2.EMPNO
    FROM EMP E1 LEFT OUTER JOIN EMP E2  ---LEFT���� RIGHT���� ���������Ѵ�.
                                        ---���� �� �츮�� EMP E2�� ���� ������ NULL������ ä����
        ON (E1.MGR = E2.EMPNO);

SELECT E1.ENAME, E1.MGR, E2.EMPNO
    FROM EMP E1 RIGHT JOIN EMP E2
        ON (E1.MGR = E2.EMPNO);

--P237
--SQL-99 ���� ��Ŀ��� �� �� �̻��� ���̺��� ������ ��
--A JOIN B ON (����)
--  JOIN C ON (����)
--  JOIN D ON (����)

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
    GROUP BY D.DEPTNO, D.DNAME;  --�׷��� �����ִ°��� SELECT ���� �����Ѵ�. �׷��� E.ENAME�̶�� �ϸ� �����߻�

-- �������� SUBQUERY
-- �޿��� 2975 ���� ū ����� �̸�
SELECT ENAME
    FROM EMP
    WHERE SAL > 2975;
-- �޿��� 10�� �μ��� ��� �޿� ���� ū ����� �̸���?
SELECT ENAME
    FROM EMP
    WHERE SAL > (SELECT AVG(SAL)
                    FROM EMP
                    WHERE DEPTNO = 10);
-- �Ի����� 10�� �μ��� �ֱ� ���Ժ��� ���� �Ի��� �������
SELECT *
    FROM EMP
    WHERE HIREDATE > (SELECT MAX(HIREDATE)
                        FROM EMP
                        WHERE DEPTNO = 10);

-- �ٹ��μ��� 10���̰ų� 20���̰ų� 30���� ��� ����?
SELECT *
    FROM EMP
    WHERE DEPTNO IN (10,20,30);

-- �ٹ��μ� ��ȣ�� 15���� ū �μ��� ��� �̸��� �μ���ȣ
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
    WHERE SAL < ANY(SELECT SAL  --- �ִ񰪺��� ���� ���� �ϳ��� ������ ����Ѵٴ� ANY(��ȣ�� �ݴ�� �ּڰ����� ū ���� ������ ���
                        FROM EMP
                        WHERE DEPTNO = 30);
                        
-- �ִ񰪺��� ū, �ּڰ����� ������ ���
SELECT *
    FROM EMP
    WHERE SAL > ALL(SELECT SAL  
                        FROM EMP
                        WHERE DEPTNO = 30);

-- ��ȣ �ȿ� ���� �ִ��� ������ Ȯ���ϴ� �뵵�� EXISTS
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

-- �ζ��� ��
-- FROM ���� �մ� �������� �̴�.
SELECT E10.EMPNO, E10.ENAME, D.DNAME, D.LOC
    FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10,
            (SELECT * FROM DEPT) D
    WHERE E10.DEPTNO = D.DEPTNO;
-- WITH
-- ��Į�� ��������

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

