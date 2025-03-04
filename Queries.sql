INSERT INTO Customers (CustomerID, CustomerUniqueID, ZipCode, City, State)
VALUES ('Cust#', 'Cust0001', '515468465', '2281696', 'AP');

INSERT INTO Orders (
  OrderID,
  CustomerID,
  OrderStatus,
  PurchaseTimestamp,
  ApprovedAt,
  DeliveredCarrierDate,
  DeliveredCustomerDate,
  EstimatedDeliveryDate
)
VALUES (
  'order#',
  'Cust#',  
  'delivered',
  '2020-03-10 14:20:00',
  '2020-03-10 15:00:00',
  '2020-03-11 09:30:00',
  '2020-03-12 13:45:00',
  '2020-03-15 00:00:00'
);

UPDATE Customers
SET City = 'updatedcity', State = 'UP'
WHERE CustomerID = 'abc123xyfakecust001';

UPDATE Geolocation
SET ZipCodePrefix = '00000'
WHERE GeolocationID = 1; 

DELETE FROM Sellers
WHERE SellerID = 'ce3ad9de960102d0677a81f5d0bb7b2d';

SELECT SellerID, City, State
FROM Sellers
WHERE State = 'SP'
LIMIT 5;

SELECT 
  C.CustomerID,
  C.City,
  O.OrderID,
  O.OrderStatus
FROM Customers AS C
JOIN Orders AS O ON C.CustomerID = O.CustomerID
WHERE O.OrderStatus = 'delivered';

SELECT 
  O.OrderID,
  O.OrderStatus,
  P.PaymentID,
  P.PaymentType,
  P.PaymentValue
FROM Orders O
JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.PaymentValue > 100.00;

SELECT OrderStatus, COUNT(*) AS TotalOrders
FROM Orders
GROUP BY OrderStatus;

SELECT PaymentType,
       COUNT(PaymentID) AS NumberOfPayments,
       SUM(PaymentValue) AS TotalPaymentValue
FROM Payments
GROUP BY PaymentType;

SELECT
    P.OrderID,
    P.PaymentType,
    P.PaymentValue,
    S.SellerID,
    S.City AS SellerCity,
    S.State AS SellerState,
    G.City AS GeolocationCity,
    G.State AS GeolocationState
FROM Payments P
LEFT JOIN Sellers S ON P.OrderID = S.SellerID
LEFT JOIN Geolocation G ON S.ZipCode = G.ZipCodePrefix
WHERE P.PaymentValue > 100
ORDER BY P.PaymentID DESC
LIMIT 5;

SELECT OrderID, CustomerID, OrderStatus, PurchaseTimestamp
FROM Orders
WHERE PurchaseTimestamp
  BETWEEN '2017-07-01 00:00:00' AND '2017-07-31 23:59:59';
