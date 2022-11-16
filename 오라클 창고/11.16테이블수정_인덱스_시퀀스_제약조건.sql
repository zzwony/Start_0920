CREATE TABLE DEPT_TEMP
    AS SELECT * FROM DEPT;

SELECT * FROM DEPT_TEMP;

-- 50, 'DATABASE', 'SEOUL'을 추가하기
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
    VALUES(50, 'DATABASE', 'SEOUL');

-- 60, 'BUSAN'을 추가하기
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
    VALUES(60, NULL, 'BUSAN');

DROP TABLE EMP_TEMP;
COMMIT;

-- EMP_TEMP 빈 테이블 만들기
CREATE TABLE EMP_TEMP
    AS SELECT *
        FROM EMP
        WHERE 1 <> 1;

SELECT * FROM EMP_TEMP;

-- EMPNO에는 1, HIREDATE에는 오늘 날짜 넣기
INSERT INTO EMP_TEMP(EMPNO, HIREDATE)
    VALUES(1, SYSDATE);
    
-- EMP에서 DEPTNO가 30인 사원만 EMP_TEMP에 넣기
INSERT INTO EMP_TEMP
    SELECT * 
        FROM EMP
        WHERE DEPTNO = 30;

SELECT *
    FROM DEPT_TEMP;

DROP TABLE DEPT_TEMP;
COMMIT;
-- DEPTNO가 10인 사원의 LOC를 'SEOUL'로 수정하기
UPDATE DEPT_TEMP
    SET LOC = 'SEOUL'
    WHERE DEPTNO = 10;

-- LOC가 BUSAN인 사원들의 DEPTNO 50으로, DNAME은 SALES로 수정하기
UPDATE DEPT_TEMP
    SET DEPTNO = 50,
        DNAME = 'SALES'
    WHERE LOC = 'BUSAN'; 

SELECT *
    FROM EMP_TEMP;

-- JOB = 'SALESMAN'을 삭제하기
DELETE FROM EMP_TEMP
    WHERE JOB = 'SALESMAN';

---------------------------------오늘 진도---------------------------------------
SELECT * FROM DEPT_TEMP;

DELETE FROM DEPT_TEMP
    WHERE DEPTNO = 50;
COMMIT;  -- 커밋을 하면 수정된 정보가 저장되어서 SQL_PLUS에 입력되면 적용되어 있다.

UPDATE DEPT_TEMP
    SET LOC = 'SEOUL'
    WHERE DEPTNO = 30;

UPDATE DEPT_TEMP
    SET LOC = 'NEW YORK'
    WHERE DEPTNO = 10;  -- 여기서 SQL_PLUS에 들어가서 실행하면 디벨로퍼에서 먼저 실행중이여서 대기 상태가 된다.
    
SELECT * FROM DEPT_TEMP;
COMMIT; -- 커밋으로 저장해줘야지 플러스에서 수정이 가능하다.

-- P318
CREATE TABLE EMP_ALTER
    AS SELECT * FROM EMP;
    
SELECT * FROM EMP_ALTER;

ALTER TABLE EMP_ALTER
    ADD HP VARCHAR2(20);

ALTER TABLE EMP_ALTER
    RENAME COLUMN HP TO TEL;

ALTER TABLE EMP_ALTER
    MODIFY EMPNO NUMBER(5);

ALTER TABLE EMP_ALTER
    DROP COLUMN TEL;

SELECT * FROM EMP_ALTER;

--테이블 이름 변경
RENAME EMP_ALTER TO EMP_RENAME;
SELECT * FROM EMP_RENAME;

--테이블 데이터 삭제
TRUNCATE TABLE EMP_RENAME;

-- 테이블 삭제
DROP TABLE EMP_RENAME;

--★P335 인덱스
SELECT * FROM USER_INDEXES;  -- 인덱스 정보

SELECT *
    FROM USER_IND_COLUMNS;

--인덱스 만들기
CREATE INDEX IDX_EMP_SAL
    ON EMP(SAL);

