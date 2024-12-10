CREATE DATABASE banking;
USE banking;
/* table customers */
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT,
    registration_date DATE
);
INSERT INTO customers (name, email, phone, address, registration_date)
VALUES 
('Alice Johnson', 'alice.johnson@example.com', '1234567890', '123 Main St', '2023-01-01'),
('Bob Smith', 'bob.smith@example.com', '9876543210', '456 Oak St', '2023-02-15');

/* table accounts */ 
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(15 , 2 ),
    branch_id INT,
    opened_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    FOREIGN KEY (branch_id) REFERENCES branches (branch_id)
);
INSERT INTO accounts (account_id, customer_id, account_type, balance, branch_id, opened_date)
VALUES
(1, 1, 'Savings', 10000.00, 1, '2023-01-01'), (2, 1, 'Checking', 1000.00, 1, '2023-01-01'), 
(3, 2, 'Savings', 5000.00, 2, '2023-02-15'), (4, 2, 'Checking', 500.00, 2, '2023-02-15'); 

/*table transactions*/
CREATE TABLE transactions (
	transaction_id INT PRIMARY KEY,
	account_id INT,
	transaction_type VARCHAR(20),
	amount DECIMAL(15 , 2 ),
	transaction_date DATE,
	remarks VARCHAR(500),
    FOREIGN KEY (account_id) REFERENCES accounts (account_id)
);
INSERT INTO transactions (transaction_id, account_id, transaction_type, amount, transaction_date, remarks)
VALUES
(1, 1, 'Deposit', 200.00, '2024-09-04', 'abcdefg'),
(2, 3, 'Withdrawal', 10.00, '2024-08-08', 'Food');

/* table loans*/
CREATE TABLE loans (
	loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_type VARCHAR(20),
    loan_amount DECIMAL(15,2),
    interest_rate DECIMAL(10, 2),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);
INSERT INTO loans (loan_id, customer_id, loan_type, loan_amount, interest_rate, start_date, end_date, status)
VALUES
(1, 1, 'Car', 30000.00, 5.00, '2023-02-02', '2028-02-02', 'Active'),
(2, 2, 'Personal', 5000.00, 4.50, '2023-03-15', '2023-09-15', 'Paid');

/*table branches*/
CREATE TABLE branches (
	branch_id INT PRIMARY KEY,
    branch_name VARCHAR(30),
    location VARCHAR(100)
);
INSERT INTO branches (branch_id, branch_name, location)
VALUES
(1, 'abc', 'Main St'), (2, 'efg', 'Oak St');

/*implement query to find total balance for customer*/
SELECT c.name, SUM(a.balance) AS total_balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
WHERE c.customer_id = 1
GROUP BY c.name;

/*implement query to find transaction history for an account*/
SELECT transaction_id, transaction_type, amount, transaction_date, remarks
FROM Transactions
WHERE account_id = 3
ORDER BY transaction_date DESC;

/*implement query to find active loan details*/
SELECT l.loan_id, c.name, l.loan_amount, l.interest_rate, l.status
FROM Loans l
JOIN Customers c ON l.customer_id = c.customer_id
WHERE l.status = 'Active';

/*implement query to find accounts opened in a branch*/
SELECT b.branch_name, COUNT(a.account_id) AS num_accounts
FROM Branches b
JOIN Accounts a ON b.branch_id = a.branch_id
WHERE b.branch_id = 2
GROUP BY b.branch_name;

/*implement feature to transfer funds between accounts*/
DELIMITER //
CREATE PROCEDURE TransferFunds (sender_id INT, receiver_id INT, amount DECIMAL(10,2))
BEGIN
    START TRANSACTION;
    UPDATE Accounts SET balance = balance - amount WHERE account_id = sender_id;
    UPDATE Accounts SET balance = balance + amount WHERE account_id = receiver_id;
    COMMIT;
END //
DELIMITER ;

/*implement trigger to auntomatically update balance after a transaction*/
DELIMITER //
CREATE TRIGGER UpdateBalance 
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    IF NEW.transaction_type = 'Deposit' THEN
        UPDATE Accounts 
        SET balance = balance + NEW.amount 
        WHERE account_id = NEW.account_id;
    ELSEIF NEW.transaction_type = 'Withdrawal' THEN
        UPDATE Accounts 
        SET balance = balance - NEW.amount 
        WHERE account_id = NEW.account_id;
    END IF;
END //
DELIMITER ;

/* implement a view for loan summary*/
CREATE VIEW CustomerLoanSummary AS
SELECT c.name, l.loan_type, l.loan_amount, l.status
FROM Customers c
JOIN Loans l ON c.customer_id = l.customer_id;

/*end of programme*/