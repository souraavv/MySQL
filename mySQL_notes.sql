[Defn]
------
Ques: What is propositional formula ? 
Ans: A formula which is well formed and has truth value

Ques: What is clause ? 
Ans: A propositional formula formed from a finite collection of literals(or their negative)
join with the logic connectives. 
Clause = l1 V l2 V ... V ln 

TLTR: Too Lazy to Right 

[What is MySQL]
---------------

- MySQL(Myy Ess Que Ell) is a RDBMS based on SQL
- R in RDBMS refers to the relation (which are tables)
- It is used to manage and access the records in the database
- MySQL is open source (GNU licence) and supported by Oracle 
- Database provides API like create, delete, update to manipulate database
  Example of database are MySQL, Oracle, MongoDB, 
- My sql is written in C/C++ programming language
- Comment  
    -- comment symbol 
    /* Iam comment */ 
    mysql> select * from r; # comment here 

mysql -v -- for version 
> :) mysql is portable, free, fast, reliable, open-source
> :( not so efficient for large scale database, transaction are not handeled efficiently 

[Connection to mysql server]
----------------------------
> mysql
> mysql -u root -p : -u root means root mode, and -p to instruct mysql to ask for password
mysql> show databases;
mysql> exit

[Create user in mysql]
-----------------------
create user sourav@localhost identified by 'nickname';
drop user 'nickname';
drop user sourav@localhost, sharma@localhost
select user from mysql.user;
update user set password = PASSWORD('abc') where user='sourav' and host='localhost'

[Grant priviledges]
1. All priviledges
2. create/drop/delete/insert/select/update

grant all priviledges on *.* to sourav@localhost;
flush priviledges

show grants for user_name;

[Properties]
------------

- MySQL follows client-server architectures. Many clients can be supported which can 
  communicate to the server
  Properties:
   - Scalable : supports multi-threading (It can handle almost any amount of data)
   - Secure: Passwords can be encrypted in MySQL
   - Allow rollbacks
   - Memory efficient : Less memory leakage problems
   - Platform independent: Can work on most of Operating system

- Last release 8.0 version in 2018

[Data Types in MySQL]
---------------------
--String
char(size): maximum it can have 255 chars, if doesnot specify any thing then it will assign 1
varchar(size): maximum it can have 255 chars
text(size): maximum size of 65,535 characters
mediumtext(size): maximum of 16Million characters
longtext(size): 4GB upto

--Numeric Data type
tinyint, smallint
int : 32 bit 
bigint: 64 bit
float(m, d) : m is display length and d is number of decimals
decimal(m, d): 
boolean/bool both work: Used to store single value(TRUE/FALSE)

--date and time datatypes
YEAR
DATE
TIME
DATETIME 
TIMESTAMP
--Binary large object data types
TINYBLOB: 255 bytes
BLOB(size) Maximum of 65k bytes
MEDIUMBLOB: 16 Million Bytes
LONGBLOB : maximum of 4GB
-- Spatial data types
GEOMETRY
POINT 
POLYGON

--JSON Datatype
MYSQL also allow to store JSON Data type 
 JavaScript object Notation (lightweight data interchange format)


Note Json column cant be index directly because it first need to extract the 
scalar value from the JSON column

@USE-CASE
Suppose we are creating a web application and want to save a users
configurations or preferences in the table. Generally, we used to 
create a separate table that contains user_id, key, and value fields 
or saves it as a formatted string so that it can be parsed at runtime. 
This method is good for limited users. 
 
If the users list will be large and more configuration/preference keys, this method is not good.

syntax:

CREATE TABLE r (
    A1 INT,
    A2 JSON
);

insert into r(A1, A2) values (28, '{"belongs": "Himachal Pradesh", "site": "Javatpoint"}');
select A1, A2->'$.site' as site from r;

inline Path operator : (->>) It remove double quotes form the output
In above case output will be "Javatpoint", if you have used ->> then output will be Javatpoint

set @address = JSON_OBJECT('village', 'sulpur');
select @address

-- User defined types

create type Dollar as numeric(12, 2) final


[VARIABLES IN SQL]
-- Variables in MySQL

1. User-Defined variable
2. Local variables
3. System variables

User defined variables starts with @ symbol
------------------------------------------
set @var_name = value;
select @var_name

select @maxage:=MAX(age) from students; -- when you want to fetch from the table then :=
select firstname, lastname from students where age=@maxage 

--------------------------------------------------
Local variable is strongy typed variable, scope in only to the 
block where it is declared

declare a, b, c INT default 0;

DELIMITER //  
Create Procedure Test()  
    BEGIN  
        DECLARE A INT DEFAULT 100;  
        DECLARE B INT;  
        DECLARE C INT;  
        DECLARE D INT;  
        SET B = 90;  
        SET C = 45;  
        SET D = A + B - C;  
        SELECT A, B, C, D;  
    END //  
DELIMITER ;  

CALL Test();

Some system variables which contains some predefined value 


[Create Database]
-----------------
create database db;
show database db;
mysql> use db;

[Create TABLE]
--------------

CREATE TABLE employee_table(  
    id int NOT NULL AUTO_INCREMENT,  
    name varchar(45) NOT NULL,  
    occupation varchar(35) NOT NULL,  
    age int NOT NULL,  
    PRIMARY KEY (id)  
); 

[ALTER TABLE]
------------
ALTER TABLE some_random_table_name
ADD <some_random_column> <some_random_type> <some_random_constraint>;

[DESCRIBE TABLE]
----------------
describe employee_table;
rename employee_table to emp_table;

[TRUNCATE]
-----------
-Truncate statement in mysql remove the complete data without removing its structure 
It is a part of DDL (Data Definition language)

-Truncate works as same as a DELETE command without using a WHERE clause

-Truncate is more efficient that delete, because it delete complete table first then
it creates a new table, where as delete work one-by-one

-No log is maintained, thus we can not rollback this command -- Important to remeber, also reason for being fast

-We cannot use the truncate statement when a table is referenced by a 
foreign key 

-Also truncate does not fire the DELETE triggers associated with table as it operate on table, not row 

syntax:
truncate table customers;

you have set foregin_key_check = 0; before calling truncate

[DROP TABLE]
-----------
drop table table_name;
It remove data as well as schema permanently 


[TEMPORARY TABLE]
-------------------
MySQL has a feature to create a special table called a 
Temporary Table that allows us to keep temporary data. 
We can reuse this table several times in a particular session.


CREATE TEMPORARY TABLE Students( 
    student_name VARCHAR(40) NOT NULL, 
    total_marks DECIMAL(12,2) NOT NULL DEFAULT 0.00, 
    total_subjects INT UNSIGNED NOT NULL DEFAULT 0
);


CREATE TEMPORARY TABLE temp_customers  
SELECT c.cust_name, c.city, o.prod_name, o.price   
FROM orders o  
INNER JOIN customer c ON c.cust_id = o.order_id  
ORDER BY o.price DESC;  

[CHANGE STATEMENT]
ALTER TABLE table_name   
CHANGE COLUMN <old_column_name> <new_column_name> <Data-Type>;


[VIEW]
-----
A view is a database object that has no value.
Its content are based on the base table
View is a virtual table 
Changes in main table are reflected to the view also

create view trainer as 
select course_name, trainer 
from courses;

[LOCKING ON A TABLE]
My sql allow user to have lock on the table, used to solve the concurrency problems
READ LOCK : Are low priority than write locks, which ensure that updates are made as quick as possible

WRITE LOCK 
----------
Read lock can be shared between multiple threads at the same time.
Write lock is exclusive
Both are not provided at the same time on a table :(

lock table student [READ|WRITE];
unlock student;

There is are materialized view, they stay out-of-date to the parent table 

Disk-based and are updated periodically based upon the query definition.
A materialized table is created or updated infrequently and it 
must be synchronized with its associated base tables.

[MYSQL Query]
-------------
insert into customers values(...);

update customers 
set name = 'Sourav', city = 'Mandi'
where id = 'mcs212154';

delete from customers
where id = 'mcs212154';

select * from customers;

truncate table customers;

drop table customers; 

[CONSTRAINTS]
--------------
The constraint in MySQL is used to specify the rule that allows or restricts 
what values/data will be stored in the table. They provide a suitable method 
to ensure data accuracy and integrity inside the table. It also helps to limit
the type of data that will be inserted inside the table. If any interruption 
occurs between the constraint and data action, the action is failed.

- Column level constraints
- Table level constraints

NOT NULL : Cant have null value
CHECK(expr): Age int check(age>=40)
DEFAULT: City varchar(20) default 'Mandi'
PRIMARY_KEY: Id int not null PRIMARY KEY
AUTO_INCREMENT: automatically insert new id 

   CREATE TABLE r(    
        id int NOT NULL AUTO_INCREMENT,   
        name CHAR(30) NOT NULL,   
        PRIMARY KEY (id));  

    insert into r (name)values ('sourav'), ('sharma'), ('himachal');

ENUM: size ENUM('small', 'medium', 'large')
, UNIQUE, ,

FOREIGN KEY : used to link two table together. A foreign key matches the primary key 
              field of other table 

syntax:

CREATE TABLE Orders (  
    Order_ID int NOT NULL PRIMARY KEY,  
    Order_Num int NOT NULL,  
    Person_ID int,  
    FOREIGN KEY (Person_ID) REFERENCES Persons(Person_ID)  
);  


[INSERT]
--------
1)
INSERT INTO People (name, occupation)   
VALUES ('Stephen', 'Scientist'), ('Bob', 'Actor');  

2)
insert ignore into r (a1, a2, a3)
values
('a', 'b', 'c');

