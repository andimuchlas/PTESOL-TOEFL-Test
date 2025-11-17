-- RESET AND REPOPULATE ALL QUESTIONS
-- Run this in Supabase SQL Editor to fix section data

-- Step 1: Clear existing questions
DELETE FROM questions;

-- Step 2: Reset sequence (if any)
-- This ensures question IDs start fresh

-- Step 3: Insert all questions from all files
-- You need to manually copy-paste the INSERT statements from:
-- 1. insert_listening_questions.sql
-- 2. insert_listening_additional.sql
-- 3. insert_structure_questions.sql
-- 4. insert_structure_additional.sql
-- 5. insert_reading_questions.sql
-- 6. insert_reading_additional.sql

-- After running this, verify with:
SELECT section, COUNT(*) as count FROM questions GROUP BY section;

-- Expected result:
-- listening | 200
-- structure | 150
-- reading   | 200
