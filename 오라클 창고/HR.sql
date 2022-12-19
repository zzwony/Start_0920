--Q1. HR EMPLOYEES 테이블에서 이름, 연봉, 10% 인상된 연봉을 출력하세요.
--A.
SELECT FIRST_NAME, SALARY, SALARY*1.1 AS UPSALARY FROM EMPLOYEES;
    
--Q2.  2005년 상반기에 입사한 사람들만 출력	
--A.        
SELECT * FROM EMPLOYEES; 
SELECT * FROM EMPLOYEES
    WHERE HIRE_DATE BETWEEN '05/01/01' AND '05/06/30';


--Q3. 업무 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
--A.
SELECT * FROM EMPLOYEES; 
SELECT * FROM EMPLOYEES
    WHERE JOB_ID IN ('SA_MAN', 'IT_PROG', 'ST_MAN');
   
--Q4. manager_id 가 101에서 103인 사람만 출력
--A.   	
SELECT * FROM EMPLOYEES
    WHERE MANAGER_ID BETWEEN 101 AND 103;


--Q5. EMPLOYEES 테이블에서 LAST_NAME, HIRE_DATE 및 입사일의 6개월 후 첫 번째 월요일을 출력하세요.
--A.
SELECT LAST_NAME, HIRE_DATE, NEXT_DAY(LAST_DAY(ADD_MONTHS(HIRE_DATE, 6)), '월요일') AS FIRST_MONDAY FROM EMPLOYEES;

select last_name, hire_date, next_day(add_months(hire_date, 6), '월')"'Target" from employees;

--Q6. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 현재일까지의 W_MONTH(근속월수)를 정수로 계산해서 출력하세요.(근속월수 기준 내림차순)
--A.
SELECT *FROM EMPLOYEES;
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS W_MONTH FROM EMPLOYEES 
    ORDER BY W_MONTH DESC;

--Q7. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 W_YEAR(근속년수)를 계산해서 출력하세요.(근속년수 기준 내림차순)
--A.
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) AS W_YEAR FROM EMPLOYEES ORDER BY W_YEAR DESC;

select employee_id, last_name, salary, hire_date,
trunc((sysdate-hire_date) / 365) w_year
from employees
order by w_year desc;

--Q8. EMPLOYEE_ID가 홀수인 직원의 EMPLPYEE_ID와 LAST_NAME을 출력하세요.
--A. 
SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID, LAST_NAME FROM EMPLOYEES
    WHERE MOD(EMPLOYEE_ID, 2) = 1;

--Q9. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME 및 M_SALARY(월급)을 출력하세요. 단 월급은 소수점 둘째자리까지만 표현하세요.
--A
SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID, LAST_NAME, TRUNC(SALARY / 12) AS M_SALARY FROM EMPLOYEES;

--Q10. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 근속년수를 계산해서 아래사항을 추가한 후에 출력하세요.
--2001년 1월 1일 창업하여 현재까지 20년간 운영되온 회사는 직원의  근속년수에 따라 30 등급으로 나누어  등급에 따라 1000원의 BONUS를 지급.
--내림차순 정렬.    
--A.
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, TRUNC((SYSDATE - HIRE_DATE) / 365) AS 근속연수, 
TRUNC(((SYSDATE - HIRE_DATE) / 365) * 30 / 20) 등급, (WIDTH_BUCKET(TRUNC((SYSDATE - HIRE_DATE) / 365), 0, 20, 30) -1) WB,
(WIDTH_BUCKET(TRUNC((SYSDATE - HIRE_DATE) / 365), 0, 20, 30) -1) * 1000 BONUS_WB
FROM EMPLOYEES ORDER BY BONUS_WB DESC;

--Q11. EMPLOYEES 테이블에서 commission_pct 의  Null값 갯수를  출력하세요.
--A.
SELECT COUNT(*) FROM EMPLOYEES
    WHERE COMMISSION_PCT IS NULL;
    
--Q12. EMPLOYEES 테이블에서 deparment_id 가 없는 직원을 추출하여  POSITION을 '신입'으로 출력하세요.
--A.
SELECT LAST_NAME, DEPARTMENT_ID, NVL(TO_CHAR(DEPARTMENT_ID, '신입') POSITION
FROM EMPLOYEES WHERE DEPARTMENT_ID IS NULL;

--Q13. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력(join~on, where 로 조인하는 두 가지 방법 모두)
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

--Q14.  employees 테이블에서 이름에 FIRST_NAME에 LAST_NAME을 붙여서 'NAME' 컬럼명으로 출력하세요.
--예) Steven King
--A. 
SELECT * FROM EMPLOYEES;
SELECT CONCAT(FIRST_NAME , LAST_NAME) AS NAME FROM EMPLOYEES;

