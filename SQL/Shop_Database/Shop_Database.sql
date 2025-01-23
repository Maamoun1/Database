
USE Shop_Database;

-- Get all Customers
SELECT * FROM Customers

-- Get all Orders
SELECT * FROM Orders

SELECT Customers.CustomerID, Customers.Name, Orders.amount FROM Customers INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID

Where Orders.Amount > 500;

--Left Join and Left Outer Join are the same. 
 --Left Join: gets all data from table customers and only matched data from table orders 
SELECT Customers.CustomerID, Customers.Name, Orders.Amount 
FROM Customers Left JOIN Orders  ON Customers.CustomerID = Orders.CustomerID; 
 
SELECT Customers.CustomerID, Customers.Name, Orders.Amount 
FROM Customers Left Outer JOIN Orders  ON Customers.CustomerID = Orders.CustomerID; 

--Inner Join 
SELECT        Customers.CustomerID, Customers.Name, Orders.Amount 
FROM            Customers INNER JOIN 
                         Orders ON Customers.CustomerID = Orders.CustomerID 
						 
--Left Join 
SELECT        Customers.CustomerID, Customers.Name, Orders.Amount 
FROM            Customers LEFT OUTER JOIN 
                         Orders ON Customers.CustomerID = Orders.CustomerID 
--Right Join 
SELECT        Customers.CustomerID, Customers.Name, Orders.Amount 
FROM            Customers RIGHT OUTER JOIN 
                         Orders ON Customers.CustomerID = Orders.CustomerID 
--Full Join 
SELECT        Customers.CustomerID, Customers.Name, Orders.Amount 
FROM            Customers FULL OUTER JOIN 
                         Orders ON Customers.CustomerID = Orders.CustomerID 

SELECT X='YES'
WHERE EXISTS (
SELECT * FROM Orders WHERE Orders.CustomerID=3 AND Orders.Amount < 600);


SELECT * FROM Customers T1
WHERE EXISTS (
SELECT * FROM Orders
WHERE Orders.CustomerID=T1.CustomerID AND Orders.Amount < 600)

--Optmize the previous query
SELECT * FROM Customers T1
WHERE EXISTS (
SELECT top 1 * FROM Orders
WHERE Orders.CustomerID=T1.CustomerID AND Orders.Amount < 600)

--Optmize more the previous query
SELECT * FROM Customers T1
WHERE EXISTS (
SELECT top 1 X='Y' FROM Orders
WHERE Orders.CustomerID=T1.CustomerID AND Orders.Amount < 600)

