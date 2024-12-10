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