--TO GET All Employees
SELECT * FROM Employees

--TO GET All Employees with other solutions
SELECT Employees.* FROM Employees

--To Get ID,FirstName,LastName,MonthSalary From Employyes
Select ID, FirstName, LastName,MonthlySalary From Employees;

--Get All Departments
Select * from Departments;

--Get All Countries
Select * from Countries;

--Get All DepartmentID
Select DepartmentID from Employees;

--Get All DepartmentID without duplicated
Select Distinct DepartmentID from Employees;

--Get All FirstName and DepartmentID 
Select FirstName, DepartmentID from Employees;

--Get All FirstName and DepartmentID without duplicated
Select distinct FirstName, DepartmentID from Employees;

--Get All Employees that Gendor female
Select * from Employees where Gendor='F';

--Get All Employees that MonthlySalary less than or equal 700
Select * from Employees where  MonthlySalary<=700;

--Get All Employees that MonthlySalary less than or equal 700 using Not
Select * from Employees where NOT MonthlySalary>=700;

--Get All Employess that Salary less than 700 and Genor is female
Select * from Employees where MonthlySalary<700 and Gendor='F';

--Get All Employess that Salary less than 700 and Genor is female using Not
Select * from Employees where NOT MonthlySalary>700 and NOT Gendor='M';

--Get All Employees that CountryID not equal one using operator >
select * from Employees where CountryID>1;

--Get All Employees that CountryID not equal one using <>
select * from Employees where   CountryID <>1;

--Get All Employees that CountryID not equal one using Not
select * from Employees where NOT CountryID=1;

select * from Employees where DepartmentID=1;

--Get All Employees that DepartmentID  equal one and Genor Male
select * from Employees where DepartmentID=1 and Gendor='M';

--Get All Employees that DepartmentID  equal and quale 2
select * from Employees where DepartmentID=1 Or DepartmentID=2;

--Get All Employees that work now
Select * from Employees where ExitDate is Null;

--Get All Employees that not work now
Select * from Employees where ExitDate  is Not Null;

--Get All Employees that DepartmentID  equal 1 or 2 or 3 or 5
select * from Employees where DepartmentID in(1,2,3,5);

--Get All Employees that FirstName  equal Jacob or Brooks or Harper
SELECT * FROM Employees  WHERE  FirstName IN('Jacob','Brooks','Harper'); 

--Get all Name Departments from employees that salary less than or equal 700;
SELECT Name From Departments where ID IN 
(
SELECT DepartmentID FROM Employees  WHERE MonthlySalary<=700
);

--Get ID,FirstName,Salary when first department and order by asc
SELECT ID,FirstName,MonthlySalary FROM Employees Where DepartmentID=1 
ORDER BY MonthlySalary ASC;

--Get ID,FirstName,Salary when first department and order by desc
SELECT ID,FirstName,MonthlySalary FROM Employees Where DepartmentID=1 
ORDER BY MonthlySalary desc;

--Get ID,FirstName,Salary when firstName asc and  department desc;
SELECT ID,FirstName,MonthlySalary FROM Employees Where DepartmentID=1 
ORDER BY FirstName ASC, MonthlySalary DESC; 

-- This will show top 5 employees. 
Select top 5 * from Employees;

--Get 5% from employees
SELECT TOP 5 PERCENT * FROM Employees

--This will show top  10% of the data.
select top 10 percent * from Employees; 

-- this will show the all salaries ordered from the heighest to lowest. 
select  MonthlySalary from employees order by MonthlySalary Desc; 

-- this will show the all salaries ordered from the heighest to lowest without redundancy. 
select distinct MonthlySalary from employees order by MonthlySalary Desc; 

-- this will show the heighest 3 salaries. 
select  distinct  top 3 MonthlySalary from employees order by MonthlySalary Desc; 

 --This will show all employees who takes one of the heighest 3 salaries. 
select ID , FirstName, MonthlySalary from Employees where MonthlySalary In 
( 
 select  distinct  top 3 MonthlySalary from employees 
 order by MonthlySalary Desc 
) 
Order By MonthlySalary Desc

--Get ID,FirstName,Month Salary / 2 
SELECT ID,FirstName,A=MonthlySalary/2 FROM Employees; 

--Get ID,FullName
SELECT ID,FullName=FirstName+' '+LastName From Employees; 

--Get ID,FullName using as
SELECT ID,FirstName+' '+LastName  as FullName From Employees;

--Get ID,FirstName,MonthlySalary , Yearly Salary
SELECT ID,FirstName,MonthlySalary,MonthlySalary * 12 as YearlySalary from Employees;

--Increase Bonus Amount
SELECT ID,FirstName,MonthlySalary, YearlySalary=MonthlySalary*12, BonusAmount=MonthlySalary*BonusPerc 
 FROM Employees; 

 --Get datetime now
 SELECT NOW=GETDATE();

--Get all employees MonthSalary between 500 and 1000
 SELECT * FROM Employees WHERE MonthlySalary BETWEEN 500 AND 1000;

--Get Count,Sum,AVG,MIN,MAX in MonthSalary when departmentID equal 1
 SELECT  
TotalCount=Count(MonthlySalary), 
TotalSum=Sum(MonthlySalary), 
Average=AVG(MonthlySalary), 
MinimumSalary=MIN(MonthlySalary), 
MaximumSalary=MAX(MonthlySalary) 
FROM Employees

where DepartmentID=1

--Get all number of employees
SELECT TotalEmployee=COUNT(ID) FROM Employees;

