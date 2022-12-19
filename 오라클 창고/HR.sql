--Q1. HR EMPLOYEES ���̺��� �̸�, ����, 10% �λ�� ������ ����ϼ���.
--A.
SELECT FIRST_NAME, SALARY, SALARY*1.1 AS UPSALARY FROM EMPLOYEES;
    
--Q2.  2005�� ��ݱ⿡ �Ի��� ����鸸 ���	
--A.        
SELECT * FROM EMPLOYEES; 
SELECT * FROM EMPLOYEES
    WHERE HIRE_DATE BETWEEN '05/01/01' AND '05/06/30';


--Q3. ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���
--A.
SELECT * FROM EMPLOYEES; 
SELECT * FROM EMPLOYEES
    WHERE JOB_ID IN ('SA_MAN', 'IT_PROG', 'ST_MAN');
   
--Q4. manager_id �� 101���� 103�� ����� ���
--A.   	
SELECT * FROM EMPLOYEES
    WHERE MANAGER_ID BETWEEN 101 AND 103;


--Q5. EMPLOYEES ���̺��� LAST_NAME, HIRE_DATE �� �Ի����� 6���� �� ù ��° �������� ����ϼ���.
--A.
SELECT LAST_NAME, HIRE_DATE, NEXT_DAY(LAST_DAY(ADD_MONTHS(HIRE_DATE, 6)), '������') AS FIRST_MONDAY FROM EMPLOYEES;

select last_name, hire_date, next_day(add_months(hire_date, 6), '��')"'Target" from employees;

--Q6. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �����ϱ����� W_MONTH(�ټӿ���)�� ������ ����ؼ� ����ϼ���.(�ټӿ��� ���� ��������)
--A.
SELECT *FROM EMPLOYEES;
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS W_MONTH FROM EMPLOYEES 
    ORDER BY W_MONTH DESC;

--Q7. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� W_YEAR(�ټӳ��)�� ����ؼ� ����ϼ���.(�ټӳ�� ���� ��������)
--A.
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) AS W_YEAR FROM EMPLOYEES ORDER BY W_YEAR DESC;

select employee_id, last_name, salary, hire_date,
trunc((sysdate-hire_date) / 365) w_year
from employees
order by w_year desc;

--Q8. EMPLOYEE_ID�� Ȧ���� ������ EMPLPYEE_ID�� LAST_NAME�� ����ϼ���.
--A. 
SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID, LAST_NAME FROM EMPLOYEES
    WHERE MOD(EMPLOYEE_ID, 2) = 1;

--Q9. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME �� M_SALARY(����)�� ����ϼ���. �� ������ �Ҽ��� ��°�ڸ������� ǥ���ϼ���.
--A
SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID, LAST_NAME, TRUNC(SALARY / 12) AS M_SALARY FROM EMPLOYEES;

--Q10. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �ټӳ���� ����ؼ� �Ʒ������� �߰��� �Ŀ� ����ϼ���.
--2001�� 1�� 1�� â���Ͽ� ������� 20�Ⱓ ��ǿ� ȸ��� ������  �ټӳ���� ���� 30 ������� ������  ��޿� ���� 1000���� BONUS�� ����.
--�������� ����.    
--A.
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, TRUNC((SYSDATE - HIRE_DATE) / 365) AS �ټӿ���, 
TRUNC(((SYSDATE - HIRE_DATE) / 365) * 30 / 20) ���, (WIDTH_BUCKET(TRUNC((SYSDATE - HIRE_DATE) / 365), 0, 20, 30) -1) WB,
(WIDTH_BUCKET(TRUNC((SYSDATE - HIRE_DATE) / 365), 0, 20, 30) -1) * 1000 BONUS_WB
FROM EMPLOYEES ORDER BY BONUS_WB DESC;

--Q11. EMPLOYEES ���̺��� commission_pct ��  Null�� ������  ����ϼ���.
--A.
SELECT COUNT(*) FROM EMPLOYEES
    WHERE COMMISSION_PCT IS NULL;
    
--Q12. EMPLOYEES ���̺��� deparment_id �� ���� ������ �����Ͽ�  POSITION�� '����'���� ����ϼ���.
--A.
SELECT LAST_NAME, DEPARTMENT_ID, NVL(TO_CHAR(DEPARTMENT_ID, '����') POSITION
FROM EMPLOYEES WHERE DEPARTMENT_ID IS NULL;

--Q13. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���(join~on, where �� �����ϴ� �� ���� ��� ���)
--A.
-- JOIN~ON
SELECT E.EMPLOYEE_ID, E.LAST_NAME, J.JOB_ID, J.JOB_TITLE
    FROM EMPLOYEES E JOIN JOBS J ON(E.JOB_ID = J.JOB_ID)
    WHERE E.EMPLOYEE_ID = 120;

-- WHERE
SELECT E.EMPLOYEE_ID, E.LAST_NAME, J.JOB_ID, J.JOB_TITLE
    FROM EMPLOYEES E, JOBS J
    WHERE E.JOB_ID = J.JOB_ID
        AND EMPLOYEE_ID = 120;

--Q14.  employees ���̺��� �̸��� FIRST_NAME�� LAST_NAME�� �ٿ��� 'NAME' �÷������� ����ϼ���.
--��) Steven King
--A. 
SELECT * FROM EMPLOYEES;
SELECT CONCAT(FIRST_NAME , LAST_NAME) AS NAME FROM EMPLOYEES;

