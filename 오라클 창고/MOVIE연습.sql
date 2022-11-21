-- MOVIE 라는 데이터베이스 만들기
-- SYSTEM에 권한 주기
-- GRANT CONNECT, RESOURCE TO MOVIE; 

-- 테이블 생성 : 판매원
create table Salesperson(
	name varchar(20) primary key,
    age integer,
    salary integer
);
SELECT * FROM SALESPERSON;
-- 테이블 생성 : 고객
create table customer (
	name varchar(20) primary key,
    city varchar(20),
    industrytype varchar(20)
);

-- 테이블 생성 : 주문
create table orders (
	numbers integer,
    custname varchar(20),
    saesperson varchar(20),
    amount integer,
    foreign key (custname) references customer(name),
    foreign key (saesperson) references Salesperson(name)
);

-- 데이터 삽입 : 판매원
insert into salesperson(name, age, salary) values('Tom', '26', 10000);
insert into salesperson(name, age, salary) values('Roy', '32', 15000);
insert into salesperson(name, age, salary) values('Sally', '24', 9000);
insert into salesperson(name, age, salary) values('Nancy', '29', 7000);
insert into salesperson(name, age, salary) values('Clara', '40', 8500);

-- 데이터 삽입 : 고객
insert into customer(name, city, industrytype) values('Mary', 'LA', '개발자');
insert into customer(name, city, industrytype) values('Carrie', 'LA', '요리사');
insert into customer(name, city, industrytype) values('IU', 'KR', '가수');
insert into customer(name, city, industrytype) values('Diane', 'LA', '개발자');
insert into customer(name, city, industrytype) values('Grace', 'DE', '요리사');
insert into customer(name, city, industrytype) values('Nancy', 'MX', '교육자');
insert into customer(name, city, industrytype) values('Frank', 'US', '교육자');

-- 데이터 삽입 : 주문
insert into orders (numbers, custname, saesperson, amount) values('1', 'Mary','Tom', 1000);
insert into orders(numbers, custname, saesperson, amount) values('2', 'IU','Sally', 2000);
insert into orders(numbers, custname, saesperson, amount) values('3', 'Diane','Nancy', 3000);
insert into orders(numbers, custname, saesperson, amount) values('4', 'Grace','Roy', 4000);
insert into orders(numbers, custname, saesperson, amount) values('5', 'Nancy','Tom', 5000);
insert into orders(numbers, custname, saesperson, amount) values('6', 'Diane','Sally', 6000);
insert into orders(numbers, custname, saesperson, amount) values('7', 'Grace','Roy', 7000);
insert into orders(numbers, custname, saesperson, amount) values('8', 'Nancy','Nancy', 8000); 






--(1) 나이가 30세 미만인 판매원의 이름
select name
from salesperson
where age < 30; 

--(2) 'S'로 끝나는 도시에 사는 고객의 이름
select name from customer where lower(city) like '%s'; 

--(3) 주문을 한 고객의 수 (서로 다른 고객)를 구하기 (ORDERS에서)
SELECT * FROM ORDERS;

SELECT COUNT(DISTINCT CUSTNAME)
    FROM ORDERS;

--(4) 판매원 각각에 대하여 주문받은 수를 계산하기
SELECT  DISTINCT SAESPERSON, 
                COUNT(SAESPERSON)
    FROM ORDERS
    GROUP BY SAESPERSON;