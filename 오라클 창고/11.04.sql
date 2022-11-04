-- SMITH의 근무부서와 연봉을 출력해 주세요.
SELECT SAL*12 AS YEAR, DEPTNO FROM EMP
WHERE ENAME = 'SMITH';



-- 보너스(COMM)이 없었던 사원들의 이름과 부서번호
SELECT ENAME, DEPTNO FROM EMP
WHERE COMM IS NULL;



-- 입사일이 1985년 이후인 사원정보
SELECT * FROM EMP;

SELECT * FROM EMP
WHERE HIREDATE >= '1985-01-01' ; 



-- 급여가 2000이상 3000이하인 사원의 이름과 급여
SELECT ENAME, SAL FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;



-- 직책이 SALESMAN이 아닌 사람들
SELECT ENAME FROM EMP
WHERE JOB <> 'SALESMAN';

SELECT ENAME FROM EMP
WHERE JOB NOT IN 'SALESMAN';



-- 직책이 SALESMAN 이거나 MANAGER 이거나 CLERK 인 사람
SELECT ENAME FROM EMP
WHERE JOB IN ('SALESMAN', 'MANAGER', 'CLERK');



-- 이름에 TT가 들어있는 이름
SELECT ENAME FROM EMP
WHERE ENAME LIKE '%TT%';



-- 이름의 3번째 알파벳이 O인 사람
SELECT ENAME FROM EMP
WHERE ENAME LIKE '__O%';



-- 사원 이름이 소문자로 출력하기
SELECT LOWER(ENAME) FROM EMP;



-- 단일행함수 SINGLE ROW     1대1로 아웃풋을 냄
-- 다중행함수 MULTIPLE ROWS  N대1로 아웃풋을 냄



-- 문자열의 길이를 알기
SELECT ENAME, LENGTH(ENAME) FROM EMP;
-- 길이가 5이상
SELECT ENAME FROM EMP
WHERE LENGTH(ENAME) >= 5;



-- B는 바이트의 수를 나타낸다.
-- 영어는 한 글자당 1바이트이지만, 한글은 2바이트이다.
SELECT ENAME FROM EMP
WHERE LENGTHB(ENAME) >= 5;

SELECT LENGTH('한글'), LENGTHB('한글') FROM EMP;

SELECT LENGTH('한글'), LENGTHB('한글') FROM DUAL;



-- 빼기 : MINUS, 파이썬은 subtract 이라고 했다.
-- SUBSTR은 뺀다는 의미가 아니라 STRING의 부분집합을 말한다.
-- SUBSTR(무엇에 대하여, 시작위치, 길이)
SELECT JOB, SUBSTR(JOB, 2, 2) FROM EMP;

SELECT JOB, SUBSTR(JOB, 2, 2) FROM EMP;

SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 2, 3), SUBSTR(JOB, 3, 4) FROM EMP;

SELECT JOB, SUBSTR(JOB, -4, 2), SUBSTR(JOB, -4, 3), SUBSTR(JOB, -4, 4) FROM EMP;

SELECT JOB, SUBSTR(JOB, -LENGTH(JOB), 2) FROM EMP; -- -LENGTH는 결국 1을 나타낸다.



--INSTR
SELECT INSTR('HELLO, ORACLE!', 'L') FROM DUAL; -- L이라는 것을 찾아라, DUAL을 항상 써준다.
                                               -- L이 처음 발견된 인텍스 위치(3번째)을 알려준다.
SELECT INSTR('HELLO, ORACLE!', 'L', 5) FROM DUAL; -- 12의 뜻이 무엇인가?
                                                  -- 찾기 시작 위치이다. 5번째 인텍스 이후를 찾아라
                                                  -- 그래서 HELLO를 무시하고 처음 나오는 ORACLE의 L을 찾은 것이다.
SELECT INSTR('HELLO, ORACLE!', 'L', 2, 2) FROM DUAL; -- 2 다음 2의 뜻은?
                                                     -- 몇 번째(두 번째) 나오는 L을 찾아라
                                                     -- L을 찾기는 찾되 두번째 L을 찾은것이다.



-- REPLACE
SELECT REPLACE('010-1234-5678', '-', ' ') FROM DUAL;



-- LPAD, RPAD
-- PADDING은 채워넣기 라는 기본적인 의미가 있다.
-- L은 왼쪽, R은 오른쪽으로 채워넣는다.
SELECT LPAD('ORACLE', 10, '#') FROM DUAL;

SELECT RPAD('ORACLE', 10, '#') FROM DUAL;

SELECT RPAD('010-1234-', 13, '*') FROM DUAL; -- 13칸을 잡으면 4칸이 비는데 오른쪽부터 * 표시로 채워라



-- CONCAT
SELECT CONCAT (EMPNO, ENAME) FROM EMP;

SELECT CONCAT (EMPNO, CONCAT(' : ', ENAME)) FROM EMP; -- EMPNO, :, ENAME 이 3개를 한번에 붙일 수 없기 때문에
                                                      -- 이렇게 해줬다.



-- LSTRIP, RSTRIP, STRIP은 빈 여백이 있으면 방향에 맞춰서 지워줌
-- LTRIM, RTRIM, TRIM의 기능도 같다.
SELECT TRIM('  ORACLE!  ') FROM DUAL;

SELECT LTRIM('  ORACLE!  ') FROM DUAL;

SELECT RTRIM('  ORACLE!  ') FROM DUAL; -- 안지워진것처럼 보이는데 칼럼 이름이 길어서 안지워진것처럼 보이는것

SELECT RTRIM('  ORACLE!  ', '!') FROM DUAL;  -- 느낌표 지우기
                                             -- 어디에 있는지 방향 확인하고 정해줘야지 지워준다.



-- ROUND
-- TRUNC 잘라서 버리기
-- CEIL, FLOOR은 가까운 정수를 반환해준다.
-- MOD

SELECT ROUND(1234.5678, 1) FROM DUAL;  -- 소수점 1자리 까지, 반올림

SELECT TRUNC(1234.5678, 1) FROM DUAL;  -- 잘라서 버림

SELECT CEIL(1234.5678) FROM DUAL; -- 반올림 아니라 올림
SELECT FLOOR(1234.5678) FROM DUAL;

SELECT MOD(15, 4) FROM DUAL;  -- 나머지만 돌려주는 함수



-- SYSDATE
SELECT SYSDATE FROM DUAL; -- 날짜 함수이다.

SELECT SYSDATE-1 FROM DUAL; -- 날짜에서 더하기, 빼기 가능하다.
SELECT SYSDATE+1 FROM DUAL;



-- ADD_MONTHS
SELECT ADD_MONTHS(SYSDATE, 3) FROM DUAL; -- 월 단위로 더하기

-- 사원 이름, 입사 날짜를 출력하기
SELECT ENAME, HIREDATE FROM EMP;
-- 입사 날짜에서 120개월을 더한 새로운 칼럼을 출력하기
SELECT ENAME, HIREDATE, ADD_MONTHS(SYSDATE,120) AS WORK10YEAR FROM EMP; -- 별칭 지어줄때 숫자가 먼저 나오면 오류가 발생한다.

-- SYSDATE와 ADD_MONTHS 함수를 사용하여 현재 날짜와 6개월 후 날짜를 출력하기
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 6) FROM DUAL;



-- MONTHS_BETWEEN
-- 두 날짜 간의 월 단위로 개월수를 보여준다.
SELECT ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE)) FROM EMP;
SELECT ROUND(SYSDATE - HIREDATE) FROM EMP;
