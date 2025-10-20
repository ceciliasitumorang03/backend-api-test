-- Cek tabel 'transactions'
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'transactions' AND xtype = 'U')
BEGIN
    CREATE TABLE transactions (
        id BIGINT IDENTITY(1,1) PRIMARY KEY,
        productID VARCHAR(50) NOT NULL,
        productName VARCHAR(100) NOT NULL,
        amount DECIMAL(10,2) NOT NULL,
        customerName VARCHAR(100) NOT NULL,
        status INT NOT NULL DEFAULT 0,
        transactionDate DATETIME NOT NULL,
        createdBy VARCHAR(100),
        createdOn DATETIME
    );
END
GO

-- Data
INSERT INTO transactions (productID, productName, amount, customerName, status, transactionDate, createdBy, createdOn)
VALUES
('10001', 'Test 1', 1000.00, 'abc', 0, '2022-07-10 11:14:52', 'abc', '2022-07-10 11:14:52'),
('10002', 'Test 2', 2000.00, 'abc', 0, '2022-07-11 13:14:52', 'abc', '2022-07-10 13:14:52'),
('10001', 'Test 1', 1000.00, 'abc', 0, '2022-08-10 12:14:52', 'abc', '2022-07-10 12:14:52'),
('10002', 'Test 2', 1000.00, 'abc', 1, '2022-08-10 13:10:52', 'abc', '2022-07-10 13:10:52'),
('10001', 'Test 1', 1000.00, 'abc', 0, '2022-08-10 13:11:52', 'abc', '2022-07-10 13:11:52'),
('10002', 'Test 2', 2000.00, 'abc', 0, '2022-08-12 13:14:52', 'abc', '2022-07-10 13:14:52'),
('10001', 'Test 1', 1000.00, 'abc', 0, '2022-08-12 14:11:52', 'abc', '2022-07-10 14:11:52'),
('10002', 'Test 2', 1000.00, 'abc', 1, '2022-09-13 11:14:52', 'abc', '2022-07-10 11:14:52'),
('10001', 'Test 1', 1000.00, 'abc', 0, '2022-09-13 13:14:52', 'abc', '2022-07-10 13:14:52'),
('10002', 'Test 2', 2000.00, 'abc', 0, '2022-09-14 09:11:52', 'abc', '2022-07-10 09:11:52'),
('10001', 'Test 1', 1000.00, 'abc', 0, '2022-09-14 10:14:52', 'abc', '2022-07-10 10:14:52'),
('10002', 'Test 2', 1000.00, 'abc', 1, '2022-08-15 13:14:52', 'abc', '2022-07-10 13:14:52');
GO

-- Filter transaksi berhasil (status = 1) bulan tertentu
SELECT 
    id,
    productID,
    productName,
    amount,
    customerName,
    status,
    transactionDate
FROM transactions
WHERE status = 1
  AND MONTH(transactionDate) = 8
  AND YEAR(transactionDate) = 2022
ORDER BY transactionDate;
GO

-- Total transaksi per produk
SELECT 
    productName,
    COUNT(*) AS totalTransactions,
    SUM(amount) AS totalAmount
FROM transactions
GROUP BY productName
ORDER BY totalAmount DESC;
GO

-- Total transaksi per bulan
SELECT 
    YEAR(transactionDate) AS [Year],
    MONTH(transactionDate) AS [Month],
    COUNT(*) AS totalTransactions,
    SUM(amount) AS totalAmount
FROM transactions
GROUP BY YEAR(transactionDate), MONTH(transactionDate)
ORDER BY [Year], [Month];
GO

-- Procedure untuk menambah transaksi baru
IF OBJECT_ID('sp_AddTransaction', 'P') IS NOT NULL
    DROP PROCEDURE sp_AddTransaction;
GO

CREATE PROCEDURE sp_AddTransaction
    @productID VARCHAR(50),
    @productName VARCHAR(100),
    @amount DECIMAL(10,2),
    @customerName VARCHAR(100),
    @status INT,
    @transactionDate DATETIME,
    @createdBy VARCHAR(100)
AS
BEGIN
    INSERT INTO transactions (productID, productName, amount, customerName, status, transactionDate, createdBy, createdOn)
    VALUES (@productID, @productName, @amount, @customerName, @status, @transactionDate, @createdBy, GETDATE());
END
GO

-- Contoh penggunaan
EXEC sp_AddTransaction 
    @productID = '10003',
    @productName = 'Test 3',
    @amount = 1500.00,
    @customerName = 'xyz',
    @status = 0,
    @transactionDate = '2022-10-20 10:00:00',
    @createdBy = 'xyz';
GO