-- This SQL script creates a view named 'need_meeting' that lists all students with a score under 80 (strict) and no last_meeting date or a last_meeting date more than a month ago.
CREATE VIEW need_meeting AS
SELECT name
FROM students
WHERE score < 80 AND (last_meeting IS NULL OR last_meeting < DATE_SUB(CURDATE(), INTERVAL 1 MONTH));
