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