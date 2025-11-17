-- ============================================================
-- STRUCTURE SECTION Q1-15: Sentence Completion
-- ============================================================
-- These questions test ability to complete sentences correctly
-- Format: Full sentence with _____ blank, 4 options to choose from
-- Run this AFTER add_passage_text.sql
-- ============================================================

-- Q1: Sentence Completion
UPDATE questions 
SET question_text = 'The company''s new policy _____ all employees to work from home twice a week.'
WHERE section = 'structure' AND question_number = 1;

-- Q2: Sentence Completion
UPDATE questions 
SET question_text = 'Despite _____ warnings from the government, many tourists still visited the area.'
WHERE section = 'structure' AND question_number = 2;

-- Q3: Sentence Completion
UPDATE questions 
SET question_text = 'The scientists discovered that the ancient artifact _____ over 3,000 years old.'
WHERE section = 'structure' AND question_number = 3;

-- Q4: Sentence Completion
UPDATE questions 
SET question_text = 'Not until the 19th century _____ the importance of hygiene in medicine.'
WHERE section = 'structure' AND question_number = 4;

-- Q5: Sentence Completion
UPDATE questions 
SET question_text = 'The committee decided to postpone the meeting _____ the chairman could attend.'
WHERE section = 'structure' AND question_number = 5;

-- Q6: Sentence Completion
UPDATE questions 
SET question_text = 'Students _____ to submit their assignments by Friday will receive a penalty.'
WHERE section = 'structure' AND question_number = 6;

-- Q7: Sentence Completion
UPDATE questions 
SET question_text = 'The museum, _____ houses rare paintings, attracts thousands of visitors annually.'
WHERE section = 'structure' AND question_number = 7;

-- Q8: Sentence Completion
UPDATE questions 
SET question_text = 'Had the weather been better, we _____ to the beach for our vacation.'
WHERE section = 'structure' AND question_number = 8;

-- Q9: Sentence Completion
UPDATE questions 
SET question_text = 'The manager suggested _____ the project deadline by two weeks.'
WHERE section = 'structure' AND question_number = 9;

-- Q10: Sentence Completion
UPDATE questions 
SET question_text = 'Research shows that regular exercise, _____ with a balanced diet, improves health.'
WHERE section = 'structure' AND question_number = 10;

-- Q11: Sentence Completion
UPDATE questions 
SET question_text = 'The architect designed a building _____ could withstand earthquakes.'
WHERE section = 'structure' AND question_number = 11;

-- Q12: Sentence Completion
UPDATE questions 
SET question_text = '_____ the heavy rain, the concert was held as scheduled.'
WHERE section = 'structure' AND question_number = 12;

-- Q13: Sentence Completion
UPDATE questions 
SET question_text = 'The professor explained the theory in _____ way that everyone understood it.'
WHERE section = 'structure' AND question_number = 13;

-- Q14: Sentence Completion
UPDATE questions 
SET question_text = 'By the time the rescue team arrived, the survivors _____ for three days.'
WHERE section = 'structure' AND question_number = 14;

-- Q15: Sentence Completion
UPDATE questions 
SET question_text = 'The company''s profits have increased significantly, _____ to expanded operations.'
WHERE section = 'structure' AND question_number = 15;

-- ============================================================
-- VERIFICATION QUERY
-- Run this to check if updates were successful:
-- SELECT question_number, LEFT(question_text, 80) as question_preview
-- FROM questions 
-- WHERE section = 'structure' AND question_number BETWEEN 1 AND 15
-- ORDER BY question_number;
-- ============================================================