SELECT FIRST_NAME||''||LAST_NAME AS NAME FROM EMPLOYEES;

--Q15. HR 테이블들을 분석해서 전체 현황을 설명할 수 있는 요약 테이블을 작성하세요. (예 : 부서별 평균 SALARY 순위)
--A.
-- 부서별 직책별 평균 SALARY 순위
SELECT * FROM EMPLOYEES;
SELECT DEPARTMENT_ID, JOB_ID, ROUND(AVG(SALARY)) FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID, JOB_ID
    ORDER BY ROUND(AVG(SALARY)) DESC;

SELECT D.DEPARTMENT_NAME, ROUND(AVG(E.SALARY)) AVG
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME
ORDER BY AVG DESC;

--Q16. HR EMPLOYEES 테이블에서 escape 옵션을 사용하여 아래와 같이 출력되는 SQL문을 작성하세요.
--job_id 칼럼에서  _을 와일드카드가 아닌 문자로 취급하여 '_A'를 포함하는  모든 행을 출력
--A.
-- ESCAPE로 정한 문자 바로 뒤의 문자는 일반문자로 인식한다.
SELECT JOB_ID FROM EMPLOYEES;
SELECT JOB_ID FROM EMPLOYEES
    WHERE JOB_ID LIKE '%#_A%' ESCAPE '#';

--Q17. HR EMPLOYEES 테이블에서 SALARY, LAST_NAME 순으로 올림차순 정렬하여 출력하세요.
--A. 
SELECT SALARY, LAST_NAME FROM EMPLOYEES
    ORDER BY SALARY, LAST_NAME ASC;
   
--Q18. Seo라는 사람의 부서명을 출력하세요.
--A.
SELECT * FROM EMPLOYEES;
   
SELECT DEPARTMENT_NAME FROM DEPARTMENTS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME = 'Seo');

--Q19. LMEMBERS 데이터에서 고객별 구매금액의 합계를 구한 CUSPUR 테이블을 생성한 후 CUST 테이블과 
--고객번호를 기준으로 결합하여 출력하세요.
--오른쪽 위에 마당으로 바꿔주고 밑에 2개 다 실행시키기.
CREATE TABLE CUSPUR AS SELECT 고객번호, SUM(구매금액) 구매금액 FROM PRODPUR
GROUP BY 고객번호
ORDER BY 고객번호;

SELECT * FROM CUSPUR;

SELECT * FROM PRODPUR;

--Q20.purprd 테이블의 2년간 구매금액을 연간 단위로 분리하여 구매14, 구매15 컬럼을 포함하는 AMT_YEAR 테이블을 
--생성한 후 14년과 15년의 구매금액 차이를 표시하는 증감 컬럼을 추가하여 출력하세요.
--단, 고객번호, 제휴사별로 구매금액 및 증감이 구분되어야 함.
--마당으로 실행
CREATE TABLE AMT14 AS SELECT 고객번호, 제휴사, SUM(구매금액) 구매금액
FROM PRODPUR
WHERE 구매일자 < '20150101'
GROUP BY 고객번호, 제휴사
ORDER BY 고객번호;

SELECT * FROM AMT14;

CREATE TABLE AMT15 AS SELECT 고객번호, 제휴사, SUM(구매금액) 구매금액
FROM PRODPUR
WHERE 구매일자 > '20141231'
GROUP BY 고객번호, 제휴사
ORDER BY 고객번호;

SELECT * FROM AMT15;

--FULL OUTER JOIN 테이블 생성
CREATE TABLE AMT_YEAR_FOJ
AS SELECT A4.고객번호, A4.제휴사, A4.구매금액 구매14, A5.구매금액 구매15
FROM AMT14 A4 FULL OUTER JOIN AMT15 A5
ON (A4.고객번호 = A5.고객번호 AND A4.제휴사 = A5.제휴사);

SELECT * FROM AMT_YEAR_FOJ;
SELECT 고객번호, 제휴사, NVL(구매14, 0) 구매14, NVL(구매15, 0) 구매15,
(NVL(구매15, 0) - NVL(구매14, 0)) 증감
FROM AMT_YEAR_FOJ A;

DROP TABLE AMT14;
DROP TABLE AMT15;
DROP TABLE AMT_YEAR_FOJ;
DROP TABLE CUSPUR;