if say a2 is unique and a record b is already there, the above insertion
will raise error, but if we still want to execute this by ignoring error, 
mysql will not insert this query and tell 0 record insert and also will not show
any error.

3)
insert into r 
select * from r1

internal select will be executed first consider the case when r1 is r.

[UPDATE]
--------
UPDATE Trainer_table  
SET email = REPLACE(email,'@javatpoint.com','@tutorialandexample.com')  
WHERE course_name = 'Testing';  

Also multiples are allowed

UPDATE People  
SET name = 'Mary', occupation = 'Content Writer'  
WHERE id = 105;  

[INDEX in mySQL]
----------------

- Index allow fast retrieval of information from the database
- Index can be created by one or more columns 
- When an attribute is specified as primary, a special index name PRIMARY is created
- This is a clustered index. All other than primary are non-clusttered index (or secondary)

- Use case: If you are searching say telephone number in an unordered list, 
    In normal case without index, It will scan all the rows :( 

Index can be created at the time of creation of table as well as separately 

create index index_1 on r(a5);

Default : My sql uses B-TREE, if we dont specify 
Different supported

create index index_name 
on student_table(column_name);

> show indexes from table_name;

> drop index index_name on table_name 


[MYSQL Clauses]
------------------

> where clause
  used with all select/insert/update/delete 
  where conditions;
> distinct clause
  select distinct column_name 

> from clause 
  from r1, r2, ..

> order by clause  
  order by name desc, age asc

> group by clause 
  Collect data from multiple row and bring that to a single column 

  some aggregate functions like 
  count, sum, min, max, avg on the grouped column 

SELECT emp_name, [SUM|AVG|MIN|MAX](working_hours) AS "Total working hours"  
FROM employees  
GROUP BY emp_name;  


> Having Clause 
After group by we have having conditions

SELECT emp_name, SUM(working_hours) AS "Total working hours"  
FROM employees  
GROUP BY emp_name  
HAVING SUM(working_hours) > 5;

[GRANT priviledges]
---------------------

grant priviledges
on name_of_table
to user_account_name;

*.* means all global priviledges 

[CONTROL FLOW FUNCTIONS]
---------------------------

If function()

select if(200 > 350, 'YES', 'NO')
select if(strcmp('sourav', 'sharma') = 0, 'correct', 'incorrect') as ans from r;

ifnull function()
-------------------
It accepts two argument if exp1 is null then return exp2, else exp1 

select ifnull("hello", "sourav");
select ifnull(NULL, 4);

The nullif function accepts two expressions and if first expression = second then return null 
select nullif(qualification, "BTECH")


[CASE EXPRESSION]
-----------------

-- We have stored short name, but then only query we are expanding those.
SELECT studentid, firstname,  
 CASE class   
    WHEN 'CS' THEN 'Computer Science'   
    WHEN 'EC' THEN 'Electronics and Communication'   
    ELSE 'Electrical Engineering'   
END AS department from students;  


[IF-THEN Statement]
-------------------
syntax: 
delimiter$$
create procedure myResult(original_rate NUMERIC(6, 2), OUT discount_rate NUMERIC(6, 2))
 NO SQL 
 BEGIN 
   IF (original_rate > 20)
   THEN SET discount_rate = original_rate *= .5;
   END IF;
   select discount_rate;
 END$$
delimiter $$;

set @p = 600;
set @dp = 500;

call myResult(@p, @dp) -- call to the procedure
------------------

-- Format of If-then-else condition
IF condition
THEN statements;
ELSEIF condition 
THEN statements;
ELSE 
statements;
END IF;

> Drop procedure myResult;  -- we can drop prodecure too, anything can be drop(gravity is there :|

[AND Condition]
----------------
where c1 and c2 and c3 ..;
where c1 or c2 or c3 ..;

[LIKE Conditions]
-----------------
% as wildcard -- A card which is wild called as wildcard
where address like 'Luck%';
where address like 'Luc_now';
where address not like 'Luc_now';


[ANY|IN]
--------
expression in values(...);

SELECT num_value FROM table1   
WHERE num_value > ANY (SELECT num_val FROM table2);  

SELECT colm1 FROM table1 WHERE colm1 <>ANY (SELECT colm1 FROM table2);  
SELECT colm1 FROM table1 WHERE colm1 <> SOME (SELECT colm1 FROM table2);  

[EXISTS|NOT EXISTS]
-------------------
SELECT name, occupation FROM customer  
WHERE EXISTS (SELECT * FROM Orders   
WHERE customer.cust_id = Orders.cust_id);  

[NOT EQUAL TO] <>
ISNULL 
IS NOT NULL
expression between value1 and value2;

SELECT *  
FROM officers  
WHERE officer_id BETWEEN 1 AND 3;  

[JOIN]
------

from r1 inner join r2 on condition

SELECT officers.officer_name, officers.address, students.course_name  
FROM officers   
INNER JOIN students  
ON officers.officer_id = students.student_id;   

LEFT JOIN
RIGHT JOIN 

INNER JOIN using USING 
r1 inner join r2 using(attribute_name) where something;

[SELF JOIN]
----------
from r new_Name_1, r new_Name_2

select/delete both can be used as the query filter 

EQUI JOIN + Where condition ~ JOIN + ON condition 

[NATURAL JOIN]
--------------
A natural join is a type of join operation that creates an implicit
join by combining tables based on columns with the same name and data type
 > No need to specify the column to join
 > Result always contains the unique columns 
 > dont use the ON clause 

syntax: 
SELECT cust. customer_name, bal.balance   
FROM customer AS cust NATURAL JOIN balance AS bal;  

[UNION]
---------
SELECT column_name(s) FROM table_name1    
UNION    
SELECT column_name(s) FROM table_name2;  

[UNIQUE KEY]
------------

A unique key in MySQL is a single field or combination of fields 
that ensure all values going to store into the column will be unique. 
It means a column cannot stores duplicate values.

CREATE TABLE Student3 (  
    ...
    Roll_No int,  
    Email varchar(45),  
    City varchar(25),  
    CONSTRAINT uc_rollno_email Unique(Roll_No, Email)  
); 

> CONSTRAINT name type(attribute_list)

alter table 
add constraint contraint_name unique(attribute(s))

[PRIMARY KEY]
-------------
Can not be null/empty, must be unique 
Primary key column can also use AUTO_INCREMENT attribute to generate 
a sequential number for the row automatically

> Each table can only contain one primary key 
> it is not recommended to use int or bitint type for primary key attribute 

CREATE TABLE Login(  
   login_id INT AUTO_INCREMENT PRIMARY KEY,  
   username VARCHAR(40),  
   password VARCHAR(55),  
   email VARCHAR(55)  
);  

or

CREATE TABLE Students (  
    ...
    Primary Key(Student_ID, Roll_No)  
); 

alter table table_name 
add primary key (column_name);

> unique key can accept one null value, where as primay not even single 
> A table can have multiple unique key, but only single primary key(which can be comb of attributes)
> Primary creates cluster index, and secondary create non-clustered index 


[FOREIGN KEY]
-------------

create table r (
    a1 INT,
    a2 varchar(10),
    a3 TEXT,
    index my_index(a1),
    constraint which_foreign_key foreign key (a2) 
    references other_table(colums_name)
    on delete cascade (or set null) (or no action)
    on update cascade (or set default) -- default is taken from the default value of other_table 
);

> alter table 
  drop foreign key which_foreign_key 


[COMPOSITE KEY]
--------------
CREATE TABLE Product (  
    Prod_ID int NOT NULL,   
    Name varchar(45),   
    Manufacturer varchar(45),  
    PRIMARY KEY(Name, Manufacturer)  
); 


[TRIGGERS]
-------------

> Resides in system catalog 
> Special type of stored procedure which are envoked automatically in response to an event 
> Each trigger is associated with a table on DML Statment like insert/update/delete 

> Two types : i) Row level ii) statement level trigger : regardless of how many row affected 

