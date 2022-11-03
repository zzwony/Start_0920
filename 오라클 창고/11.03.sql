SELECT * FROM EMP
WHERE JOB = 'CLERK';

-- EMP 테이블에서 직책이 CLEARK인 사람의 이름은?
SELECT ENAME FROM EMP
WHERE JOB = 'CLERK';

-- EMP 테이블에서 직책이 CLERK이고 고용일이 1990이전인 사람의 이름은?
SELECT ENAME FROM EMP
WHERE JOB = 'CLERK'
AND HIREDATE < '1990/01/01';

-- TO_DATE
SELECT * FROM EMP 
WHERE JOB = 'CLERK' 
AND HIREDATE <= TO_DATE('01-01-90', 'DD-MM-YY'); 
                --P164   --문자열       --포멧 상태

-- 급여가 2500이상이고 직업이 ANALYST인 사원 정보만 나오도록 코드를 채워보기
SELECT * FROM EMP
WHERE SAL >= 2500
AND JOB = 'ANALYST';

-- 급여가 3000이면서 SALESMAN이 아닌 사람을 조회하기
SELECT * FROM EMP
WHERE SAL <> 3000
AND JOB <> 'SALESMAN';

-- NOT 연산자
SELECT * FROM EMP
WHERE NOT SAL =3000;

-- JOB이 MANAGER 이거나 SALESMAN 이거나 CLERK 인 사람은?
SELECT * FROM EMP
WHERE JOB = 'MANAGER'
    OR JOB = 'SALESMAN'
    OR JOB = 'CLERK';

SELECT * FROM EMP
WHERE JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

-- NOT IN
SELECT * FROM EMP
WHERE JOB NOT IN ('MANAGER', 'SALESMAN', 'CLERK');

-- 부서 번호가 10, 20번인 사원 정보만 나오기
SELECT * FROM EMP
WHERE DEPTNO IN (10,20);

-- 급여가 2000이상이고 3000이하인 레코드
SELECT * FROM EMP
WHERE SAL >= 2000 AND SAL <=3000;

-- BETWEEN A AND B
SELECT * FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;

-- NOT 붙이기
SELECT * FROM EMP
WHERE SAL NOT BETWEEN 2000 AND 3000;

-- LIKE 연산자, '%', '_'
SELECT * FROM EMP
WHERE ENAME LIKE 'S%';

SELECT * FROM EMP
WHERE ENAME LIKE '_M%';

-- 사원 이름에 AM이 포함되어 잇는 사원 데이터만 출력하기
SELECT * FROM EMP
WHERE ENAME LIKE '%AM%';

SELECT * FROM EMP
WHERE ENAME LIKE '_AM%';

-- IS NULL
SELECT * FROM EMP
WHERE COMM IS NULL;

SELECT * FROM EMP
WHERE COMM IS NOT NULL;

-- 집합 연산자
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
--출력결과 에러가 나타난다.
--같은것을 가져오는게 문제가 아니라 쓰여지는 순서가 같아야 한다.\

SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, DEPTNO, SAL FROM EMP
WHERE DEPTNO = 20;
-- 에러가 나지 않는다. 하지만 출력 결과를 보면 잘못된 것을 알 수 있다.
-- 먹히는 이유는 SAL도 숫자고 DEPTNO도 숫자이기 때문에 그냥 붙여버렸다.
-- 그래서 오류가 발생하지 않았다.
-- 아까 했던 것이 오류가 나타났던 이유는 
-- 하나는 문자고 하나는 숫자익 때문에 에러가 발생함.

SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL FROM EMP
WHERE DEPTNO = 20;
-- 역시 갯수가 맞지 않으니 에러를 발생시킨다.


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
-- 20자리 데이터만 남았다.

SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10 OR DEPTNO = 20
INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10;






--06장
--UPPER. LOWER, INITCAP 함수
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME) FROM EMP;

--UPPER 함수로 문자열 비교하기
-- 사원 이름이 SCOTT인 데이터 찾기
SELECT * FROM EMP
WHERE UPPER(ENAME) = 'SCOTT';
-- 뭐라고 되어있든(sCOTT, SCOtt...) 상관없이 SCOTT을 찾아낸다.

SELECT * FROM EMP
WHERE UPPER(ENAME) LIKE UPPER('%co%');
