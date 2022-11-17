CREATE VIEW VW_EMP20
    AS(SELECT EMPNO, ENAME, JOB, DEPTNO
        FROM EMP
        WHERE DEPTNO = 20);

SELECT * FROM VW_EMP20;

DROP VIEW VW_EMP20;

-- VIEW 만들때 ORDER을 못만드는걸로 알고 있는데
-- 괄호를 빼버리면 내용도 같고 정렬도 가능하다.
CREATE VIEW VW_EMP20
    AS SELECT EMPNO, ENAME, JOB, DEPTNO
        FROM EMP
        WHERE DEPTNO = 20
        ORDER BY ENAME;
        
-- ROWNUM 급여의 상위 10명을 내림차순으로 정렬하기
-- ROWNUM을 써줘야 숫자가 부여된다.
SELECT ROWNUM, S.*
    FROM (SELECT *
            FROM EMP
            ORDER BY SAL DESC)S
    WHERE ROWNUM <= 10;

-- 급여가 내림차순으로 정렬된 뷰를 만들고, 상위 10명을 출력하기
CREATE VIEW DESC_VIEW
    AS SELECT * 
            FROM EMP
            ORDER BY SAL DESC;
SELECT ROWNUM, DESC_VIEW.*
    FROM DESC_VIEW
    WHERE ROWNUM <= 10;
    
DROP TABLE DEPT_TEMP;

    
-- 예제
CREATE TABLE DEPT_TEMP
    AS (SELECT *
            FROM DEPT);
SELECT * FROM DEPT_TEMP;        
-- 시카고를 부산으로 바꾸기
UPDATE DEPT_TEMP
    SET LOC = 'BUSAN'
    WHERE LOC = 'CHICAGO';
-- LOC 칼럼을 모두 'DAEGU'로 바꾸기
UPDATE DEPT_TEMP
    SET LOC = 'DAEGU';
-- DEPT_TEMP 테이블의 모든 데이터 삭제하기
TRUNCATE TABLE DEPT_TEMP;
-- DEPT_TEMP 테이블에 DEPT의 모든 ROW을 삽입하기
INSERT INTO DEPT_TEMP
    SELECT * FROM DEPT; 


---------------------오늘 진도---------------------------------------------------
--ON DELETE CASCADE
--CHECK
--DEFAULT

--15. 사용자,권한, 롤 관리
--스키마

-- 사용자 생성
-- 밑에 코드를 시스템에 실행시키기
CREATE USER ORCLSTUDY
INDENTIFIED BY ORCLSTUDY;

--패스워드 변경
--삭제

--롤 관리


-- P405
-- SYSTEM에 실행시키기
GRANT RESOURCE, CONNECT TO ORCLSTUDY;

--P414 실습 15-14
--SYSTEM에 실행시키기
CREATE ROLE ROLE_NAME;
GRANT CONNECT, RESOURCE, CREATE VIEW TO ROLE_NAME;
GRANT ROLE_NAME TO ORCLSTUDY;


--------------------------------------------------------------------------------
--------------------연습---------------------------------------------------------
-- 만약 잘못만들어서 지우고 싶다면 SYSTEM에서 DROP USER MADANG; 실행하기
-- 단축키
-- 라인정리 CTRL + SHIFT + F
-- 스크립트 모든 쿼리 실행(일부 드래그 실행도 가능) F5
-- 주석 CTRL + -
-- 주석 해제 CTRL + SHIFT + -
-- 1. MADANG 사용자를 만들기
-- 시스템에 실행시키기
CREATE USER MADANG
IDENTIFIED BY ORACLE;  -- 여기까지가 만들기
GRANT CREATE SESSION, CREATE TABLE TO MADANG;  -- 만들었으니 권한부여

-- 그 다음 접속 선택으로 가서 마당으로 접속하기
-- 사진 첨부하기

-- 2. BOOKS라는 테이블 만들기 (접속한 마당에서 입력하기)
-- 칼럼은 BNAME, PUB
CREATE TABLE BOOKS (
    BNAME   VARCHAR2(40),
    PUB     VARCHAR2(40)
);



--3. 밑에 코드를 마당 에다가 붙여넣고 실행시키기
-- 처음 실행시는 아래 4문장의 오류는 무시한다.  
DROP TABLE Orders ;
DROP TABLE Book ;
DROP TABLE Customer ;
DROP TABLE Imported_Book ; 

CREATE TABLE Book (
  bookid      NUMBER(2) PRIMARY KEY,
  bookname    VARCHAR2(40),
  publisher   VARCHAR2(40),
  price       NUMBER(8) 
);

CREATE TABLE  Customer (
  custid      NUMBER(2) PRIMARY KEY,  
  name        VARCHAR2(40),
  address     VARCHAR2(50),
  phone       VARCHAR2(20)
);


CREATE TABLE Orders (
  orderid NUMBER(2) PRIMARY KEY,
  custid  NUMBER(2) REFERENCES Customer(custid),
  bookid  NUMBER(2) REFERENCES Book(bookid),
  saleprice NUMBER(8) ,
  orderdate DATE
);
-- Book, Customer, Orders 데이터 생성
INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구아는 여자', '나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO Book VALUES(6, '역도 단계별기술', '굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');  
INSERT INTO Customer VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전',  NULL);

-- 주문(Orders) 테이블의 책값은 할인 판매를 가정함
INSERT INTO Orders VALUES (1, 1, 1, 6000, TO_DATE('2014-07-01','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (2, 1, 3, 21000, TO_DATE('2014-07-03','yyyy-mm-dd'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, TO_DATE('2014-07-03','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (4, 3, 6, 6000, TO_DATE('2014-07-04','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (5, 4, 7, 20000, TO_DATE('2014-07-05','yyyy-mm-dd'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, TO_DATE('2014-07-07','yyyy-mm-dd'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, TO_DATE( '2014-07-07','yyyy-mm-dd'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, TO_DATE('2014-07-08','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (9, 2, 10, 7000, TO_DATE('2014-07-09','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (10, 3, 8, 13000, TO_DATE('2014-07-10','yyyy-mm-dd'));

-- 여기는 3장에서 사용되는 Imported_book 테이블

CREATE TABLE Imported_Book (
  bookid      NUMBER ,
  bookname    VARCHAR(40),
  publisher   VARCHAR(40),
  price       NUMBER(8) 
);
INSERT INTO Imported_Book VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO Imported_Book VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);

COMMIT; 