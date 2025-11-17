-- ============================================
-- PTESOL COMPLETE DATABASE SETUP
-- ============================================
-- Run this entire file in Supabase SQL Editor
-- This will DELETE all existing questions and INSERT fresh data

-- Step 1: Clear ALL existing questions
DELETE FROM questions;

-- Step 2: Reset any sequences (optional, for clean slate)
-- ALTER SEQUENCE IF EXISTS questions_id_seq RESTART WITH 1;

-- ============================================
-- IMPORTANT: After running this file, 
-- Copy and paste the entire content of:
-- complete_insert_all.sql
-- ============================================

-- Expected final result:
-- Total questions: 550
--   - Listening: 200 (with audio URLs)
--   - Structure: 150 (no audio)
--   - Reading: 200 (no audio)

-- To verify after running:
-- SELECT section, COUNT(*) as count FROM questions GROUP BY section ORDER BY section;
-- SELECT COUNT(*) as listening_with_audio FROM questions WHERE section = 'listening' AND audio_url IS NOT NULL;
