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



