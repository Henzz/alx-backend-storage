-- Create the ComputeverageScoreForUser stored procedure
DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser (IN user_id INT)
BEGIN
    DECLARE total_score INT DEFAULT 0;
    DECLARE projects_count INT DEFAULT 0;

    SELECT SUM(score), COUNT(*)
    INTO total_score, projects_count
    FROM corrections
    WHERE user_id = user_id;

    UPDATE users
    SET average_score = IF(projects_count = 0, 0, total_score / projects_count)
    WHERE id = user_id;
END //

DELIMITER ;