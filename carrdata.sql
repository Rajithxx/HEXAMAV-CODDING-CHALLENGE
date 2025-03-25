INSERT INTO CarRental.Vehicle (make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES
('Toyota', 'Camry', 2022, 50.00, 'available', 4, 1450),
('Honda', 'Civic', 2023, 45.00, 'available', 7, 1500),
('Ford', 'Focus', 2022, 48.00, 'notAvailable', 4, 1400),
('Nissan', 'Altima', 2023, 52.00, 'available', 7, 1200),
('Chevrolet', 'Malibu', 2022, 47.00, 'available', 4, 1800),
('Hyundai', 'Sonata', 2023, 49.00, 'notAvailable', 7, 1400),
('BMW', '3 Series', 2023, 60.00, 'available', 7, 2499),
('Mercedes', 'C-Class', 2022, 58.00, 'available', 8, 2599),
('Audi', 'A4', 2022, 55.00, 'notAvailable', 4, 2500),
('Lexus', 'ES', 2023, 54.00, 'available', 4, 2500);


INSERT INTO CarRental.Customer (firstName, lastName, email, phoneNumber)
VALUES
('John', 'Doe', 'johndoe@example.com', '555-555-5555'),
('Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
('Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
('Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
('David', 'Lee', 'david@example.com', '555-987-6543'),
('Laura', 'Hall', 'laura@example.com', '555-234-5678'),
('Michael', 'Davis', 'michael@example.com', '555-876-5432'),
('Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
('William', 'Taylor', 'william@example.com', '555-321-6547'),
('Olivia', 'Adams', 'olivia@example.com', '555-765-4321');


INSERT INTO CarRental.Lease (vehicleID, customerID, startDate, endDate, leaseType)
VALUES
(1, 1, '2023-01-01', '2023-01-05', 'Daily'),
(2, 2, '2023-02-15', '2023-02-28', 'Monthly'),
(3, 3, '2023-03-10', '2023-03-15', 'Daily'),
(4, 4, '2023-04-20', '2023-04-30', 'Monthly'),
(5, 5, '2023-05-05', '2023-05-10', 'Daily'),
(4, 3, '2023-06-15', '2023-06-30', 'Monthly'),
(7, 7, '2023-07-01', '2023-07-10', 'Daily'),
(8, 8, '2023-08-12', '2023-08-15', 'Monthly'),
(3, 3, '2023-09-07', '2023-09-10', 'Daily'),
(10, 10, '2023-10-10', '2023-10-31', 'Monthly');

INSERT INTO CarRental.Payment (leaseID, paymentDate, amount)
VALUES
(1, '2023-01-03', 200.00),
(2, '2023-02-20', 1000.00),
(3, '2023-03-12', 75.00),
(4, '2023-04-25', 900.00),
(5, '2023-05-07', 60.00),
(6, '2023-06-18', 1200.00),
(7, '2023-07-03', 40.00),
(8, '2023-08-14', 1100.00),
(9, '2023-09-09', 80.00),
(10, '2023-10-25', 1500.00);

INSERT INTO CarRental.Vehicle (make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES
('Toyota', 'Corolla', 2024, 60.00, 'available', 5, 1600),
('Honda', 'Accord', 2023, 65.00, 'available', 4, 1800),
('Ford', 'Explorer', 2024, 75.00, 'available', 7, 2400),
('Nissan', 'Sentra', 2023, 55.00, 'available', 5, 1400),
('BMW', 'X5', 2024, 90.00, 'available', 5, 3000),
('Mercedes', 'GLC', 2023, 85.00, 'available', 4, 2700),
('Chevrolet', 'Tahoe', 2023, 80.00, 'available', 7, 3500),
('Audi', 'Q7', 2024, 95.00, 'available', 5, 2800);


INSERT INTO CarRental.Customer (firstName, lastName, email, phoneNumber)
VALUES
('Kevin', 'Anderson', 'kevin.a@example.com', '555-100-1000'),
('Sophia', 'Moore', 'sophia.m@example.com', '555-200-2000'),
('Liam', 'Walker', 'liam.w@example.com', '555-300-3000'),
('Emily', 'Harris', 'emily.h@example.com', '555-400-4000'),
('James', 'Clark', 'james.c@example.com', '555-500-5000'),
('Emma', 'Lewis', 'emma.l@example.com', '555-600-6000'),
('Noah', 'King', 'noah.k@example.com', '555-700-7000'),
('Olivia', 'Hall', 'olivia.h@example.com', '555-800-8000');




