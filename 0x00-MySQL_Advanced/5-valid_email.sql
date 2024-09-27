-- Create a trigger to reset the valid_email attribute when the email has been changed
DROP TRIGGER IF EXISTS validate_email
DELIMITER //

CREATE TRIGGER valid_email
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
	IF OLD.email != NEW.email THEN
		SET NEW.valid_email = 0;
	ELSE
		SET NEW.valid_email = NEW.valid_email;
	END IF;
END

//

DELIMITER;