SELECT FIRST_NAME||''||LAST_NAME AS NAME FROM EMPLOYEES;

--Q15. HR ���̺���� �м��ؼ� ��ü ��Ȳ�� ������ �� �ִ� ��� ���̺��� �ۼ��ϼ���. (�� : �μ��� ��� SALARY ����)
--A.
-- �μ��� ��å�� ��� SALARY ����
SELECT * FROM EMPLOYEES;
SELECT DEPARTMENT_ID, JOB_ID, ROUND(AVG(SALARY)) FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID, JOB_ID
    ORDER BY ROUND(AVG(SALARY)) DESC;

SELECT D.DEPARTMENT_NAME, ROUND(AVG(E.SALARY)) AVG
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME
ORDER BY AVG DESC;

--Q16. HR EMPLOYEES ���̺��� escape �ɼ��� ����Ͽ� �Ʒ��� ���� ��µǴ� SQL���� �ۼ��ϼ���.
--job_id Į������  _�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����Ͽ� '_A'�� �����ϴ�  ��� ���� ���
--A.
-- ESCAPE�� ���� ���� �ٷ� ���� ���ڴ� �Ϲݹ��ڷ� �ν��Ѵ�.
SELECT JOB_ID FROM EMPLOYEES;
SELECT JOB_ID FROM EMPLOYEES
    WHERE JOB_ID LIKE '%#_A%' ESCAPE '#';

--Q17. HR EMPLOYEES ���̺��� SALARY, LAST_NAME ������ �ø����� �����Ͽ� ����ϼ���.
--A. 
SELECT SALARY, LAST_NAME FROM EMPLOYEES
    ORDER BY SALARY, LAST_NAME ASC;
   
--Q18. Seo��� ����� �μ����� ����ϼ���.
--A.
SELECT * FROM EMPLOYEES;
   
SELECT DEPARTMENT_NAME FROM DEPARTMENTS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME = 'Seo');

--Q19. LMEMBERS �����Ϳ��� ���� ���űݾ��� �հ踦 ���� CUSPUR ���̺��� ������ �� CUST ���̺�� 
--����ȣ�� �������� �����Ͽ� ����ϼ���.
--������ ���� �������� �ٲ��ְ� �ؿ� 2�� �� �����Ű��.
CREATE TABLE CUSPUR AS SELECT ����ȣ, SUM(���űݾ�) ���űݾ� FROM PRODPUR
GROUP BY ����ȣ
ORDER BY ����ȣ;

SELECT * FROM CUSPUR;

SELECT * FROM PRODPUR;

--Q20.purprd ���̺��� 2�Ⱓ ���űݾ��� ���� ������ �и��Ͽ� ����14, ����15 �÷��� �����ϴ� AMT_YEAR ���̺��� 
--������ �� 14��� 15���� ���űݾ� ���̸� ǥ���ϴ� ���� �÷��� �߰��Ͽ� ����ϼ���.
--��, ����ȣ, ���޻纰�� ���űݾ� �� ������ ���еǾ�� ��.
--�������� ����
CREATE TABLE AMT14 AS SELECT ����ȣ, ���޻�, SUM(���űݾ�) ���űݾ�
FROM PRODPUR
WHERE �������� < '20150101'
GROUP BY ����ȣ, ���޻�
ORDER BY ����ȣ;

SELECT * FROM AMT14;

CREATE TABLE AMT15 AS SELECT ����ȣ, ���޻�, SUM(���űݾ�) ���űݾ�
FROM PRODPUR
WHERE �������� > '20141231'
GROUP BY ����ȣ, ���޻�
ORDER BY ����ȣ;

SELECT * FROM AMT15;

--FULL OUTER JOIN ���̺� ����
CREATE TABLE AMT_YEAR_FOJ
AS SELECT A4.����ȣ, A4.���޻�, A4.���űݾ� ����14, A5.���űݾ� ����15
FROM AMT14 A4 FULL OUTER JOIN AMT15 A5
ON (A4.����ȣ = A5.����ȣ AND A4.���޻� = A5.���޻�);

SELECT * FROM AMT_YEAR_FOJ;
SELECT ����ȣ, ���޻�, NVL(����14, 0) ����14, NVL(����15, 0) ����15,
(NVL(����15, 0) - NVL(����14, 0)) ����
FROM AMT_YEAR_FOJ A;

DROP TABLE AMT14;
DROP TABLE AMT15;
DROP TABLE AMT_YEAR_FOJ;
DROP TABLE CUSPUR;