Q Why needed ? 
> They can help us validate data even before inserting 
> way to run a scheduled task 
> They dont need to compile each time and thus reduce the overhead of compile each time 

:( They are hard to trouble shoot, if nesting is long 
:( May increase the overhead of the database 

[TYPES of TRIGGERS]
------------------
6 types: 

Before Insert: activated before the insertion of record
After Insert: after the insertion of record 
Before Update: My answer is also same ..
After Update: TLTR 
Before Delete: TLTR
After Delete: TLTR


create trigger trigger_name 
trigger_time(BEFORE|AFTER) 
trigger_event(INSERT|UPDATE|DELETE) 
on table for each row 
begin 
 do something 
end;

[BEFORE INSERT]
---------------
delimiter $$
create trigger trigger_name 
Before
insert 
on table_name for each row 
begin 
  if new.working_hour < 0 
  then set new.working_hour = 0;
  end if;
end $$


> show triggers 
> shot tirggers from database_name where table = "this_table"

> drop trigger if exists schema_name.trigger_name  -- if exists return warning instead error if not exists


[AFTER INSERT] only new
---------------

DELIMITER $$ 
Create Trigger after_insert_details  
AFTER 
INSERT
ON student_info 
FOR EACH ROW  
 BEGIN  
    INSERT INTO student_detail 
    VALUES 
    (new.stud_id, new.stud_code,   
    new.stud_name, new.subject, new.marks, new.phone, CURTIME());  
 END $$ 

DELIMITER ;

[BEFORE UPDATE] : old + new
---------------

delimiter $$

create trigger trigger_name 
before 
update 
on r 
for each row 
  begin 
    declare error_msg varchar(234);
    set error_msg = ("new quant. can be greater than 2 time old");
    if new.quantity > old.quantity * 2
    then signal sqlstate'45000' -- we have signals in sql too.
    set message_txt = error_msg;
    end if;
  end 
end $$

delimiter;

[BEFORE DELETED]
-----------------
We will then create a BEFORE DELETE trigger that inserts 
a new record into the salary_archives table before a row is 
deleted from the salaries table.

delimiter $$
create trigger before_delete_salaries
before
delete 
on salaries 
for each row 
  begin 
    insert into salary_archives (emp_num, valid_from, amount)
    values (old.emp_num, old.valid_From, old.amount);
  end$$
delimiter;

[AFTER DELETE]
--------------
deimiter $$
create trigger after_delete_salaries 
after 
delete 
on salaries 
for each row 
 begin 
   update total_salary_budget 
   set total_budget = total_budget - old.amount;
 end$$

delimiter ;


[AGGREGATE FUNCTION]
-------------------

count(), sum(), avg(), min(), max(), first(), last()
GROUP_CONCAT()

count(*) contains all null and not null, if all null then 
count(distinct emp_age) -- note distinct is not a function 


--select first two records 
select office_name 
from office 
limit 2;

GROUP_CONCAT() : concatenate string from multiple rows into a single string 
if atleast one non-null then string, else null 

group_concat(column_name SEPARATOR "any_random_separator") -- separator is optional, default is space 

select emp_fname, GROUP_CONCAT(distinct designation SEPARATOR '-') as "designations"
from table 
group by emp_id;

concat_ws() function use case with group_concat 

SELECT GROUP_CONCAT(CONCAT_WS(', ', emp_lname, emp_fname) SEPARATOR ';') as employeename FROM employee;

last(): returns from the last indirectly 

SELECT officer_name   
FROM officers  
ORDER BY officer_name DESC  
LIMIT 1; 

[CHECK CONSTRAINT]
------------------
constraint constraint_name  -- let's say when you are inserting so you put a constraint on the table.
check (sell_price > cost_price);

alter table table_name 
drop constraint constraint_name;

> not important but exists : Import from a csv file, export table to a csv file


[SUBQUERY]
-----------

> It must be always in parentheses.
> Order by is not allowed to used in SUBQUERY
> We can use various comparison operators with the subquery, such as >, <, =, IN, ANY, SOME, and ALL.

> Good part: some time more readable than complex join or union 


syntax: [IN WHERE|FROM]

SELECT emp_name, city, income 
FROM employees   
WHERE emp_id IN (SELECT emp_id FROM employees); 

-- find emp_name, city with maximum income
SELECT emp_name, city, income 
FROM employees   
WHERE income = (SELECT MAX(income) FROM employees);

-- student detail who does not belong to Los Angeles City
SELECT Name, City FROM student  
WHERE City NOT IN (  
SELECT City FROM student2 WHERE City='Los Angeles');  

--returns the maximum, minimum, and average number of items in the order table
SELECT Max(items), MIN(items), FLOOR(AVG(items))  
FROM  
(SELECT order_id, COUNT(order_id) AS items FROM orders GROUP BY order_date) AS Student_order_detail;  

-- more than avg income 
SELECT emp_name, city, income  
FROM employees emp
WHERE income > (SELECT AVG(income) FROM employees WHERE city = emp.city);  

-- find all who has placed atleast one order
SELECT name, occupation, age 
FROM customer C  
WHERE EXISTS (SELECT * FROM Orders O WHERE C.cust_id = O.cust_id);    

-- to see if greater than any 
SELECT cust_id, name FROM customer WHERE   
cust_id > ANY (SELECT cust_id FROM Orders);  



[MYSQL UUID] : Universal Unique indetifier (128-bit long) 
------------------------------------------------------------
> Unique across tables, databases and servers 
> Does not provide info about what is stored again UUID, thus ok to use in urls 
> simplify the replication, if inserting a record into parent, then take the uuid
  and using that insert into child Too


[TRANSACTION]
--------------
> sequential group of statements, either all modify or none 
> Statements are some basic operation (for simplicity : Read and Writes)
> Properties of Transactions ACID(flush to log)
> Atomicity : commit statement, rollback, auto-commit setting

> START TRANSACTION
> set autocommit = 0; -- incase we want to off the autocommit, as commit is default  
> set autocommit = 1;

start transaction 
  select @income:=  MAX(income) from employee
  -- this kind of syntax when you want to read from table 
  insert into employee (emp_id, emp_name, emp_age, city, income)
  values (111, 'Alexander', 45, 'California', 700000),
commit;

start transaction
 delete from order;
 rollback;

[SAVEPOINT]
-----------
> checkpointing creates special marks with the name

> savepoint savepoint_name
> roolback to savepoint_name
> realease savepoint savepoint_name

START TRANSACTION;  
  SELECT * FROM Orders;  
  INSERT INTO Orders(order_id, prod_name, order_num, order_date)   
  VALUES (6, 'Printer', 5654, '2020-01-10');  
  
  SAVEPOINT my_savepoint;  -- because of log manager, which is having stable storage system.
  
  INSERT INTO Orders(order_id, prod_name, order_num, order_date)   
  VALUES (7, 'Ink', 5894, '2020-03-10');  
   
  ROLLBACK TO SAVEPOINT my_savepoint;  
  
  INSERT INTO Orders(order_id, prod_name, order_num, order_date)   
  VALUES (8, 'Speaker', 6065, '2020-02-18');  
  
COMMIT;  


[ROW_NUMBER Function()]
-----------------------

returns the sequential number for each row within the partition. 
It start with 1. 
syntax: ROW_NUMBER() OVER (<partition_definition> <order_definition>) 

select *, row_number() over (partition by year) as row_num 


[LIMIT and OFFSET]
---------------------
SELECT emp_id, emp_name, income FROM employees  
ORDER BY income DESC  
LIMIT 3,7;  -- start from row 3 (1 based) and goes to the maximum 7th row 



[STORED FUNCTIONS]
-------------------
IN parameters, OUT parameters, INOUT parameters

delimiter $$
create function func(age int) 
  begin 
   select name, age, .. from customer order by age;
  end $$ 

delimiter ;

set @age = 5;
call func(@age);

[RANKING FUNCTIONS]
--------------------

It allow us to rank each row of a partition
can be used with following Clauses
 i) OVER()
 ii) ORDER BY
 iii) They assign rank to each row in some sequential order 

