-- SMITH�� �ٹ��μ��� ������ ����� �ּ���.
SELECT SAL*12 AS YEAR, DEPTNO FROM EMP
WHERE ENAME = 'SMITH';



-- ���ʽ�(COMM)�� ������ ������� �̸��� �μ���ȣ
SELECT ENAME, DEPTNO FROM EMP
WHERE COMM IS NULL;



-- �Ի����� 1985�� ������ �������
SELECT * FROM EMP;

SELECT * FROM EMP
WHERE HIREDATE >= '1985-01-01' ; 



-- �޿��� 2000�̻� 3000������ ����� �̸��� �޿�
SELECT ENAME, SAL FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;



-- ��å�� SALESMAN�� �ƴ� �����
SELECT ENAME FROM EMP
WHERE JOB <> 'SALESMAN';

SELECT ENAME FROM EMP
WHERE JOB NOT IN 'SALESMAN';



-- ��å�� SALESMAN �̰ų� MANAGER �̰ų� CLERK �� ���
SELECT ENAME FROM EMP
WHERE JOB IN ('SALESMAN', 'MANAGER', 'CLERK');



-- �̸��� TT�� ����ִ� �̸�
SELECT ENAME FROM EMP
WHERE ENAME LIKE '%TT%';



-- �̸��� 3��° ���ĺ��� O�� ���
SELECT ENAME FROM EMP
WHERE ENAME LIKE '__O%';



-- ��� �̸��� �ҹ��ڷ� ����ϱ�
SELECT LOWER(ENAME) FROM EMP;



-- �������Լ� SINGLE ROW     1��1�� �ƿ�ǲ�� ��
-- �������Լ� MULTIPLE ROWS  N��1�� �ƿ�ǲ�� ��



-- ���ڿ��� ���̸� �˱�
SELECT ENAME, LENGTH(ENAME) FROM EMP;
-- ���̰� 5�̻�
SELECT ENAME FROM EMP
WHERE LENGTH(ENAME) >= 5;



-- B�� ����Ʈ�� ���� ��Ÿ����.
-- ����� �� ���ڴ� 1����Ʈ������, �ѱ��� 2����Ʈ�̴�.
SELECT ENAME FROM EMP
WHERE LENGTHB(ENAME) >= 5;

SELECT LENGTH('�ѱ�'), LENGTHB('�ѱ�') FROM EMP;

SELECT LENGTH('�ѱ�'), LENGTHB('�ѱ�') FROM DUAL;



-- ���� : MINUS, ���̽��� subtract �̶�� �ߴ�.
-- SUBSTR�� ���ٴ� �ǹ̰� �ƴ϶� STRING�� �κ������� ���Ѵ�.
-- SUBSTR(������ ���Ͽ�, ������ġ, ����)
SELECT JOB, SUBSTR(JOB, 2, 2) FROM EMP;

SELECT JOB, SUBSTR(JOB, 2, 2) FROM EMP;

SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 2, 3), SUBSTR(JOB, 3, 4) FROM EMP;

SELECT JOB, SUBSTR(JOB, -4, 2), SUBSTR(JOB, -4, 3), SUBSTR(JOB, -4, 4) FROM EMP;

SELECT JOB, SUBSTR(JOB, -LENGTH(JOB), 2) FROM EMP; -- -LENGTH�� �ᱹ 1�� ��Ÿ����.



--INSTR
SELECT INSTR('HELLO, ORACLE!', 'L') FROM DUAL; -- L�̶�� ���� ã�ƶ�, DUAL�� �׻� ���ش�.
                                               -- L�� ó�� �߰ߵ� ���ؽ� ��ġ(3��°)�� �˷��ش�.
SELECT INSTR('HELLO, ORACLE!', 'L', 5) FROM DUAL; -- 12�� ���� �����ΰ�?
                                                  -- ã�� ���� ��ġ�̴�. 5��° ���ؽ� ���ĸ� ã�ƶ�
                                                  -- �׷��� HELLO�� �����ϰ� ó�� ������ ORACLE�� L�� ã�� ���̴�.
