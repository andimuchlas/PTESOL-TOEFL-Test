-- PTESOL Database Schema
-- Run this SQL in your Supabase SQL Editor

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Questions Table
CREATE TABLE IF NOT EXISTS questions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  section TEXT NOT NULL CHECK (section IN ('listening', 'structure', 'reading')),
  part INTEGER, -- For listening: 1, 2, 3; NULL for others
  question_number INTEGER NOT NULL,
  question_text TEXT NOT NULL,
  passage_text TEXT, -- For reading section - full passage text
  audio_url TEXT, -- For listening section
  option_a TEXT NOT NULL,
  option_b TEXT NOT NULL,
  option_c TEXT NOT NULL,
  option_d TEXT NOT NULL,
  correct_answer TEXT NOT NULL CHECK (correct_answer IN ('a', 'b', 'c', 'd')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Test Results Table
CREATE TABLE IF NOT EXISTS test_results (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  participant_name TEXT NOT NULL,
  listening_correct INTEGER NOT NULL DEFAULT 0,
  structure_correct INTEGER NOT NULL DEFAULT 0,
  reading_correct INTEGER NOT NULL DEFAULT 0,
  total_score INTEGER NOT NULL, -- 217-677 range
  duration_minutes INTEGER NOT NULL,
  questions_used JSONB NOT NULL, -- Array of question IDs
  answers JSONB NOT NULL, -- User's answers {question_id: answer}
  detailed_results JSONB, -- Detailed analysis per question {question_id: {correct: bool, user_answer: string, correct_answer: string}}
  completed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for better performance
CREATE INDEX idx_questions_section ON questions(section);
CREATE INDEX idx_test_results_score ON test_results(total_score DESC);
CREATE INDEX idx_test_results_completed ON test_results(completed_at DESC);
CREATE INDEX idx_test_results_name ON test_results(participant_name);

-- Function to get random questions by section
CREATE OR REPLACE FUNCTION get_random_questions(
  p_section TEXT,
  p_limit INTEGER
)
RETURNS SETOF questions
LANGUAGE sql
STABLE
AS $$
  SELECT *
  FROM questions
  WHERE section = p_section
  ORDER BY RANDOM()
  LIMIT p_limit;
$$;

-- Function to calculate PTESOL score
-- Formula: (Section I + Section II + Section III) × 10 / 3
-- Each section is converted to a scaled score first
CREATE OR REPLACE FUNCTION calculate_ptesol_score(
  p_listening_correct INTEGER,
  p_structure_correct INTEGER,
  p_reading_correct INTEGER
)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
  v_listening_score INTEGER;
  v_structure_score INTEGER;
  v_reading_score INTEGER;
  v_total_score INTEGER;
BEGIN
  -- Convert raw scores to scaled scores (31-68 range like TOEFL)
  -- Listening: 50 questions
  v_listening_score := 31 + ((p_listening_correct::FLOAT / 50) * 37)::INTEGER;
  
  -- Structure: 40 questions
  v_structure_score := 31 + ((p_structure_correct::FLOAT / 40) * 37)::INTEGER;
  
  -- Reading: 50 questions
  v_reading_score := 31 + ((p_reading_correct::FLOAT / 50) * 37)::INTEGER;
  
  -- Calculate total score
  v_total_score := ((v_listening_score + v_structure_score + v_reading_score) * 10 / 3)::INTEGER;
  
  -- Ensure score is within valid range (217-677)
  v_total_score := GREATEST(217, LEAST(677, v_total_score));
  
  RETURN v_total_score;
END;
$$;

-- View for leaderboard (top 100)
CREATE OR REPLACE VIEW leaderboard AS
SELECT 
  id,
  participant_name,
  total_score,
  completed_at,
  ROW_NUMBER() OVER (ORDER BY total_score DESC, completed_at ASC) as rank
FROM test_results
ORDER BY total_score DESC, completed_at ASC
LIMIT 100;

-- Enable Row Level Security (RLS) - but allow public read access
ALTER TABLE questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE test_results ENABLE ROW LEVEL SECURITY;

-- Policy: Anyone can read questions
CREATE POLICY "Public questions read access" ON questions
  FOR SELECT USING (true);

-- Policy: Anyone can insert test results
CREATE POLICY "Public test results insert access" ON test_results
  FOR INSERT WITH CHECK (true);

-- Policy: Anyone can read test results
CREATE POLICY "Public test results read access" ON test_results
  FOR SELECT USING (true);

-- Sample data insert (for testing)
-- You can run this to add some sample questions

INSERT INTO questions (section, part, question_number, question_text, option_a, option_b, option_c, option_d, correct_answer) VALUES
-- Listening samples
('listening', 1, 1, 'What is the main topic of the conversation?', 'A university course', 'A job interview', 'A research project', 'A campus event', 'c'),
('listening', 1, 2, 'Where does this conversation take place?', 'In a library', 'In a cafeteria', 'In a classroom', 'In an office', 'a'),

-- Structure samples
('structure', NULL, 1, 'The teacher asked the students _____ their homework on time.', 'to submit', 'submitting', 'submit', 'submitted', 'a'),
('structure', NULL, 2, '_____ the weather was bad, we decided to go hiking.', 'Despite', 'Although', 'Because', 'In spite', 'b'),

-- Reading samples
('reading', NULL, 1, 'According to the passage, what is the primary cause of climate change?', 'Natural disasters', 'Human activities', 'Solar radiation', 'Ocean currents', 'b'),
('reading', NULL, 2, 'The word "significant" in line 5 is closest in meaning to', 'important', 'difficult', 'unusual', 'expensive', 'a');