--뷰
-- 권한 부여하기  여기서부터 다시 하기
-- system으로 들어가서 밑에 코드 치고 권한 받아야함.
GRANT CREATE VIEW TO SCOTT;

CREATE VIEW VW_EMP20
    AS (SELECT EMPNO, ENAME, JOB, DEPTNO
         FROM EMP
         WHERE DEPTNO = 20);

SELECT ENAME
    FROM VW_EMP20
    WHERE JOB = 'CLERK';

-- DEPTNO가 20인 사원중에서 JOB이 CLERK인 사람의 근무지는?
SELECT D.LOC, V.ENAME, V.JOB 
    FROM DEPT D, VW_EMP20 V    -- 여기가 인라인 뷰
    WHERE D.DEPTNO = V.DEPTNO
        AND JOB = 'CLERK'; 

SELECT * 
    FROM USER_VIEWS;

-- 실습 13-18
SELECT *
    FROM VW_EMP20;

-- 뷰 지우기 DROP VIEW

-- 실습 13-20
-- ROWNUM
-- 의사 열(수도 칼럼 이라고 부른다)
SELECT *
    FROM EMP;
    
SELECT ROWNUM, *
    FROM EMP;  --라고 하면 오류 발생, 이유는 없는 칼럼을 썼기 때문이다.

SELECT ROWNUM, EMP.*
    FROM EMP;  -- 출력결과 ROWNUM이 생기고 자동으로 번호를 부여했다.

SELECT ROWNUM, EMP.*
    FROM EMP
    ORDER BY ENAME;  -- ENAME은 A-Z순으로 정렬되었지만 ROWNUM은 이름을 따라 움직여서 뒤죽박죽 섞인다.

--P347 
-- 급여(SAL)의 상위 10명을 내림차순으로 정렬하기
SELECT ROWNUM, S.*
FROM (SELECT *
        FROM EMP
        ORDER BY SAL DESC) S
WHERE ROWNUM <= 10;

-- 뷰 만들고 이름 짓기
CREATE VIEW VW_EMP_SAL
    AS (SELECT *
        FROM EMP
        ORDER BY SAL DESC);   -- 실행하면 누락된 우괄호 라는 에러 발생
                              -- 괄호가 있는데 왜 없다고 할까? 그래서 ORDER BY를 빼고 실행 시키면 잘 작동 된다.
                              -- 결국 괄호의 문제가 아니였다.
CREATE VIEW VW_EMP_SAL
    AS (SELECT *
        FROM EMP);            -- 잘 만들어진다.
                              -- 괄호 문제 상관없이 뷰 만들땐 ORDER을 만들 수 없기 때문에 에러가 발생했다.
                              -- ORDER 넣으려면 괄호 안에 넣어줘야한다.
        
--★ 규칙에 따라 순번을 생성하는 시퀀스
-- 실습 13-26
CREATE TABLE DEPT_SEQUENCE
    AS SELECT *
        FROM DEPT
        WHERE 1 <> 1;  --껍데기만 가져왔다.

SELECT * FROM DEPT_SEQUENCE; -- 출력결과 껍데기가 만들어짐

INSERT INTO DEPT_SEQUENCE
    VALUES (5, 'DATABASE', 'SEOUL');

INSERT INTO DEPT_SEQUENCE
    VALUES (5, 'DATABASE', 'BUSAN');

-- 시퀀스 생성하기
CREATE SEQUENCE SEQ_DEPT_SEQUENCE
    INCREMENT BY 2
    START WITH 10;

INSERT INTO DEPT_SEQUENCE
    VALUES (SEQ_DEPT_SEQUENCE.NEXTVAL, 'DATABASE', 'BUSAN');

SELECT * FROM DEPT_SEQUENCE;  -- INCREMENT BY 덕분에 자동으로 증가한다.
-- 증가 값을 바꾸고 싶으면 지우고 다시 만들어야한다.

