CREATE TABLE Customers (
    CustomerID VARCHAR(50) PRIMARY KEY,
    CustomerUniqueID VARCHAR(50) UNIQUE NOT NULL,
    ZipCode VARCHAR(10) NOT NULL,
    City VARCHAR(255) NOT NULL,
    State VARCHAR(100) NOT NULL
);

-- Orders Table
CREATE TABLE Orders (
    OrderID VARCHAR(50) PRIMARY KEY,
    CustomerID VARCHAR(50),
    OrderStatus VARCHAR(20) CHECK (OrderStatus IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')),
    PurchaseTimestamp DATETIME,
    ApprovedAt DATETIME,
    DeliveredCarrierDate DATETIME,
    DeliveredCustomerDate DATETIME,
    EstimatedDeliveryDate DATETIME,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Product_Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(255) UNIQUE NOT NULL
);
-- Drop the existing Product_Categories table if it exists
DROP TABLE IF EXISTS Product_Categories;

-- Create the new Product_Categories table based on the provided data
CREATE TABLE Product_Categories (
    ProductCategoryName VARCHAR(255) PRIMARY KEY,
    ProductCategoryNameEnglish VARCHAR(255) NOT NULL
);

-- Products Table
CREATE TABLE Products (
    ProductID VARCHAR(50) PRIMARY KEY,
    CategoryID INT,
    ProductNameLength INT,
    ProductDescriptionLength INT,
    ProductPhotosQty INT,
    ProductWeight DECIMAL(10,2),
    ProductLength DECIMAL(10,2),
    ProductHeight DECIMAL(10,2),
    ProductWidth DECIMAL(10,2),
    FOREIGN KEY (CategoryID) REFERENCES Product_Categories(CategoryID)
);
-- Drop the existing foreign key constraint from the Products table
ALTER TABLE Products
DROP FOREIGN KEY Products_ibfk_1;

-- Drop the CategoryID column from the Products table
ALTER TABLE Products
DROP COLUMN CategoryID;

-- Sellers Table
CREATE TABLE Sellers (
    SellerID VARCHAR(50) PRIMARY KEY,
    ZipCode VARCHAR(10) NOT NULL,
    City VARCHAR(255) NOT NULL,
    State VARCHAR(100) NOT NULL
);

-- Order Items Table
CREATE TABLE Order_Items (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID VARCHAR(50),
    ProductID VARCHAR(50),
    SellerID VARCHAR(50),
    ShippingLimitDate DATETIME,
    Price DECIMAL(10,2),
    FreightValue DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SellerID) REFERENCES Sellers(SellerID)
);

-- Payments Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID VARCHAR(50),
    PaymentSequential INT,
    PaymentType VARCHAR(50) CHECK (PaymentType IN ('Credit Card', 'Debit Card', 'Boleto', 'Voucher')),
    PaymentInstallments INT,
    PaymentValue DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Reviews Table
CREATE TABLE Reviews (
    ReviewID VARCHAR(50) PRIMARY KEY,
    OrderID VARCHAR(50),
    ReviewScore TINYINT(1) CHECK (ReviewScore BETWEEN 1 AND 5),
    ReviewCommentTitle VARCHAR(255),
    ReviewCommentMessage TEXT,
    ReviewCreationDate DATETIME,
    ReviewAnswerTimestamp DATETIME,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Geolocation Table
CREATE TABLE Geolocation (
    GeolocationID INT PRIMARY KEY AUTO_INCREMENT,
    ZipCodePrefix VARCHAR(10) NOT NULL,
    Latitude DECIMAL(9,6) NOT NULL,
    Longitude DECIMAL(9,6) NOT NULL,
    City VARCHAR(255) NOT NULL,
    State VARCHAR(100) NOT NULL
);

-- Show Databases and Tables
SHOW DATABASES;
SHOW TABLES;

-- Describe Tables
DESCRIBE Customers;
DESCRIBE Orders;
DESCRIBE Products;
DESCRIBE Sellers;
DESCRIBE Order_Items;
DESCRIBE Payments;
DESCRIBE Reviews;
DESCRIBE Geolocation;
DESCRIBE Product_Categories;

-- Select Data
SELECT * FROM Customers;
SELECT * FROM Geolocation;
SELECT * FROM Sellers;
