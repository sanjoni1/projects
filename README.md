# **Banking System Database**
## Overview
This project implements a robust relational database system for a banking application. It manages essential banking operations such as customer details, account management, and transaction handling. The system is designed to ensure data integrity, scalability, and optimized performance for real-world use cases.
## Objective
The project aims to:
- Design a relational database schema to manage customers, accounts, and transactions.
- Implement key functionalities such as deposits, withdrawals, and balance updates using SQL triggers and procedures.
- Provide a scalable foundation for modern banking applications.
## Features
- *Customer Management:*
	- Stores customer details (name, contact, address).
	- Tracks unique customer IDs for identification.
- *Account Management:*
	- Maintains account details, including type (savings/current), balance, and associated customer.
	- Supports multiple accounts per customer.
- *Transaction Handling:*
	- Records all deposits and withdrawals.
	- Automatically updates account balances using SQL triggers.
- *Loan Management:*
  - Stores loan information of each customer including purpose, amount and interest rate.
  - Provides loan summary with views. 
- *Data Integrity:*
	- Enforces relationships between customers, accounts, and transactions using foreign keys.
	- Prevents invalid operations (e.g., overdrafts) through validation logic.
## Database Design
![Screenshot (103)](https://github.com/user-attachments/assets/911c09f2-4da6-4ac5-b406-a4ddea0d205d)
## Queries
```
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
```
## Procedure
```
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
```
## Triggers
```
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
```
## Views
```
/* implement a view for loan summary*/
CREATE VIEW CustomerLoanSummary AS
SELECT c.name, l.loan_type, l.loan_amount, l.status
FROM Customers c
JOIN Loans l ON c.customer_id = l.customer_id;
```
## Tools Used
- *Database Management System:* MySQL 
- *Development Environment:* MySQL Workbench
## Future Enhancements
- Introduce multi-currency support for international banking.
- Integrate a front-end interface using Python/Flask or a modern web framework.
## Author
Sanjoni Jain

Electrical Engineering Student, NSUT
