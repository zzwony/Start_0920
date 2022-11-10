SELECT * FROM EMP;
SELECT * FROM DEPT;

-- EMP�� ENAME, DEPT�� LOC�� ����ϱ�
SELECT E.ENAME, D.LOC
FROM EMP E, DEPT D;

-- EMP�� ENAME, DEPT�� LOC, DEPTNO 3���� Į���� ����ϱ�
SELECT E.ENAME, E.DEPTNO, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- EMP�� ENAME, DEPT�� LOC, DEPTNO 3���� Į���� SAL�� 3000�̻��� ����� ����ϱ�.
SELECT E.ENAME, E.DEPTNO, D.LOC, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND SAL >= 3000;

-- ��� ����� �̸��� ��å�� �Ŵ��� �̸� �̷��� 3���� Į���� ����ϱ�
SELECT E1.ENAME, E1.JOB, E2.ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO;

-- LEFT JOIN�� ������ �������� ���� �������� �ΰ���
SELECT E1.ENAME, E1.JOB, E1.MGR, E2.EMPNO, E2.ENAME AS MGR_NAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+); --(+)�Ⱥ������� ������ �� ������ �������� NULL���̿��� ��µȴ�.

----------------------------���� ����--------------------------------------------
--�� SQL-99 ǥ�ع���
-- ������ DEPTNO�� ��ø� �����ذ� ����Ʈ
SELECT E.EMPNO, E.ENAME, DEPTNO, D.DNAME, D.LOC
FROM EMP E NATURAL JOIN DEPT D;

-- JOIN~USING
SELECT E.EMPNO, E.ENAME, DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D
USING (DEPTNO)
WHERE E.SAL >= 3000;

-- JOIN~ON
SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D
ON (E.DEPTNO = D.DEPTNO);

-- �ܺ� ������ SQL-99�� �ۼ�
SELECT E1.ENAME, E1.JOB, E1.MGR, E2.EMPNO, E2.ENAME
FROM EMP E1 LEFT OUTER JOIN EMP E2
ON (E1.MGR = E2.EMPNO);

SELECT E1.ENAME, E1.JOB, E1.MGR, E2.EMPNO, E2.ENAME
FROM EMP E1 RIGHT OUTER JOIN EMP E2
ON (E1.MGR = E2.EMPNO);

SELECT E1.ENAME, E1.JOB, E1.MGR, E2.EMPNO, E2.ENAME
FROM EMP E1 FULL OUTER JOIN EMP E2
ON (E1.MGR = E2.EMPNO);

-- SUBQUERY
SELECT * FROM EMP
WHERE SAL > 2975;

SELECT ENAME, SAL
FROM EMP
WHERE ENAME = 'JONES';
-- ��ġ��
SELECT * FROM EMP
WHERE SAL > (SELECT SAL
                FROM EMP
                WHERE ENAME = 'JONES');

-- 1�� ����
SELECT * FROM EMP
WHERE COMM > (SELECT COMM
                FROM EMP
                WHERE ENAME = 'ALLEN');

-- HIREDATE�� SCOTT ���� ���� �Ի��� ����
SELECT * FROM EMP
WHERE HIREDATE > (SELECT HIREDATE
                    FROM EMP
                    WHERE ENAME = 'SCOTT');

-- ��� SAL
SELECT * FROM EMP
WHERE SAL > (SELECT AVG(SAL)
                FROM EMP);

-- �������� �ȿ��� �Լ��� ����� ���
-- ��� �޿����� ���� ����� �̸�, ��å, �μ��̸�(DNAME)�� �ٹ���(LOC)�� ����ϱ�
SELECT E.ENAME, E.JOB, D.DNAME, D.LOC 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO   -- ���̺��� �̾��ִ� ¡�˴ٸ�(�Ű�)�̴�.
    AND SAL > (SELECT AVG(SAL) FROM EMP);

-- ��� �޿����� �۰ų� ���� �޿��� �ް� �ִ� 20�� �μ��� ��� ����
SELECT E.ENAME, E.JOB, D.DNAME, D.LOC 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND SAL <= (SELECT AVG(SAL) FROM EMP)
    AND E.DEPTNO = 20;

-- ��å���� �׷��� ���� ��� ����
SELECT AVG(SAL)
FROM EMP
GROUP BY JOB;
-- �߸��� ����
SELECT E.ENAME, E.JOB, D.DNAME, D.LOC 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND SAL <= (SELECT AVG(SAL) FROM EMP GROUP BY JOB) --GROUP BY�� �ٿ��� ������ ����
                                                       --������ ���� ������ ������ SAL�̶�� �񱳴���� 1�������� GROUP BY JOB�� �񱳴���� �������̱� ������ ������ �߻��Ѵ�.
    AND E.DEPTNO = 20;

-- DEPTNO�� 20���� ����� �̸� �޿���?
SELECT ENAME, SAL
FROM EMP
WHERE DEPTNO = 20;
-- �μ���ȣ 30��
SELECT ENAME, SAL
FROM EMP
WHERE DEPTNO = 30;
-- �μ���ȣ�� 20��, 30���� ����� �̸��� �޿�?
SELECT ENAME, SAL
FROM EMP
WHERE DEPTNO IN (20, 30);
-- WHERE DEPTNO == (20, 30); �� ����

-- ������
SELECT * FROM EMP
WHERE SAL > (SELECT AVG(SAL)
                FROM EMP);
-- ������
SELECT * FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
                FROM EMP
                GROUP BY DEPTNO);

-- �μ��� �ְ�ݾ�


-- ANY, ALL, SOME
-- ANY
SELECT * FROM EMP
WHERE SAL = ANY (SELECT MAX(SAL)  -- = �ϸ� ���� = ANY �� �״�� '�ϳ���'��� ������ ������ �߻����� �ʴ´�.
                FROM EMP
                GROUP BY DEPTNO);

-- 30�� �μ��� �ִ�޿����� ���� �����
SELECT *FROM EMP
WHERE SAL < ANY (SELECT SAL  -- 30�� �μ��� �ִ� �޿��� 2850���� ���� ������ �޴� ����� ���´�.
                             -- �ִ�޿� ���� ����� ���������� �����Ű��
            FROM EMP
            WHERE DEPTNO = 30);
-- 30�� �μ��� �ּұ޿����� ū �����
SELECT *FROM EMP
WHERE SAL > ANY (SELECT SAL  
            FROM EMP
            WHERE DEPTNO = 30);

-- ALL
-- ��� ������ �۾ƾ��Ѵ�.
-- �ִ�ġ���� ū ����� ��µǾ��Ѵ�.
SELECT *FROM EMP
WHERE SAL > ALL (SELECT SAL  
            FROM EMP
            WHERE DEPTNO = 30);
-- > ANY~ : �ּҺ��� ū~
-- < ANY~ : �ִ뺸�� ����~
-- > ALL : �ּ�ġ���� ����
-- < ALL : �ִ�ġ���� ū

-- EXISTS
SELECT * FROM EMP
WHERE EXISTS(SELECT DNAME
                FROM DEPT
                WHERE DEPTNO = 10);