--Having is the where satement for group by 
select DepartmentID, TotalCount=Count(MonthlySalary),  
    TotalSum=Sum(MonthlySalary), 
    Average=Avg(MonthlySalary), 
    MinSalary=Min(MonthlySalary), 
    MaxSalary=Max(MonthlySalary)  
	
   from Employees 
   Group By DepartmentID 
   having Count(MonthlySalary) > 100 
   order by DepartmentID asc;
 
 
 -- Same solution without having :-) 
select * from  
( 
 
   select DepartmentID, TotalCount=Count(MonthlySalary),  
    TotalSum=Sum(MonthlySalary), 
    Average=Avg(MonthlySalary), 
    MinSalary=Min(MonthlySalary), 
    MaxSalary=Max(MonthlySalary)  
     
    from Employees 
  
       Group By DepartmentID 
    
) R1 
 
where R1.TotalCount> 100
order by R1.DepartmentID asc;

--Finds any values that start with "a" 
select ID, FirstName from Employees where FirstName like 'a%'; 
 
 --Finds any values that end with "a" 
select ID, FirstName from Employees where FirstName like '%a'; 
 
 --Finds any values that have "tell" in any position 
select ID, FirstName from Employees where FirstName like '%tell%'; 

 -- Finds any values that start with "a" and ends with "a" 
select ID, FirstName from Employees where FirstName like 'a%a'; 

 --Finds any values that have "a" in the second position 
select ID, FirstName from Employees where FirstName like '_a%'; 

 --Finds any values that have "a" in the third position 
select ID, FirstName from Employees where FirstName like '__a%'; 
 
 --Finds any values that start with "a" and are at least 3 characters in length 
select ID, FirstName from Employees where FirstName like 'a__%'; 

 --Finds any values that start with "a" and are at least 4 characters in length 
select ID, FirstName from Employees where FirstName like 'a___%'; 
 
 --Finds any values that start with "a" 
select ID, FirstName from Employees where FirstName like 'a%' or FirstName like 'b%' ; 

--Execute these satatements to update data 
Update Employees  
set FirstName ='Mohammed' , LastName='Abu-Hadhoud' 
where ID= 285; 
 
Update Employees  
set FirstName ='Mohammad' , LastName='Maher' 
where ID= 286; 
 -------------------------------- 
 
select ID, FirstName, LastName from Employees 
Where firstName = 'Mohammed' or FirstName ='Mohammad';  
 
 -- will search form Mohammed or Mohammad 
select ID, FirstName, LastName from Employees Where firstName like 'Mohamm[ae]d'; 
 
 --You can use Not  
select ID, FirstName, LastName from Employees Where firstName Not like 'Mohamm[ae]d'; 
 
select ID, FirstName, LastName from Employees 
Where firstName like 'a%' or firstName like 'b%' or firstName like 'c%'; 
 
 -- search for all employees that their first name start with a or b or c 
select ID, FirstName, LastName from Employees Where firstName like '[abc]%'; 
 
-- search for all employees that their first name start with any letter from a to l 
select ID, FirstName, LastName from Employees Where firstName like '[a-l]%';

--Inner Join two Tables 
SELECT        Employees.ID, Employees.FirstName, Employees.LastName, Departments.Name as DeptName 
FROM Employees INNER JOIN  Departments ON Employees.DepartmentID = Departments.ID 

--Inner joind with where 
SELECT Employees.ID, Employees.FirstName, Employees.LastName, Departments.Name as DeptName 
FROM Employees INNER JOIN  Departments ON Employees.DepartmentID = Departments.ID 
where Departments.Name = 'IT'; 


--Inner Join Three Tables 
SELECT Employees.ID, Employees.FirstName, Employees.LastName, Departments.Name as DeptName, 
Countries.Name AS CountryName FROM Employees INNER JOIN 
Departments ON Employees.DepartmentID = Departments.ID INNER JOIN 
 Countries ON Employees.CountryID = Countries.ID 

--Inner Join Three Tables with where 
SELECT        Employees.ID, Employees.FirstName, Employees.LastName, Departments.Name as DeptName, 
Countries.Name AS CountryName 
FROM Employees INNER JOIN Departments ON Employees.DepartmentID = Departments.ID INNER JOIN 
 Countries ON Employees.CountryID = Countries.ID where Countries.Name = 'USA'; 

 --Create view ActiveEmployees 
CREATE VIEW ActiveEmployees AS 
SELECT * FROM Employees WHERE ExitDate IS NULL; 
SELECT * FROM ActiveEmployees

 --Create view ResignedEmployees 
CREATE VIEW ResignedEmployees AS 
SELECT * FROM Employees WHERE ExitDate IS NOT NULL

SELECT * FROM ResignedEmployees 

 --Create view ShortDetailedEmployees 
CREATE VIEW ShortDetailedEmployees AS 
SELECT ID,FirstName,LastName,Gendor FROM Employees

SELECT* FROM ShortDetailedEmployees 

select * from ActiveEmployees

select * from ResignedEmployees

select * from ActiveEmployees
Union
select * from ResignedEmployees

--this will remove the redundancy from the resultset (distinct results only)
select * from Departments
union 
select * from Departments;

--this will append data regardeless of any redundancy
select * from Departments
union ALL
select * from Departments;

SELECT ID,FirstName,LastName,GendorTitle=

CASE 
WHEN Gendor ='M' THEN 'Male'
WHEN Gendor ='F' THEN 'Female'
ELSE 'UnKnown'
END,

Status=

Case
WHEN ExitDate is NULL THEN 'Active'
WHEN ExitDate is Not NULL THEN 'Resigned'
END
from Employees
