/*
	Name :- Clavan Dsouza
	Course:- Database 2
	Date:- 13th January,2024.
*/

-- Q1
SELECT Empl_Num, Name, Age, Rep_Office, Title, Hire_date, Manager, Quota, Sales 
FROM 
Salesreps 
WHERE Sales < (SELECT AVG(Sales) FROM Salesreps);

-- Q2
SELECT s1.Name As Employee_Name, s1.Empl_Num, s1.Age, s1.Title, 
	s2.Name as Manager_Name, s2.Empl_Num AS Manager_ID, s2.Title AS Manager_Title
FROM 
Salesreps s1  LEFT JOIN Salesreps s2
ON s2.Empl_Num = s1.Manager;

-- Q3
ALTER TABLE CUSTOMERS
ALTER COLUMN COMPANY VARCHAR(100);

UPDATE Customers
SET Company = 'Boyce and Codd Associates'
WHERE Company = 'Chen Associates';
SELECt * FROM Customers;

-- Q4
SELECT Mfr_id, Product_id, Description, Price, Qty_On_hand 
FROM 
Products 
WHERE Price BETWEEN 75 AND 120;

-- Q5
SELECT o.City, COUNT(s.REP_Office) AS Number_Of_Salesreps
FROM 
Offices o LEFT JOIN Salesreps s 
ON o.OFFICE = s.REP_OFFICE
GROUP BY o.city;