-- 현재
SELECT SEQ_DEPT_SEQUENCE.CURRVAL
    FROM DUAL;

--다음값
SELECT SEQ_DEPT_SEQUENCE.NEXTVAL
    FROM DUAL;
    

-- 동의어 
-- 실습 p13-38
-- SYSYEM에 권한 부여하기
CREATE SYNONYM E
    FOR EMP;

SELECT *
    FROM E;

SELECT *
    FROM VW_EMP_SAL;
    
CREATE SYNONYM V
    FOR VW_EMP_SAL;

SELECT * 
    FROM V;

DROP SYNONYM E;


-- P362
CREATE TABLE TABLE_NOTNULL(
      LOGIN_ID VARCHAR2(20)     NOT NULL,  --아이디와 비밀번호는 NULL값이 되면 안된다는 제약조건을 걸었다.
      LOGIN_PWD VARCHAR2 (20)   NOT NULL,
      TEL       VARCHAR2 (20)
    );
    
INSERT INTO TABLE_NOTNULL
    VALUES('ID', 'PASS', '02-55');

SELECT *
    FROM TABLE_NOTNULL;

DROP TABLE TABLE_NOTNULL;
    
CREATE TABLE TABLE_NOTNULL(
      LOGIN_ID VARCHAR2(20)     UNIQUE,  --유니크 조건은 유일해야한다.
      LOGIN_PWD VARCHAR2 (20)   NOT NULL,
      TEL       VARCHAR2 (20)
    );
    
INSERT INTO TABLE_NOTNULL
    VALUES('ID', 'PASS', '');  -- 에러 발생, 앞에 ID를 썼기 때문에 유니크에 위배되므로 에러가 발생한다.
                                -- 그렇다면 아이디를 안쓰면?
INSERT INTO TABLE_NOTNULL
    VALUES('', 'PASS', '');  -- 이렇게 하면 삽입된다. 유니크 조건에 벗어나기 때문에 NULL값으로 출력된다.
                            -- 유니크에 위배되지 않으면서 NOT NULL이려면 PRIMARY KEY(기본키)을 넣으면 된다.
                            
CREATE TABLE TABLE_NOTNULL(
      LOGIN_ID VARCHAR2(20)     PRIMARY KEY, -- 중복되어도 안되고 값이 비어있어도 안된다.
      LOGIN_PWD VARCHAR2 (20)   NOT NULL,
      TEL       VARCHAR2 (20)
    );

INSERT INTO TABLE_NOTNULL
    VALUES('ID', 'PASS', '02-55');

INSERT INTO TABLE_NOTNULL
    VALUES('', 'PASS', '');  -- 에러가 발생할수 밖에 없다. 기본키 위배.
    
-- P364 실습 14-5
-- 제약 조건 확인
SELECT *
    FROM USER_CONSTRAINTS;

-- 실습 14-39
CREATE TABLE DEPT_PK(
    DEPTNO NUMBER(2) PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC     VARCHAR2(13));

CREATE TABLE EMP_FK(
    EMPNO NUMBER(2) PRIMARY KEY,
    ENAME VARCHAR2(10),
    DEPTNO NUMBER(2) REFERENCES DEPT_PK (DEPTNO));  -- REFERENCES는 뒤에를 참조하고 있다는 뜻

SELECT * FROM DEPT_PK;

INSERT INTO DEPT_PK
    VALUES(11, 'NAME', 'SEOUL');
INSERT INTO DEPT_PK
    VALUES(12, 'NAME', 'SEOUL');

INSERT INTO EMP_FK
    VALUES(50, 'NAME', 11);

INSERT INTO EMP_FK
    VALUES(52, 'SMITH', 12);

SELECT * FROM EMP_FK;

INSERT INTO EMP_FK
    VALUES(52, 'SMITH', 13);  -- 실행 시키면 에러 발생. 부모를 참조하기 하는데 부모키에 13이라는게 없다. 그래서 에러 발생

