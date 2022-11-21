-- MOVIE ��� �����ͺ��̽� �����
-- SYSTEM�� ���� �ֱ�
-- GRANT CONNECT, RESOURCE TO MOVIE; 

-- ���̺� ���� : �Ǹſ�
create table Salesperson(
	name varchar(20) primary key,
    age integer,
    salary integer
);
SELECT * FROM SALESPERSON;
-- ���̺� ���� : ��
create table customer (
	name varchar(20) primary key,
    city varchar(20),
    industrytype varchar(20)
);

-- ���̺� ���� : �ֹ�
create table orders (
	numbers integer,
    custname varchar(20),
    saesperson varchar(20),
    amount integer,
    foreign key (custname) references customer(name),
    foreign key (saesperson) references Salesperson(name)
);

-- ������ ���� : �Ǹſ�
insert into salesperson(name, age, salary) values('Tom', '26', 10000);
insert into salesperson(name, age, salary) values('Roy', '32', 15000);
insert into salesperson(name, age, salary) values('Sally', '24', 9000);
insert into salesperson(name, age, salary) values('Nancy', '29', 7000);
insert into salesperson(name, age, salary) values('Clara', '40', 8500);

-- ������ ���� : ��
insert into customer(name, city, industrytype) values('Mary', 'LA', '������');
insert into customer(name, city, industrytype) values('Carrie', 'LA', '�丮��');
insert into customer(name, city, industrytype) values('IU', 'KR', '����');
insert into customer(name, city, industrytype) values('Diane', 'LA', '������');
insert into customer(name, city, industrytype) values('Grace', 'DE', '�丮��');
insert into customer(name, city, industrytype) values('Nancy', 'MX', '������');
insert into customer(name, city, industrytype) values('Frank', 'US', '������');

-- ������ ���� : �ֹ�
insert into orders (numbers, custname, saesperson, amount) values('1', 'Mary','Tom', 1000);
insert into orders(numbers, custname, saesperson, amount) values('2', 'IU','Sally', 2000);
insert into orders(numbers, custname, saesperson, amount) values('3', 'Diane','Nancy', 3000);
insert into orders(numbers, custname, saesperson, amount) values('4', 'Grace','Roy', 4000);
insert into orders(numbers, custname, saesperson, amount) values('5', 'Nancy','Tom', 5000);
insert into orders(numbers, custname, saesperson, amount) values('6', 'Diane','Sally', 6000);
insert into orders(numbers, custname, saesperson, amount) values('7', 'Grace','Roy', 7000);
insert into orders(numbers, custname, saesperson, amount) values('8', 'Nancy','Nancy', 8000); 






--(1) ���̰� 30�� �̸��� �Ǹſ��� �̸�
select name
from salesperson
where age < 30; 

--(2) 'S'�� ������ ���ÿ� ��� ���� �̸�
select name from customer where lower(city) like '%s'; 

--(3) �ֹ��� �� ���� �� (���� �ٸ� ��)�� ���ϱ� (ORDERS����)
SELECT * FROM ORDERS;

SELECT COUNT(DISTINCT CUSTNAME)
    FROM ORDERS;

--(4) �Ǹſ� ������ ���Ͽ� �ֹ����� ���� ����ϱ�
SELECT  DISTINCT SAESPERSON, 
                COUNT(SAESPERSON)
    FROM ORDERS
    GROUP BY SAESPERSON;