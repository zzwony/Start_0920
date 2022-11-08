-- SYSDATE �� ���� ��¥ �ð���?
SELECT SYSDATE
FROM DUAL;

-- �Ի� 120������ ����� �̸��� �Ի糯¥?
SELECT ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 120) AS YEARS_10
FROM EMP;

SELECT ENAME, HIREDATE
FROM EMP
WHERE ADD_MONTHS(HIREDATE, 120) = SYSDATE;  --����� �ȵȴٴ°��� ���� ���ٴ� ��

-- 2022/11/08/ 09:21:23 ���� ����ϱ�
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS')
FROM DUAL;

-- �޷�ǥ�ð� �ְ� �޿� ����ϱ�
SELECT SAL,
    TO_CHAR(SAL, '$999,999') AS �޷�ǥ��
FROM EMP;

-- ���ڸ� ���ڷ�
SELECT '1300' + '1500'   --1,300 + 1,500�� ���� �߻�
FROM DUAL;
-- , �־ �����ϰ� �����
SELECT TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999') AS TO_N
FROM DUAL;

-- ���ڸ� ��¥�� 
-- '2022-11-08'�� ��¥ �����ͷ� �ٲٱ�
SELECT TO_DATE('2022-11-08', 'YYYY-MM-DD') AS TODAY
FROM DUAL;

-- '1981-06-01' ���Ŀ� �Ի��� ������� �μ��� �̸�
SELECT ENAME, DEPTNO
FROM EMP
WHERE HIREDATE > TO_DATE('1981/06/01', 'YYYY-MM-DD');

-- COMM
SELECT COMM FROM EMP;
-- SAL �� COMM�� ����?
-- COMM�� NULL�� 0���� �ٲٱ�
SELECT SAL, COMM, SAL + NVL(COMM, 0)
FROM EMP;

-- SAL �޿� �հ� �� ��
SELECT SUM(SAL)
FROM EMP;
-- ����� ��� �� ��?
SELECT COUNT(ENAME)
FROM EMP;
-- �μ���ȣ�� 20���� ����� �� ��?
SELECT COUNT(DEPTNO)
FROM EMP
WHERE DEPTNO = 20;
-- COMM�� ���� ����(���� NULL) ����� �μ���ȣ, ��å, �̸���?
SELECT DEPTNO, JOB, ENAME,
    NVL(COMM, 0)
FROM EMP;
-- �μ���ȣ�� 20���� ����� �ְ� �޿���?
SELECT MAX(SAL)
FROM EMP
WHERE DEPTNO = 20;
-- �μ���ȣ�� 20���� ����� ���� �ֱ� �Ի��ڴ�?
SELECT MAX(HIREDATE)
FROM EMP
WHERE DEPTNO = 20;
-- �μ���ȣ�� 20���� ��ձ޿���?
SELECT AVG(SAL)
FROM EMP
WHERE DEPTNO = 20;

-------------------------���� ����-----------------------------------------------
-- �μ��� ��� �޿�
SELECT DEPTNO, ROUND(AVG(SAL))
FROM EMP
GROUP BY DEPTNO;

-- �μ��� ��å�� ��� �޿�
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB;

-- HAVING(ORDER BY�� ������ ����� ���ϱ�)
SELECT DEPTNO, JOB, ROUND(AVG(SAL))
FROM EMP
GROUP BY DEPTNO,JOB
HAVING AVG(SAL) >= 2000 -- �� ���� �μ��� �������� ��ձ޿��̴�.
                        -- �׷��� ���� ���� ���� ���̸� ���� �߻�
ORDER BY DEPTNO;  -- ���� �����Ѵ�. ��ġ�� �� ��������!

-- WHERE�� HAVING ����
SELECT DEPTNO, JOB, ROUND(AVG(SAL))
FROM EMP
WHERE SAL > 2000
GROUP BY DEPTNO,JOB;    -- WHERE�� GROUP BY�� ���� �־ ������ ���������� �׷��� �ʾҴ�.
                        -- 2000�̻��� ���ؼ� �׷��� ���´ٴ°Ŵϱ� �̻��Ұ��� ����.
    
SELECT DEPTNO, JOB, ROUND(AVG(SAL))
FROM EMP
WHERE SAL > 2000
GROUP BY DEPTNO,JOB
HAVING AVG(SAL) > 2500  -- ��°��: ����
ORDER BY DEPTNO;

SELECT DEPTNO, JOB, ROUND(AVG(SAL))
FROM EMP
GROUP BY DEPTNO,JOB
HAVING AVG(SAL) > 2500
ORDER BY DEPTNO;

-- �μ��� ��å�� ��� �޿��� 500�̻��� ������� �μ� ��ȣ, ��å, �μ��� ��å�� ��� �޿� ����ϱ�
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 500
ORDER BY DEPTNO;
-- ROLLUP, CUBE
-- ROLLUP
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO), JOB
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL)
FROM EMP
GROUP BY DEPTNO, ROLLUP(JOB)
ORDER BY DEPTNO, JOB;

-- CUBE
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)  -- ROLLUP�� �κ����ε� CUBE�� JOB ������ COUNT�� MAX(SAL)�� ���� ������ �� �����ִ�.
ORDER BY DEPTNO, JOB;
