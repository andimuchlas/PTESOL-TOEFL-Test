-- Add passage_text column for reading comprehension passages
-- Run this in Supabase SQL Editor

ALTER TABLE questions 
ADD COLUMN IF NOT EXISTS passage_text TEXT;

-- Add comment
COMMENT ON COLUMN questions.passage_text IS 'Full passage text for reading comprehension questions. NULL for listening and structure sections.';
