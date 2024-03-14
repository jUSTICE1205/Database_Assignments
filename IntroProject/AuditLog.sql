/*
 * Name :Clavan Dsouza
 * Course : DataBase 2
 * Date : 03/03/2024
 */

USE TRAIN_BOOKING_SYSTEM
GO

DROP TABLE IF EXISTS CustomersAuditLog;
GO

CREATE TABLE CustomersAuditLog (
    customerAuditID INTEGER Identity (1,1) PRIMARY KEY,
    modifiedBy NVARCHAR(50) NOT NULL,
    modifiedDate DATETIME NOT NULL,
    operationType NVARCHAR(10) NOT NULL,
    first_name NVARCHAR(30) NOT NULL,
    last_name NVARCHAR(30) NOT NULL,
    gender NVARCHAR(10) NOT NULL,
    phone NVARCHAR(16)NOT NULL,
    addresses NVARCHAR(30) NOT NULL,
    city_name NVARCHAR(20) NOT NULL,
	state_name NVARCHAR(20) NOT NULL
);
GO

/* 
 * Clavan Dsouza
 * March 3, 2024
 * trigger when insert ,update and deleted from the customer
 */
CREATE OR ALTER TRIGGER trigger_CustomerAuditLog ON Customer
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @operation_type NVARCHAR(10),
            @modifiedBy NVARCHAR(50) = SUSER_SNAME(),
            @modifiedDate DATETIME = GETDATE();

    -- Handle inserted rows
    INSERT INTO CustomersAuditLog (modifiedBy, modifiedDate, operationType, first_name, last_name, gender, phone, addresses, city_name, state_name)
    SELECT @modifiedBy, @modifiedDate, 'INSERT', i.first_name, i.last_name, i.gender,i.phone, i.addresses, i.city_name, i.state_name
    FROM inserted i
    WHERE NOT EXISTS (SELECT 1 FROM deleted);
   
    -- Handle deleted rows
    INSERT INTO CustomersAuditLog (modifiedBy, modifiedDate, operationType, first_name, last_name, gender, phone,addresses, city_name, state_name)
    SELECT @modifiedBy, @modifiedDate, 'DELETE', d.first_name, d.last_name, d.gender,d.phone, d.addresses, d.city_name, d.state_name
    FROM deleted d
    WHERE NOT EXISTS (SELECT 1 FROM inserted);

    -- Handle updated rows
    INSERT INTO CustomersAuditLog (modifiedBy, modifiedDate, operationType, first_name, last_name, gender,phone, addresses, city_name, state_name)
    SELECT @modifiedBy, @modifiedDate, 'UPDATE', i.first_name, i.last_name, i.gender, i.phone,i.addresses, i.city_name, i.state_name
    FROM inserted i
    INNER JOIN deleted d ON i.cust_id = d.cust_id;
END;
GO


-- Insert 4 new customers
INSERT INTO Customer (cust_id, first_name, last_name, gender, phone, addresses, city_name, state_name)
VALUES
(123432113, 'Jen', 'Irving', 'F', '111-111-1111', '111 Main St', 'Winnipeg', 'Manitoba'),
(12343222326, 'Gene', 'Simons', 'M', '222-222-2222', '222 Main St', 'Winnipeg', 'Manitoba'),
(1234323332, 'Sidney', 'Mark', 'F', '333-333-3333', '333 Main St', 'Winnipeg', 'Manitoba'),
(1234324423, 'Prescot', 'Mandy', 'M', '444-444-4444', '444 Main St', 'Winnipeg', 'Manitoba');
GO

SELECT * FROM CustomersAuditLog;

-- Update Jen Irving to Clavan Irving
UPDATE Customer SET first_name = 'test' WHERE cust_id = 1234323332;
GO

SELECT * FROM CustomersAuditLog;

DELETE FROM Customer WHERE cust_id = 1234324423;
GO

SELECT * FROM CustomersAuditLog;