SELECT INSTR('HELLO, ORACLE!', 'L', 2, 2) FROM DUAL; -- 2 ���� 2�� ����?
                                                     -- �� ��°(�� ��°) ������ L�� ã�ƶ�
                                                     -- L�� ã��� ã�� �ι�° L�� ã�����̴�.



-- REPLACE
SELECT REPLACE('010-1234-5678', '-', ' ') FROM DUAL;



-- LPAD, RPAD
-- PADDING�� ä���ֱ� ��� �⺻���� �ǹ̰� �ִ�.
-- L�� ����, R�� ���������� ä���ִ´�.
SELECT LPAD('ORACLE', 10, '#') FROM DUAL;

SELECT RPAD('ORACLE', 10, '#') FROM DUAL;

SELECT RPAD('010-1234-', 13, '*') FROM DUAL; -- 13ĭ�� ������ 4ĭ�� ��µ� �����ʺ��� * ǥ�÷� ä����



-- CONCAT
SELECT CONCAT (EMPNO, ENAME) FROM EMP;

SELECT CONCAT (EMPNO, CONCAT(' : ', ENAME)) FROM EMP; -- EMPNO, :, ENAME �� 3���� �ѹ��� ���� �� ���� ������
                                                      -- �̷��� �����.



-- LSTRIP, RSTRIP, STRIP�� �� ������ ������ ���⿡ ���缭 ������
-- LTRIM, RTRIM, TRIM�� ��ɵ� ����.
SELECT TRIM('  ORACLE!  ') FROM DUAL;

SELECT LTRIM('  ORACLE!  ') FROM DUAL;

SELECT RTRIM('  ORACLE!  ') FROM DUAL; -- ����������ó�� ���̴µ� Į�� �̸��� �� ����������ó�� ���̴°�

SELECT RTRIM('  ORACLE!  ', '!') FROM DUAL;  -- ����ǥ �����
                                             -- ��� �ִ��� ���� Ȯ���ϰ� ��������� �����ش�.



-- ROUND
-- TRUNC �߶� ������
-- CEIL, FLOOR�� ����� ������ ��ȯ���ش�.
-- MOD

SELECT ROUND(1234.5678, 1) FROM DUAL;  -- �Ҽ��� 1�ڸ� ����, �ݿø�

SELECT TRUNC(1234.5678, 1) FROM DUAL;  -- �߶� ����

SELECT CEIL(1234.5678) FROM DUAL; -- �ݿø� �ƴ϶� �ø�
SELECT FLOOR(1234.5678) FROM DUAL;

SELECT MOD(15, 4) FROM DUAL;  -- �������� �����ִ� �Լ�



-- SYSDATE
SELECT SYSDATE FROM DUAL; -- ��¥ �Լ��̴�.

SELECT SYSDATE-1 FROM DUAL; -- ��¥���� ���ϱ�, ���� �����ϴ�.
SELECT SYSDATE+1 FROM DUAL;



-- ADD_MONTHS
SELECT ADD_MONTHS(SYSDATE, 3) FROM DUAL; -- �� ������ ���ϱ�

-- ��� �̸�, �Ի� ��¥�� ����ϱ�
SELECT ENAME, HIREDATE FROM EMP;
-- �Ի� ��¥���� 120������ ���� ���ο� Į���� ����ϱ�
SELECT ENAME, HIREDATE, ADD_MONTHS(SYSDATE,120) AS WORK10YEAR FROM EMP; -- ��Ī �����ٶ� ���ڰ� ���� ������ ������ �߻��Ѵ�.

-- SYSDATE�� ADD_MONTHS �Լ��� ����Ͽ� ���� ��¥�� 6���� �� ��¥�� ����ϱ�
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 6) FROM DUAL;



-- MONTHS_BETWEEN
-- �� ��¥ ���� �� ������ �������� �����ش�.
SELECT ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE)) FROM EMP;
SELECT ROUND(SYSDATE - HIREDATE) FROM EMP;
