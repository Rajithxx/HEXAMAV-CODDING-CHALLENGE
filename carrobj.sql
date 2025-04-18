CREATE SCHEMA CarRental;
go

Create TABLE CarRental.Vehicle
(
vehicleID INT PRIMARY KEY IDENTITY,
make NVARCHAR(50) NOT NULL,
model NVARCHAR(50) NOT NULL,
year INT NOT NULL,
dailyRate DECIMAL(10, 2) NOT NULL,
status NVARCHAR(20) CHECK (status IN ('available', 'notAvailable')) NOT NULL,
passengerCapacity INT NOT NULL,
engineCapacity INT NOT NULL
);

CREATE TABLE CarRental.Customer (
    customerID INT PRIMARY KEY IDENTITY,
    firstName NVARCHAR(50) NOT NULL,
    lastName NVARCHAR(50) NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    phoneNumber NVARCHAR(15) NOT NULL
);


CREATE TABLE CarRental.Lease
(
    leaseID INT PRIMARY KEY IDENTITY,
    vehicleID INT FOREIGN KEY REFERENCES CarRental.Vehicle(vehicleID) ON DELETE CASCADE,
    customerID INT FOREIGN KEY REFERENCES CarRental.Customer(customerID) ON DELETE CASCADE,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    leaseType NVARCHAR(20) CHECK (leaseType IN ('Daily', 'Monthly')) NOT NULL
);



CREATE TABLE CarRental.Payment
(
    paymentID INT PRIMARY KEY IDENTITY,
    leaseID INT FOREIGN KEY REFERENCES CarRental.Lease(leaseID) ON DELETE CASCADE,
    paymentDate DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL
);

DROP TABLE CarRental.Payment;
 DROP TABLE CarRental.Lease;
DROP TABLE CarRental.Vehicle;
DROP TABLE CarRental.Customer;

--questions
--1. Update the Daily Rate for a Mercedes Car to 68
UPDATE CarRental.Vehicle
SET dailyRate = 68.00 WHERE make = 'mercedes';
select * from CarRental.Vehicle


--2. Delete a Specific Customer and All Associated Leases and Payments
DELETE FROM CarRental.Customer
WHERE customerID = 4;
select * from CarRental.Customer

--3. Rename the paymentDate Column in the Payment Table to transactionDate

EXEC sp_rename 'CarRental.Payment.paymentDate','transactionDate','COLUMN';                         
select * from CarRental.Payment

--4. Find a Specific Customer by Email
SELECT *
FROM CarRental.Customer WHERE email = 'johndoe@example.com';

-- 5. Get Active Leases for a Specific Customer
DECLARE @customerID INT = 1;
SELECT L.leaseID, V.make, V.model, L.startDate, L.endDate, L.leaseType
FROM CarRental.Lease L
JOIN CarRental.Vehicle V ON L.vehicleID = V.vehicleID
WHERE L.customerID = @customerID AND L.endDate >= GETDATE();

SELECT * FROM CarRental.Payment
SELECT *FROM CarRental.Customer
SELECT *FROM CarRental.Vehicle
-- 5. Get Active Leases for a Specific Customer
INSERT INTO CarRental.Lease (vehicleID, customerID, startDate, endDate, leaseType)
VALUES
(11, 11, '2025-03-20', '2025-03-30', 'Daily'),
(12, 12, '2025-03-18', '2025-04-10', 'Monthly'),
(13, 13, '2025-03-22', '2025-04-01', 'Daily'),
(14, 14, '2025-03-19', '2025-04-05', 'Daily'),
(15, 15, '2025-03-23', '2025-04-15', 'Monthly'),
(16, 16, '2025-03-21', '2025-03-29', 'Daily'),
(17, 17, '2025-03-24', '2025-03-31', 'Daily'),
(18, 18, '2025-03-25', '2025-04-12', 'Monthly');

DECLARE @customerID INT = 11;
SELECT L.leaseID, V.make, V.model, L.startDate, L.endDate, L.leaseType
FROM CarRental.Lease L
JOIN CarRental.Vehicle V ON L.vehicleID = V.vehicleID
WHERE L.customerID = @customerID AND L.endDate >= GETDATE();