mYsql supports - Dense rank, rank, percent rank 

Dense Rank()
> It is a function which assign rank to each row within the partition 
  without any gap 


SELECT emp_id, emp_name, city, emp_age, DENSE_RANK() OVER (ORDER BY emp_age) dens_rank  
FROM employees;  

-- we can also have partions
select emp_id, emp_name, city, dense_rank() over (partition by emp_age order by city) dense_rank
from student;


Rank()
It doesnt assing unique rank, some time it repeats also 

select *, rank() over (partition by emp_age order by emp_id) my_rank -- all with same age are grouped and then id start from 1 are allocated to them
from employee;

-- These are really helpful, when someone ask find the 2nd person with this age

percentile_rank() 


[WINDOW FUNCTION]
-------------------

You can basically groups things and then you can computer aggregate over those
Like if I can compute the average salary of all the department and show that as column 

select year, product, sale, sum(sale) over (partition by year) as total_sale 
from sale;

Window functions are categorized into three types
- Aggregate Functions: count, sum, avg, min, max 
- Ranking functions: RANK, DENSE, ROW_NUMBER(), PERCENT_RANK()
- Analytical Functions : FIRST_VALUE, LAST_VALUE, NTH, LAG, LEAD, NTILE 


NTILE window function. This function takes an integer value as an argument that 
divides the group into a number of integer values.
NTILE(4) OVER() AS total_sale

