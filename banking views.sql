/* implement a view for loan summary*/
CREATE VIEW CustomerLoanSummary AS
SELECT c.name, l.loan_type, l.loan_amount, l.status
FROM Customers c
JOIN Loans l ON c.customer_id = l.customer_id;