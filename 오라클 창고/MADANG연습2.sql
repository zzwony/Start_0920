SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;

SELECT BOOKNAME
    FROM BOOK
    WHERE BOOKID = 1;

SELECT SUM(SALEPRICE)
    FROM ORDERS
    WHERE CUSTID = 1;

SELECT COUNT(CUSTID)
    FROM ORDERS
    WHERE CUSTID = (SELECT CUSTID
                    FROM CUSTOMER
                    WHERE NAME = '박지성');

SELECT DISTINCT B.PUBLISHER
FROM BOOK B, ORDERS O
WHERE B.BOOKID = O.BOOKID
AND O.CUSTID = (SELECT CUSTID
                FROM CUSTOMER
                WHERE NAME = '박지성'); 

SELECT COUNT(BOOKID)
    FROM BOOK;

SELECT NAME, ADDRESS
    FROM CUSTOMER;

SELECT NAME, ADDRESS
    FROM CUSTOMER
    WHERE NAME LIKE '김%';

--(4) 성은 '김'씨이고 이름은 '아'로 끝나는 고객의 이름과 주소
SELECT NAME, ADDRESS
    FROM CUSTOMER
    WHERE NAME LIKE '김%아';

--(5) 주문 금액의 종액과 주문의 평균 금액
SELECT SUM(SALEPRICE), AVG(SALEPRICE)
    FROM ORDERS;

--(6) 고객의 이름과 고객별 구매액
SELECT NAME, SUM(SALEPRICE) 
    FROM ORDERS 
    JOIN CUSTOMER  USING (CUSTID) 
    GROUP BY NAME; 

--(7) 박지성이 구매한 도서의 출판사와 같은 출판사에서 나온 도서를 구매한 고객의 이름
SELECT NAME
FROM CUSTOMER   JOIN ORDERS USING (CUSTID)
                JOIN BOOK USING (BOOKID)
    WHERE PUBLISHER IN (SELECT PUBLISHER
                             FROM BOOK JOIN ORDERS USING(BOOKID)
                             WHERE CUSTID = 1); 

--(8) 새로운 도서 (스포츠 세계, 대한미디어, 10000원)이 마당서점에 입고되었다.
INSERT INTO BOOK
    VALUES ('스포츠 세계', '대한미디어', 10000);
-- 에러 해결하기
INSERT INTO BOOK
    VALUES (11, '스포츠 세계', '대한미디어', 10000);

SELECT * FROM BOOK;

--(9) 삼성당 에서 출판한 도서를 삭제하기
DELETE FROM BOOK
    WHERE PUBLISHER = '삼성당';

--(10)이상 미디어를 불러보니 책이 2권이 있다. 이 2권을 삭제하기
DELETE FROM BOOK
    WHERE PUBLISHER = '이상미디어';
-- 에러 해결하기
-- 제약조건을 찾아서 그 자체를 만들때 변경해줘야 한다.
-- 해결 안됌
SELECT * FROM BOOK WHERE PUBLISHER = '이상미디어';
DELETE FROM BOOK WHERE PUBLISHER = '이상미디어';

--조회하기
SELECT * FROM ALL_CONSTRAINTS  --CONSTRAINT_NAME을 바꿔줘야한다.
    WHERE TABLE_NAME = 'BOOK';

SELECT * FROM ALL_CONSTRAINTS
    WHERE TABLE_NAME = 'ORDERS';



-- (11) 출판사 '대한미디어'를 '대한 출판사'로 이름을 바꾸기
UPDATE BOOK
    SET PUBLISHER = '대한출판사'
    WHERE PUBLISHER = '대한미디어'; 