LEAD function can be used to access the next one row from table without joining

select year, product, sale, LEAD(sale, 1) over (order by year) as some_random_name
from some_random_table;


[COALESCE]
The function accept only one parameter which is the list of various values 

select COALESCE(NULL, 'A', 'B', NULL); -- returns 'A'
IFNULL is a specialization of this function because ifnull takes only 2 parameters
where as COALESCE can take a list 

[WILDCARDS]
%, _, [a-z]


[LITERALS]
\b backspace, \n newline, \t tab 
\\ backslash, \% represent %

[DATE]
select current_date(),current_date, curdate();
select now();
select current_timestamp();
select curtime, current_time(), current_time 

select date_format("1999-06-20", "%Y")
%Y: Year four digit, %y: year 2 digit, 
%a: week day name
%b: Abbreviated month name (Jan to Dec)
%c: Numeric month name(0 to 12)
%d: Day of month(00, 31)

SELECT DATE_FORMAT("2017-06-15", "%M %d %Y");

-- This recession make hire as fire 
sample query:
---------------------------------------------------------------
Find the Employees who were hired in the Last n months

Select *, TIMESTAMPDIFF(month, Hiredate, current_date()) as DiffMonth 
from employees
where TIMESTAMPDIFF(month, Hiredate, current_date()) between 1 and 5 order by Hiredate desc;

