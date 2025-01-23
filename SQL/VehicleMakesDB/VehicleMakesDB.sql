USE VehicleMakesDB;
SELECT * FROM VehicleDetails

SELECT * FROM VehicleMasterDetails

--Create Master view
CREATE VIEW VehicleMasterDetails AS
SELECT VehicleDetails.ID,
	VehicleDetails.MakeID,
	Makes.Make,
	VehicleDetails.ModelID,
	MakeModels.ModelName,
	VehicleDetails.SubModelID,
	SubModels.SubModelName,
	VehicleDetails.BodyID,
	Bodies.BodyName,
	VehicleDetails.Vehicle_Display_Name,
	VehicleDetails.Year,
	VehicleDetails.DriveTypeID,
	DriveTypes.DriveTypeName,
	VehicleDetails.Engine,
	VehicleDetails.Engine_CC,
	VehicleDetails.Engine_Cylinders,
	VehicleDetails.Engine_Liter_Display,
	VehicleDetails.FuelTypeID,
	FuelTypes.FuelTypeName,
	VehicleDetails.NumDoors

	from VehicleDetails 

	LEFT JOIN Makes ON Makes.MakeID = VehicleDetails.MakeID
	LEFT JOIN MakeModels ON MakeModels.ModelID = VehicleDetails.ModelID
	LEFT JOIN SubModels ON SubModels.SubModelID = VehicleDetails.SubModelID
	LEFT JOIN Bodies ON Bodies.BodyID = VehicleDetails.BodyID
	LEFT JOIN DriveTypes ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID 
	LEFT JOIN FuelTypes ON FuelTypes.FuelTypeID = VehicleDetails.FuelTypeID

--Get all vehicles made between 1950 and 2000
SELECT * FROM VehicleDetails WHERE Year Between 1950 and 2000;

--another solution
SELECT * FROM VehicleDetails WHERE Year > 1950 and Year < 2000;

--Get number vehicles made between 1950 and 2000
SELECT NumberOfVehicles=COUNT(*) FROM VehicleDetails  WHERE Year between 1950 and 2000;

--another solution
SELECT COUNT(*) as NumberOfVehicles FROM VehicleDetails  WHERE Year between 1950 and 2000 ;

-- Get number vehicles made between 1950 and 2000 per make and order them by Number Of Vehicles Descending
SELECT Makes.Make,COUNT(*) as NumberOfVehicles FROM VehicleDetails INNER JOIN Makes
ON Makes.MakeID=VehicleDetails.MakeID
WHERE (VehicleDetails.Year Between 1950 and 2000)
Group by Makes.Make
order by NumberOfVehicles desc

--Get All Makes that have manufactured more than 12000 Vehicles in years 1950 to 2000
SELECT Makes.Make,COUNT(*) as NumberOfVehicles FROM VehicleDetails INNER JOIN Makes
ON Makes.MakeID=VehicleDetails.MakeID
WHERE (VehicleDetails.Year Between 1950 and 2000)
Group by Makes.Make
having count(*)  > 12000
order by NumberOfVehicles desc;

--another solution using where statement.
SELECT * FROM 
(
SELECT Makes.Make,COUNT(*) as NumberOfVehicles FROM VehicleDetails INNER JOIN Makes
ON Makes.MakeID=VehicleDetails.MakeID
WHERE (VehicleDetails.Year Between 1950 and 2000)
Group by Makes.Make
) R1
where R1.NumberOfVehicles > 12000
order by R1.NumberOfVehicles desc

--Get number of vehicles made between 1950 and 2000 per make and add total vehicles column beside
SELECT Makes.Make,COUNT(*)as NumberOfVehicles,(select count(*) from VehicleDetails) as TotalVehicles
FROM VehicleDetails INNER JOIN 
                    Makes ON VehicleDetails.MakeID=Makes.MakeID

WHERE (VehicleDetails.Year BETWEEN 1950 AND 2000)
GROUP BY Makes.Make
ORDER BY NumberOfVehicles DESC


--Get number of vehicles made between 1950 and 2000 per make and add total vehicles column beside it, then calculate it's percentage
select *,CAST (NumberOfVehicles as float)/CAST(TotalVehicles as float ) as Perc From
(
   SELECT Makes.Make,COUNT(*) AS NumberOfVehicles,(select count(*) from VehicleDetails) as TotalVehicles
   FROM  VehicleDetails INNER JOIN 
              Makes ON VehicleDetails.MakeID=Makes.MakeID
    WHERE (VehicleDetails.Year BETWEEN 1950 AND 2000)
	GROUP BY Makes.Make
)R1
order by NumberOfVehicles desc

