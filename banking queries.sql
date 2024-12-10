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