-------------------------------------------------------------
Find the Employees who hired in the Last n days

select *, DATEDIFF(current_date(), Hiredate)as DiffDay 
from employees
where DATEDIFF(current_date(), Hiredate) between 1 and 100 order by Hiredate desc; 

--------------------------------------------------------------
Find the Employees who were hired in the Last n years

select *, TIMESTAMPDIFF(year, Hiredate, current_date()) as DiffYear 
from employees
where TIMESTAMPDIFF(year, Hiredate, current_date()) between 1 and 4 order by Hiredate desc;



[SOME Random functions]

i) substr(attribute_name, start, length) : 1-based indexing
ii) lower() and upper() can be used to remove the sensitivity in strings
iii) round(val, 2) : can be use to round till 2 digits after decimal
iv) truncate(val, 4): truncate the floating value to 4 digits
v) ceil() and floor() : Round off th the greatest or lowest interger
vi) Replace(salary, '0', '') : 640023 -> 6423
vii) sqrt(), power(), abs() -- basic math
viii) length(attribute_name)
ix) min(), max(), pi(), mod(a, b)
x) || or concat() are used to concat the strings
xi) tupel comparision (a.id, b) = (c.id, 'hello')
xii) DATE FROM PARTS ('2018', 10, 31) as date 
xiii) DATENAME(yy, '1999-06-20') -- returns specific part
xiv) DATEADD(year, 1, '1999-02-01')
xv) reverse(string)
xvi) stuff() : stuff(string, start, length, new_string)
xvii) replicate(string, no_of_times)
xviii) str(185.4)
xix) replace(string, old_string, new_string)
xx) trim, ltrim(), rtrim(), trim()