--Get Make, FuelTypeName and Number of Vehicles per FuelType per Make
SELECT Makes.Make,FuelTypes.FuelTypeName,COUNT(*) AS NumberOfVehicles
FROM VehicleDetails INNER JOIN 
                    Makes ON VehicleDetails.MakeID=Makes.MakeID INNER JOIN
					FuelTypes ON VehicleDetails.FuelTypeID=FuelTypes.FuelTypeID
WHERE (VehicleDetails.Year BETWEEN 1950 AND 2000)
GROUP BY Makes.Make,FuelTypes.FuelTypeName
ORDER BY Makes.Make

--Get all vehicles that runs with GAS
SELECT VehicleDetails.*,FuelTypes.FuelTypeName
FROM VehicleDetails INNER JOIN FuelTypes ON VehicleDetails.FuelTypeID=FuelTypes.FuelTypeID
WHERE (FuelTypes.FuelTypeName=N'GAS')

--Get all Makes that runs with GAS
SELECT Makes.Make,FuelTypes.FuelTypeName
FROM VehicleDetails INNER JOIN FuelTypes ON VehicleDetails.FuelTypeID=FuelTypes.FuelTypeID INNER JOIN
Makes ON VehicleDetails.MakeID=Makes.MakeID
WHERE (FuelTypes.FuelTypeName=N'GAS')

--Get Total Makes that runs with GAS
SELECT COUNT(*) as TotalMakesRunsOnGas
from (
     SELECT distinct Makes.Make,FuelTypes.FuelTypeName
	 from            Makes INNER JOIN 
	                 VehicleDetails ON Makes.MakeID=VehicleDetails.MakeID INNER JOIN
					 FuelTypes ON VehicleDetails.FuelTypeID=FuelTypes.FuelTypeID
WHERE (FuelTypes.FuelTypeName=N'GAS')
)R1

--Count Vehicles by make and order them by NumberOfVehicles from high to low.
SELECT Makes.Make,COUNT(*) AS NumberOfVehiclses
FROM VehicleDetails INNER JOIN 
                   Makes ON VehicleDetails.MakeID=Makes.MakeID
GROUP BY Makes.Make
ORDER BY NumberOfVehiclses desc;

--Get all Makes/Count Of Vehicles that manufactures more than 20K Vehicles
SELECT Makes.Make,COUNT(*) AS NumberOfVehicles
             from VehicleDetails INNER JOIN 
             Makes ON VehicleDetails.MakeID=Makes.MakeID
GROUP BY Makes.Make
having count(*)> 2000
order by NumberOfVehicles desc;

--Get all Makes with make starts with 'B'
SELECT  Makes.Make FROM Makes where Makes.Make like 'B%';

--Get all  Makes with make ends with 'W'
select Makes.Make from Makes where Makes.Make like '%W';

--Get all Makes that manufactures DriveTypeName = FWD
SELECT        distinct Makes.Make, DriveTypes.DriveTypeName
FROM            DriveTypes INNER JOIN
                         VehicleDetails ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID
Where DriveTypes.DriveTypeName ='FWD'

--Get total Makes that Mantufactures DriveTypeName=FWD
select count(*) MakeWithFWD
from
(
	SELECT        distinct Makes.Make, DriveTypes.DriveTypeName
	FROM            DriveTypes INNER JOIN
							 VehicleDetails ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID INNER JOIN
							 Makes ON VehicleDetails.MakeID = Makes.MakeID
	Where DriveTypes.DriveTypeName ='FWD'
) R1

--Get total vehicles per DriveTypeName Per Make and order them per make asc then per total Desc
SELECT        distinct Makes.Make, DriveTypes.DriveTypeName, Count(*) AS Total
FROM            DriveTypes INNER JOIN
                         VehicleDetails ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID
Group By Makes.Make, DriveTypes.DriveTypeName
Order By Make ASC, Total Desc

--Get total vehicles per DriveTypeName Per Make then filter only results with total > 10,000
SELECT        distinct Makes.Make, DriveTypes.DriveTypeName, Count(*) AS Total
FROM            DriveTypes INNER JOIN
                         VehicleDetails ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID
Group By Makes.Make, DriveTypes.DriveTypeName
Having Count(*) > 10000
Order By Make ASC, Total Desc

--Get all Vehicles that number of doors is not specified
select * from VehicleDetails where NumDoors is Null

