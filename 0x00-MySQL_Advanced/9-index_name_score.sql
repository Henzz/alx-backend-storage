-- Create the idx_name_first_score index on the first letter of the name column and the score column
CREATE INDEX idx_name_first_score ON names (LEFT(name, 1), score);