[SPOILER AHEAD!]  :| GCD in PL/SQL -- why one will write in pl/sql, nobody knows

DECLARE
	num1 INTEGER;
	num2 INTEGER;
	t INTEGER;
BEGIN
	num1 := 8;
	num2 := 48;

	WHILE MOD(num2, num1) != 0 LOOP
		t := MOD(num2, num1);
		num2 := num1;
		num1 := t;
	END LOOP;

	dbms_output.Put_line('GCD of ' || num1 ||' and ' ||num2 ||' is ' ||num1);
END;

-- Program End


[SOME COMMON QUESTIONS]

-------------------------------------------------
Q: What DBMS provide over traditional file system ?
- ACID, Security, 

-------------------------------------------------
Q: What are the differences between DDL, DML, and DCL in SQL? 

Following are some details of three :

-DDL stands for Data Definition Language. SQL queries like CREATE, 
 ALTER, DROP, TRUNCATE and RENAME come under this. 

-DML stands for Data Manipulation Language. SQL queries like SELECT, 
 INSERT, DELETE and UPDATE come under this. 

-DCL stands for Data Control Language. SQL queries like GRANT and
 REVOKE come under this. 

-------------------------------------------------
Q: Normalization goals
- Reduce redundancy and remove anamoly from the table 

-------------------------------------------------
Q: Difference between primary and unique constraint ? 
- Unique can have one NULL value where as primary can not have even single 