--6. Find All Payments Made by a Customer with a Specific Phone Number
SELECT P.paymentID, P.leaseID, P.transactionDate, P.amount
FROM CarRental.Payment P
INNER JOIN CarRental.Lease L ON P.leaseID = L.leaseID
INNER JOIN CarRental.Customer C ON L.customerID = C.customerID
WHERE C.phoneNumber = '555-555-5555';

--7. Calculate the Average Daily Rate of All Available Cars
SELECT AVG(dailyRate) AS AvgDailyRate
FROM CarRental.Vehicle
WHERE status = 'available';

--8. Find the Car with the Highest Daily Rate
SELECT TOP 1 make, model, dailyRate
FROM CarRental.Vehicle
ORDER BY dailyRate DESC;

--9. Retrieve All Cars Leased by a Specific Customer
SELECT V.make, V.model, V.year, V.dailyRate, L.startDate, L.endDate
FROM CarRental.Lease L
JOIN CarRental.Vehicle V ON L.vehicleID = V.vehicleID
WHERE L.customerID = 1;

--10. Find the Details of the Most Recent Lease
SELECT TOP 1 L.leaseID, C.firstName, C.lastName, V.make, V.model, L.startDate, L.endDate
FROM CarRental.Lease L
JOIN CarRental.Customer C ON L.customerID = C.customerID
JOIN CarRental.Vehicle V ON L.vehicleID = V.vehicleID
ORDER BY L.startDate DESC;

--11. List All Payments Made in the Year 2023
SELECT *
FROM CarRental.Payment
WHERE YEAR(transactionDate) = 2023;

--12. Retrieve Customers Who Have Not Made Any Payments
SELECT C.*
FROM CarRental.Customer C
WHERE NOT EXISTS (
SELECT *
FROM CarRental.Lease L
JOIN CarRental.Payment P ON L.leaseID = P.leaseID
WHERE L.customerID = C.customerID
);

--13. Retrieve Car Details and Their Total Payments
SELECT V.vehicleID, V.make, V.model,
SUM(P.amount) AS TotalPayments
FROM CarRental.Vehicle V
JOIN CarRental.Lease L ON V.vehicleID = L.vehicleID
JOIN CarRental.Payment P ON L.leaseID = P.leaseID
GROUP BY V.vehicleID, V.make, V.model;

--14. Calculate Total Payments for Each Customer
SELECT C.customerID, C.firstName, C.lastName,
SUM(P.amount) AS TotalPayments
FROM CarRental.Customer C
JOIN CarRental.Lease L ON C.customerID = L.customerID
JOIN CarRental.Payment P ON L.leaseID = P.leaseID
GROUP BY C.customerID, C.firstName, C.lastName;

--15. List Car Details for Each Lease

SELECT L.leaseID, V.make, V.model, V.year, L.startDate, L.endDate, L.leaseType
FROM CarRental.Lease L
JOIN CarRental.Vehicle V ON L.vehicleID = V.vehicleID;

--16. Retrieve Details of Active Leases with Customer and Car Information
SELECT L.leaseID, C.firstName, C.lastName, V.make, V.model, L.startDate, L.endDate, L.leaseType
FROM CarRental.Lease L
JOIN CarRental.Customer C ON L.customerID = C.customerID
JOIN CarRental.Vehicle V ON L.vehicleID = V.vehicleID
WHERE L.endDate >= GETDATE();


--17. Find the Customer Who Has Spent the Most on Leases
SELECT TOP 1 C.customerID, C.firstName, C.lastName, 
SUM(P.amount) AS TotalSpent
FROM CarRental.Customer C
JOIN CarRental.Lease L ON C.customerID = L.customerID
JOIN CarRental.Payment P ON L.leaseID = P.leaseID
GROUP BY C.customerID, C.firstName, C.lastName
ORDER BY TotalSpent DESC;

--18. List All Cars with Their Current Lease Information
SELECT V.vehicleID, V.make, V.model, L.startDate, L.endDate, L.leaseType, C.firstName, C.lastName
FROM CarRental.Vehicle V
LEFT JOIN CarRental.Lease L ON V.vehicleID = L.vehicleID AND L.endDate >= GETDATE()
LEFT JOIN CarRental.Customer C ON L.customerID = C.customerID;
