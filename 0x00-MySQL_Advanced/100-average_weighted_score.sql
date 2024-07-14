-- Script that creates a stored procedure ComputeAverageWeightedScoreForUser
DELIMITER $$
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(
	    IN user_id INT
)
BEGIN
	DECLARE total_weighted_score FLOAT DEFAULT 0;
	DECLARE total_weight INT DEFAULT 0;

	-- Calculate the total weighted score and total weight for the user
	SELECT SUM(c.score * p.weight) AS total_weighted_score, 
		SUM(p.weight) AS total_weight
	INTO total_weighted_score, total_weight
	FROM corrections c
	JOIN projects p ON c.project_id = p.id
	WHERE c.user_id = user_id;

	-- Calculate the average weighted score and update the user's record
	UPDATE users u
	SET u.average_score = IF(total_weight > 0, total_weighted_score / total_weight, 0)
	WHERE u.id = user_id;
END$$

DELIMITER ;
