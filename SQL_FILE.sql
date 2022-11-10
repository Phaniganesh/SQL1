-- Single line commment
/* multiple 
line
comment */

-- Database Commnads
create database powerbisqlbatch2;
create schema powerbisqlbatch2_;
DROP DATABASE powerbisqlbatch2_3;
Show databases;
backup database powerbisqlbatch2 to disk 'D:\DATA_SCIENCE\DataSets';

-- Table Commands
create table powerbisqlbatch2.student(
stuid char,
stuname varchar(100),
marks int);

select * from powerbisqlbatch2.student;
insert into powerbisqlbatch2.student (stuid,stuname,marks) values (1,'john',100);
insert into powerbisqlbatch2.student values (2,'Joseph',99);
insert into powerbisqlbatch2.student (stuname,marks) values ('stephen',98);
insert into powerbisqlbatch2.student (stuid,stuname,marks) values (1,'john',100),(4,'alex',97),(5,'tony',96);

insert into powerbisqlbatch2.student (stuid,stuname,marks) values (12,'john',100);
alter table powerbisqlbatch2.student modify column stuid char(10);
alter table powerbisqlbatch2.student add column address varchar(1000);
alter table powerbisqlbatch2.student drop column address;

-- Constraints in SQL
/* Unique, PK, FK, NOT NULL, CHECK, DEFAULT. */
CREATE TABLE powerbisqlbatch2.studentreport(
stuid char(10) not null UNIQUE,
stuname varchar(100),
marks int default 0 check (marks < 101));

select * from powerbisqlbatch2.studentreport;
insert into powerbisqlbatch2.studentreport (stuid,marks) values ('A1',100);
insert into powerbisqlbatch2.studentreport (stuid,stuname,MARKS) values ('A6','John',95.5);

create table Maths (stuid char(10), stuname varchar(100), marks int default 0 check (marks < 101), primary key (stuid));
insert into maths (stuid,stuname,marks) values (1,'A',100),(2,'B',99),(3,'C',98),(4,'D',97);
select * from maths;

create table Social (stuid char(10), stuname varchar(100), marks int default 0 check (marks < 101), 
primary key (stuid),
foreign key (stuname) references maths(stuname));

-- Delete and truncate.
select * from maths;
delete from maths where stuid = 1;
truncate table maths;

-- Clauses in SQL (DQL, DML, DDL)
-- SELECT COLM, SELECT *, SELECT DISTINCT, SELECT COUNT, SELECT DISTINCT COUNT
select * from globalorders;
select segment,market,sales from globalorders;
select count(market) from globalorders;
select distinct(market) from globalorders;
select count(distinct(market)) from globalorders;

-- Where clause / Operators in SQL.
-- Arithematic Operators (+, -, *, %, /) Numerical Data
select sales,(sales + 10) as sales1,(sales - 2) sales2 from globalorders;

-- Comparison Operators (=, > , <, >=,<=,<>) Numeric data/Character data.
select market from globalorders where market = 'US';
select sales from globalorders where sales >= 8000;
select sales from globalorders where sales < 7000;

-- Logical Operators (AND, OR, NOT)
select market from globalorders where market = 'us' or market = 'apac';
select market,segment from globalorders where market = 'US' or segment = 'Consumer';
select market,segment from globalorders where market = 'US' or 
Market = 'APAC' and segment = 'Consumer';
select market from globalorders where not market = 'US';

-- Range Operators (Between, Not between)
select sales from globalorders where sales between 5000 and 7000;
select sales from globalorders where sales not between 5000 and 7000;

-- Like and Wildcard (% (1 or more than 1 characters), _ (one single charcater)) Operators
select market from globalorders where market like 'a___';
select market from globalorders where market like 'ap%';
select market from globalorders where market like '_p%';

-- Regular Expression
select market from globalorders where market regexp '^a';
select market from globalorders where market regexp 'a$';

-- group by, order by, having, top/limit
select * from window_functions;
select gender,sum(salary) from window_functions group by gender;
select gender,MS,sum(salary) from window_functions group by gender,MS;
select gender,MS,sum(salary) from window_functions group by gender,MS order by salary Desc limit 3;
-- Having
select gender,ms,salary from window_functions where gender = 'Male';
select gender,ms,salary from window_functions having gender = 'Male';
select gender,ms,sum(salary) from window_functions where gender = 'male' group by gender,MS;
select gender,ms,sum(salary) from window_functions  group by gender,MS having gender = 'male';

-- Functions in SQL (String, Numeric, date and time, null functions, aggregate)
select customername,upper(customername) as customername1,lower(customername) as customername2,
left(customername,6) as customername3,right(customername,2) customername4, length(customername) as length from globalorders;

--  Numeric Functions
select sales,cos(sales) sales1,round(sales) sales2, round(sales,3) sales3, round(sales,-2) sales4 from  globalorders;