--Get all Vehicles that number of doors is not specified
select count(*) as TotalWithNoSpecifiedDoors from VehicleDetails where NumDoors is Null

--Get percentage of vehicles that has no doors specified

select 
	(
		CAST(	(select count(*) as TotalWithNoSpecifiedDoors from VehicleDetails
		where NumDoors is Null) as float)
		/
		Cast( (select count(*) from VehicleDetails as TotalVehicles) as float)
	) as PercOfNoSpecifiedDoors

-- Get MakeID , Make, SubModelName for all vehicles that have SubModelName 'Elite'

SELECT    distinct    VehicleDetails.MakeID, Makes.Make, SubModelName
FROM            VehicleDetails INNER JOIN
                         SubModels ON VehicleDetails.SubModelID = SubModels.SubModelID INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID
	where SubModelName='Elite'

-- Get all vehicles that have Engines > 3 Liters and have only 2 doors
select * from VehicleDetails where Engine_Liter_Display > 3 and NumDoors =2

-- Get  make and vehicles that the engine contains 'OHV' and have Cylinders = 4
SELECT         Makes.Make, VehicleDetails.*
FROM            VehicleDetails INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE        (VehicleDetails.Engine LIKE '%OHV%') AND (VehicleDetails.Engine_Cylinders = 4)

-- Get all vehicles that their body is 'Sport Utility' and Year > 2020
SELECT      BodyName,  VehicleDetails.*
FROM            VehicleDetails INNER JOIN
                         Bodies ON VehicleDetails.BodyID = Bodies.BodyID
Where BodyName='Sport Utility' and Year > 2020

---- Get all vehicles that their Body is 'Coupe' or 'Hatchback' or 'Sedan'
SELECT       bodyName, VehicleDetails.*
FROM            VehicleDetails INNER JOIN
                         Bodies ON VehicleDetails.BodyID = Bodies.BodyID
Where BodyName in ('Coupe','Hatchback','Sedan')

-- Get all vehicles that their body is 'Coupe' or 'Hatchback' or 'Sedan' and manufactured in year  2008 or 2020 or 2021
SELECT       bodyName, VehicleDetails.*
FROM            VehicleDetails INNER JOIN
                         Bodies ON VehicleDetails.BodyID = Bodies.BodyID
Where BodyName in ('Coupe','Hatchback','Sedan') and Year in ( 2008, 2020, 2021)

-- Return found=1 if there is any vehicle made in year 1950
select found=1 
where 
exists (
        select top 1 * from VehicleDetails where Year =1950;

--Get all Vehicle_Display_Name, NumDoors and add extra column to describe number of doors by words, and if door is null display 'Not Set'
SELECT VehicleDetails.Vehicle_Display_Name,VehicleDetails.NumDoors,
		NumberOfDoorsByWords = CASE
			WHEN NumDoors = 0 THEN 'Zero Doors'
			WHEN NumDoors = 1 THEN 'One Door'
			WHEN NumDoors = 2 THEN 'Tow Doors'
			WHEN NumDoors = 3 THEN 'Three Doors'
			WHEN NumDoors = 4 THEN 'four Doors'
			WHEN NumDoors = 5 THEN 'five Doors'
			WHEN NumDoors = 6 THEN 'Six Doors'
			WHEN NumDoors = 8 THEN 'Eight Doors'
			ELSE 'Not Set'
		END 
FROM VehicleDetails

-- Get all Vehicle_Display_Name, year and add extra column to calculate the age of the car then sort the results by age desc.
-- Note that YEAR in capital Letters is built in function in SQL Server that will give your the year of the given date :-) , 
-- and the year in small letters is the column name
Select VehicleDetails.Vehicle_Display_Name, Year, Age= YEAR(GetDate()) - VehicleDetails.year 
from VehicleDetails
Order by Age Desc

-- Get all Vehicle_Display_Name, year, Age for vehicles that their age between 15 and 25 years old 
select * from
( 
	Select VehicleDetails.Vehicle_Display_Name, Year, Age= YEAR(GetDate()) - VehicleDetails.year
	from VehicleDetails
) R1
Where Age between 15 and 25

-- Get Minimum Engine CC , Maximum Engine CC , and Average Engine CC of all Vehicles
select  Min(Engine_CC) as MinimimEngineCC,Max(Engine_CC) as MaximumEngineCC, AVG(Engine_CC)  as AverageEngineCC
from VehicleDetails

