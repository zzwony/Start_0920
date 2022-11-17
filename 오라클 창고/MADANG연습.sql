CREATE TABLE BOOKS (
    BNAME   VARCHAR2(40),
    PUB     VARCHAR2(40)
);


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










--------------------------------------------------------------------------------
-- 연습
SELECT * FROM BOOK;
--1. 마당서점의 고객이 요구하는 다음 질문에 대해 SQL 문을 작성하기
--(1) 도서번호가 1인 도서의 이름
SELECT BOOKNAME
    FROM BOOK
    WHERE BOOKID = 1;

--(2) 가격이 2만원 이상
SELECT *
    FROM BOOK
    WHERE PRICE >= 20000;
    
--(3) 박지성의 총 구매액
SELECT * FROM Customer;
SELECT * FROM BOOK;
SELECT * FROM Orders;

SELECT SUM(O.SALEPRICE) 
    FROM ORDERS O, CUSTOMER C 
    WHERE O.CUSTID = C.CUSTID 
        AND C.NAME = '박지성'; 

SELECT SUM(SALEPRICE)
    FROM ORDERS
    WHERE CUSTID = (SELECT CUSTID
                        FROM CUSTOMER
                        WHERE NAME = '박지성');
    
--(4) 박지성이 구매한 도서의 수
SELECT SUM(CUSTID)
    FROM ORDERS
    WHERE CUSTID = (SELECT CUSTID
                        FROM CUSTOMER
                        WHERE NAME = '박지성');

--(5) 박지성이 구매한 도서의 출판사들 이름
SELECT PUBLISHER
    FROM BOOK
    WHERE BOOKID IN (SELECT BOOKID 
                        FROM ORDERS 
                        WHERE CUSTID = 1);  
    
-- 2. 마당서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL문을 작성하시오.
--(1) 마당서점 도서의 총 개수
SELECT COUNT(*)
    FROM BOOK;

--(2) 마당서점에 도서를 출고하는 출판사의 총 개수
SELECT * FROM Customer;
SELECT * FROM BOOK;
SELECT * FROM Orders;

SELECT COUNT(DISTINCT PUBLISHER)
    FROM BOOK;

--(3) 모든 고객의 이름과 주소
SELECT NAME, ADDRESS
    FROM CUSTOMER;

--(4) 2014SUS 7월 4일 ~ 7월 7일 상에 주문받은 도서의 주문번호
SELECT ORDERID
    FROM Orders
    WHERE ORDERDATE 
        BETWEEN TO_DATE('2014/07/04', 'YYYY/MM/DD')
            AND TO_DATE('2014/07/07', 'YYYY/MM/DD');

--(5) 성이 '김'씨인 고객의 이름과 주소
SELECT NAME, ADDRESS
    FROM CUSTOMER
    WHERE NAME LIKE '김%';


