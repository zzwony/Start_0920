SELECT COMM
FROM EMP;

-- NULL���� 0�� �ǵ��� ���
SELECT NVL(COMM, 0)
    FROM EMP;

-- '1981/06/01' ������ �������
SELECT *
    FROM EMP
WHERE HIREDATE >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

SELECT *
    FROM EMP
WHERE HIREDATE >= '1981/06/01'; -- �����ڵ�

-- '1981�� ������ �������
SELECT *
    FROM EMP
WHERE HIREDATE > TO_DATE('1981', 'YYYY');

-- ����� ��� �� ���Դϱ�?
SELECT COUNT(ENAME)
FROM EMP;

-- �μ���ȣ�� 20�� �μ��� �ְ�޿���?


-- �μ��� �ְ�޿�?
SELECT DEPTNO, MAX(SAL)
FROM EMP
GROUP BY DEPTNO;

-- �޿��� 1000 �̻��� ������� �μ��� ��ձ޿���?
SELECT DEPTNO, AVG(SAL)
FROM EMP
WHERE SAL >= 1000
GROUP BY DEPTNO
ORDER BY DEPTNO; 

-- �μ��� ��å���� ��ձ޿��� 1000�̻�
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 1000  -- �׷쿡 ���� �����̱� ������ HAVING
ORDER BY DEPTNO;

-- ��å���� �ο��� 3�� �̻��� ��å�� �����?
SELECT JOB, COUNT(ENAME)
    FROM EMP
GROUP BY JOB
HAVING COUNT(ENAME) >= 3;

--�� ������� �Ի� ������ �������� �μ����� �� ���� �Ի�?
SELECT TO_CHAR(HIREDATE, 'YYYY'), DEPTNO, COUNT(ENAME)
    FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO;

----------------------------------���� ����--------------------------------------
-- JOIN
SELECT *
    FROM EMP, DEPT
ORDER BY EMPNO;

SELECT *
    FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
ORDER BY EMP.DEPTNO;    --��¹��� ����� ���� DEPTNO�� EMP.DEPTNO�̰� DEPTNO_1�� DEOT.DEPTNO�̴�.

-- ���̱�
SELECT E.ENAME, E.JOB, D.LOC
    FROM EMP E, DEPT D  --��Ī ����
WHERE E.DEPTNO = D.DEPTNO -- ������ Į���϶��� E.�̶�� ������ �ʾƵ� ��µȴ�.
                          -- ������ �� ������(��ó�� �� �� �ֱ� ����)
ORDER BY E.DEPTNO;

SELECT E.EMPNO, D.DEPTNO
    FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO;

-- ���� ���� INNER JOIN, EQUI JOIN, SIMPLE JOIN
-- INNER JOIN�� ���� ����
-- EQUI JOIN�� � ����
-- SIMPLE JOIN�� �ܼ� ����
-- ��� INNER JOIN �̶�� �θ���.

SELECT E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME, D.LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
        AND SAL >= 3000;

-- NON-EQUI JOIN �� ����
SELECT *
    FROM EMP E, SALGRADE S
    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- ��ü ���� SELF JOIN
SELECT *
    FROM EMP; -- MGR�� ���ӻ���� �����ȣ�̴�.
    
SELECT E1.ENAME, E1.JOB, E2.ENAME AS MANAGER
    FROM EMP E1, EMP E2  -- EMP�� �ϳ� �� �����. SELF JOIN��
    WHERE E1.MGR = E2.EMPNO;

-- ���� �ܺ� ���� ����ϱ�
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
        E2.EMPNO AS MGR_EMPNO,
        E2.ENAME AS MGR_ENAME
    FROM EMP E1, EMP E2
    WHERE E1.MGR = E2.EMPNO(+)  -- + ��ȣ ��� �� ���� NULL�̿��� ������ ����ϴ� ����̴�.
                                -- + ��ȣ �ִ� ���� ���� ����Ѵ�.
    ORDER BY E1.EMPNO;

-- ������ �ܺ� ���� ����ϱ�
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
        E2.EMPNO AS MGR_EMPNO,
        E2.ENAME AS MGR_ENAME
    FROM EMP E1, EMP E2
    WHERE E1.MGR(+) = E2.EMPNO
    ORDER BY E1.EMPNO;

-- �������� SUBQUERY
-- �������� Ư¡ 1. ��ȣ()�� ��� ����Ѵ�. 2. �ƿ�ǲ�� �ڷ����� ���������� �ڷ����� �����ؾ� �Ѵ�.
-- 1. ��� �̸��� JONES�� ����� �޿�?
SELECT ENAME, SAL
    FROM EMP
    WHERE ENAME = 'JONES';

-- 2. �޿��� 2975 ���� ���� ��� ����?
SELECT *
    FROM EMP
    WHERE SAL > 2975;
    
-- 1�� ������ 2�� ���� ��ġ��
-- ���� �ȿ� ������ �� �ִ�. = ��������
SELECT ENAME
    FROM EMP
    WHERE SAL > (SELECT SAL   -- �� �κ��� ��������
                 FROM EMP
                 WHERE ENAME = 'JONES');

-- ��� �̸��� ALLEN�� ����� �߰� ���� ���� ���� �߰� ������ �޴� ��� ������ ���ϱ�
SELECT *
    FROM EMP
    WHERE COMM > (SELECT COMM
                    FROM EMP
                    WHERE ENAME = 'ALLEN');

-- ������� ALLEN���� ���� ���������?
SELECT *
    FROM EMP
    WHERE HIREDATE > (SELECT HIREDATE
                        FROM EMP
                        WHERE ENAME = 'ALLEN');