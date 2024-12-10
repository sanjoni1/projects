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
## Tools Used
- *Database Management System:* MySQL 
- *Development Environment:* MySQL Workbench
## Future Enhancements
- Introduce multi-currency support for international banking.
- Integrate a front-end interface using Python/Flask or a modern web framework.
## Author
Sanjoni Jain

Electrical Engineering Student, NSUT
