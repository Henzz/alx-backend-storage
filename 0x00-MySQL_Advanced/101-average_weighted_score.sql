-- Creates a stored procedure ComputeAverageWeightedScoreForUsers that
-- computes and stores the average weighted score for all students.
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers;
DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    -- Update average scores directly using subqueries
    UPDATE users
    SET average_score = (
        SELECT IFNULL(SUM(c.score * p.weight), 0) / NULLIF(SUM(p.weight), 0)
        FROM corrections c
        INNER JOIN projects p ON c.project_id = p.id
        WHERE c.user_id = users.id
    );
END //

DELIMITER ;