-- Date and time Functions
select last_update, date(last_update) as date1,second(last_update) from sakila.inventory;

-- Null Functions
select * from nullfunctions;
select marks,isnull(marks) as isnull,ifnull(marks,999999) from nullfunctions;

-- Aggregate Functions
select sum(sales) as summation from globalorders;
select count(market) as counting from globalorders;
select avg(sales) as averaging from globalorders;
select min(sales) from globalorders;
select max(sales) from globalorders;

-- Subquery
select marks,count(isnull(marks)) from nullfunctions where count(isnull(marks)) = 1;
select count(batch8) from (select marks,isnull(marks) as batch8 from nullfunctions) as xyz
where batch8 = 1;
select marks,isnull(marks) as batch8 from nullfunctions;

-- Special Operators (ANY, ALL, SOME, EXISTS, NOTEXISTS)
select market,sales from globalorders where market = ANY (select market from globalorders where market = 'US');
select market,sales from globalorders where market = ANY (select market from globalorders where market = 'UK');

select market,sales from globalorders where market = ALL (select market from globalorders where market = 'US');
select market,sales from globalorders where market = ALL (select market from globalorders where market = 'UK');

select market,sales from globalorders where market = SOME (select market from globalorders where market = 'US');
select market,sales from globalorders where market = SOME (select market from globalorders where market = 'UK');

select market,sales from globalorders where EXISTS (select market from globalorders where market = 'US');
select market,sales from globalorders where EXISTS (select market from globalorders where market = 'UK');

select market,sales from globalorders where NOT EXISTS (select market from globalorders where market = 'US');
select market,sales from globalorders where NOT EXISTS (select market from globalorders where market = 'UK');

create table powerbisqlbatch2.table2 (stuid int, stuname char(10));
insert into powerbisqlbatch2.table2 (stuid, stuname) values (1, 'A'), (4,'D'),(5,'E');

-- JOINS -- Table Alias
-- CROSS JOIN
select table1.stuid,table2.stuname from powerbisqlbatch2.table1 cross join powerbisqlbatch2.table2;
select * from table1 inner join table2 on table1.stuid = table2.stuid;
select * from table1 NATURAL join table2;
select * from table1 left join table2 on table1.stuid = table2.stuid;
select * from table1 right join table2 on table1.stuid = table2.stuid;
select * from table1 full join table2 on table1.stuid = table2.stuid;
select * from table1 join table1 t2 where t2.stuid = 1;

-- Set Operators (union, iunion all, intersect, expect/difference)
select * from table1 union select * from table2;
select * from table1 union all select * from table2;

-- Case Statements
select market,segment,sales,
case 
	when market = 'US' and segment = 'consumer' then 'USCONSUMER'
	when market = 'US' and segment = 'corporate' then 'USCORPORATE'
	when market = 'US' and segment = 'Homeoffice' then 'UShomeoffice'
	else 'Nothing'
end as Newcolumn
from globalorders;

-- Indexing
select market,segment,sales from globalorders where sales = 2754;
create index indexing on globalorders(sales);

-- Synonyms (Please execute in SQL Server)
/*
create synonym ganesh for ravali.dbo.padma;
drop synonym ganesh;
select * from ravali.dbo.padma;
select * from ganesh;
insert into ravali.dbo.padma values (1000,'vamsi krishna'); 
*/

-- Views (Simple View -- Single table/ Complex View -- Multiple tables)
create view viewing2 as (select * from table1 union all select * from table2); -- where market = 'US');
select * from viewing2;
drop view viewing1;

/* Window Functions */
-- select (* or cols),(agg func or window fun) over(partition by colnames order by colnames) from table_name;
select * from window_functions;
select gender,sum(salary) from window_functions group by gender;
select gender,ms,sum(salary) over() from window_functions;
-- select gender,ms,sum(salary) over(partition by gender,ms order by salary) from window_functions;

/* Row_number(), Rank(), Dense_Rank(), first_value(), Last_value(), Nth_value() or ntile(), Lead(), Lag()
-- Row_number() */
select gender,MS,salary, row_number() over() as rownumber,
row_number() over(partition by gender,MS order by salary desc) as rownumber1 from window_functions;

select marks,rank() over(order by marks desc) as ranking, dense_rank() over(order by marks desc) as denseiing from rankdenserank;

select gender,MS,salary, first_value(salary) over() as firstvalue,
first_value(salary) over(partition by gender) as firstvalue1,
last_value(salary) over() as lastvalue from window_functions;

select gender,MS,salary, Nth_value(salary,2) over(partition by gender) from window_functions;

select gender,MS,salary, lead(salary,2) over(partition by gender) from window_functions;

select gender,MS,salary, lag(salary,2) over() from window_functions;

select * from powerbisqlbatch2.student;
update powerbisqlbatch2.student set stuname = 'Ravali' where stuid = 5;