-------------------------------------------------
Q: What is the difference between Trigger and Stored Procedure? 
- Unlike Stored Procedures, Triggers cannot be called directly. 
  They can only be associated with queries.

-------------------------------------------------
Q. What is Denormalization?
- Denormalization is a database optimization technique in which 
  we add redundant data to one or more tables.

-------------------------------------------------
Q. What is the purpose of SQL?
- SQL stands for Structured Query Language whose main purpose is to 
  interact with the relational databases in the form of inserting, deleting and updating/modifying 
  the data in the database.

-------------------------------------------------
Q. What is Correlated Subquery in DBMS?

A Subquery is also known as a nested query i.e. a query written 
inside some query. When a Subquery is executed for each of the rows of the 
outer query then it is termed as a Correlated Subquery.

An example of Non-Correlated Subquery is:

SELECT * from EMP WHERE 'who_knows' IN (SELECT Name from DEPT WHERE EMP.EMPID=DEPT.EMPID);
Here, the inner query is not executed for each of the rows of the outer query.

-------------------------------------------------
Q. What is E-R model in the DBMS?
- E-R model is known as an Entity-Relationship model in the DBMS 
  which is based on the concept of the Entities and the relationship that exists among these entities.

Q. Type of failures ? 
- Bad Data types
- Insufficient priviledges
- Media failure (user drop a table)


[SOME OTHER IMP QUERY]

---------------------------------------------------------------
There is a table where only one row is fully repeated. Write a Query to find the Repeated row

SELECT name, section FROM tbl
GROUP BY name, section
HAVING COUNT(*) > 1

--------------------------------------------------------
Query to find 2nd highest salary of an employee?

SELECT max(salary) FROM EMPLOYEES WHERE 
salary <> (SELECT max(salary) FROM EMPLOYEES);


----------------------------------------------------
Write a trigger to update Emp table such that, If an updation is 
done in Dep table then salary of all employees of that department 
should be incremented by some amount (updation) 

CREATE OR REPLACE TRIGGER update_trig
AFTER 
UPDATE 
ON 
Dept
 FOR EACH ROW
  DECLARE CURSOR emp_cur IS SELECT * FROM Emp;
  BEGIN
  FOR i IN emp_cur LOOP
  IF i.dept_no = :NEW.dept_no 
  THEN
        DBMS_OUTPUT.PUT_LINE(i.emp_no);  --  for printing those
        UPDATE Emp                      -- emp number which are
        SET sal = i.sal + 100           -- updated
        WHERE emp_no = i.emp_no;
  END IF;
 END LOOP;
END;

----------------------------------------------------------------------
Q. There is a table which contains two columns Student 
and Marks, you need to find all the students, whose marks 
are greater than average marks i.e. list of above-average students.

SELECT student, marks 
FROM table
WHERE marks > SELECT AVG(marks) from table;

----------------------------------------------------------------------
Q. Name the Employee who has the third-highest salary using sub queries.

SELECT Emp1.Name
FROM Employee Emp1
WHERE (SELECT COUNT(DISTINCT(Emp2.Salary))
           FROM Employee Emp2
           WHERE Emp2.Salary > Emp1.Salary
       ) = 2

Logic: Number of people with a salary higher than this person will be 2. 


----------------------------------------------
Minimum table needed from an ER diagram

1:1 cardinality with partial participation of both entities	2
1:1 cardinality with total participation of atleast 1 entity	1
1:n cardinality	2
m:n cardinality	3


3 tier in DBMS
- External Level <-> conceptual level <-> physical Layer 