-- Get all vehicles that have the minimum Engine_CC
Select VehicleDetails.Vehicle_Display_Name from VehicleDetails
where Engine_CC = ( select  Min(Engine_CC) as MinEngineCC  from VehicleDetails )

-- Get all vehicles that have the Maximum Engin_CC
Select VehicleDetails.Vehicle_Display_Name from VehicleDetails
where Engine_CC = ( select  Max(Engine_CC) as MinEngineCC  from VehicleDetails )

-- Get all vehicles that have  Engin_CC below average
Select VehicleDetails.Vehicle_Display_Name from VehicleDetails
where Engine_CC < ( select  avg(Engine_CC) as MinEngineCC  from VehicleDetails )

-- Get total vehicles that have  Engin_CC above average
select Count(*) as NumberOfVehiclesAboveAverageEngineCC from
(
	Select ID,VehicleDetails.Vehicle_Display_Name from VehicleDetails
	where Engine_CC > ( select  Avg(Engine_CC) as MinEngineCC  from VehicleDetails )
) R1

-- Get all unique  Engin_CC and sort them Desc
Select  distinct  Engine_CC from VehicleDetails
Order By Engine_CC Desc

-- Get the maximum 3 Engine CC
Select  distinct top 3 Engine_CC from VehicleDetails
	Order By Engine_CC Desc

-- Get all vehicles that has one of the Max 3 Engine CC
Select Vehicle_Display_Name from VehicleDetails
where Engine_CC in 
(
	Select  distinct top 3 Engine_CC from VehicleDetails
	Order By Engine_CC Desc
)

-- Get all Makes  that manufactures one of the Max 3 Engine CC
SELECT        distinct Makes.Make
FROM            VehicleDetails INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE        (VehicleDetails.Engine_CC IN
                             (SELECT DISTINCT TOP (3) Engine_CC
                               FROM            VehicleDetails 
                               ORDER BY Engine_CC DESC)
							 )

Order By Make
-- Get a table of unique Engine_CC and calculate tax per Engine CC as follows:
	-- 0 to 1000    Tax = 100
	-- 1001 to 2000 Tax = 200
	-- 2001 to 4000 Tax = 300
	-- 4001 to 6000 Tax = 400
	-- 6001 to 8000 Tax = 500
	-- Above 8000   Tax = 600
	-- Otherwise    Tax = 0
select Engine_CC,

	CASE
		WHEN Engine_CC between 0 and 1000 THEN 100
		 WHEN Engine_CC between 1001 and 2000 THEN 200
		 WHEN Engine_CC between 2001 and 4000 THEN 300
		 WHEN Engine_CC between 4001 and 6000 THEN 400
		 WHEN Engine_CC between 6001 and 8000 THEN 500
		 WHEN Engine_CC > 8000 THEN 600	
		ELSE 0
	END as Tax
from 
(
	select distinct Engine_CC from VehicleDetails
	
) R1
order by Engine_CC

-- Get Make and Total Number Of Doors Manufactured Per Make
SELECT        Makes.Make, Sum(VehicleDetails.NumDoors) AS TotalNumberOfDoors
FROM            VehicleDetails INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID
Group By Make
Order By TotalNumberOfDoors desc

-- Get Total Number Of Doors Manufactured by 'Ford'
SELECT        Makes.Make, Sum(VehicleDetails.NumDoors) AS TotalNumberOfDoors
FROM            VehicleDetails INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID
Group By Make
Having Make='Ford'

-- Get Number of Models Per Make

SELECT        Makes.Make, COUNT(*) AS NumberOfModels
FROM            Makes INNER JOIN
                         MakeModels ON Makes.MakeID = MakeModels.MakeID
GROUP BY Makes.Make
Order By NumberOfModels Desc

-- Get the highest 3 manufacturers that make the highest number of models
SELECT      top 3  Makes.Make, COUNT(*) AS NumberOfModels
FROM            Makes INNER JOIN
                         MakeModels ON Makes.MakeID = MakeModels.MakeID
GROUP BY Makes.Make
Order By NumberOfModels Desc

-- Get the highest number of models manufactured
select Max(NumberOfModels) as MaxNumberOfModels
from
(
		SELECT        Makes.Make, COUNT(*) AS NumberOfModels
		FROM            Makes INNER JOIN
								 MakeModels ON Makes.MakeID = MakeModels.MakeID
		GROUP BY Makes.Make
) R1

--Get all FuelTypes , each time the result should be showed in random order
-- Note that the NewID() function will generate GUID for each row 
select * from FuelTypes
order by NewID()
