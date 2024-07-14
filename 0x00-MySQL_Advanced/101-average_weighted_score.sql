-- Script that creates a stored procedure ComputeAverageWeightedScoreForUsers
DELIMITER $$
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
	DECLARE user_id INT;
	DECLARE done INT DEFAULT FALSE;
	DECLARE cur CURSOR FOR SELECT id FROM users;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	OPEN cur;

	user_loop: LOOP
		FETCH cur INTO user_id;
		IF done THEN
			LEAVE user_loop;
		END IF;

		-- Call the ComputeAverageWeightedScoreForUser procedure for the current user
		CALL ComputeAverageWeightedScoreForUser(user_id);
	END LOOP user_loop;

	CLOSE cur;
END$$
DELIMITER ;
