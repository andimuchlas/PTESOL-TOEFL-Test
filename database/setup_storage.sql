-- Setup Supabase Storage untuk PTESOL Audio Files
-- Run this in Supabase SQL Editor

-- 1. Create storage bucket (jalankan ini atau buat via Dashboard)
INSERT INTO storage.buckets (id, name, public)
VALUES ('ptesol-audio', 'ptesol-audio', true)
ON CONFLICT (id) DO NOTHING;

-- 2. Set bucket policies untuk public access
CREATE POLICY "Public Access for Audio"
ON storage.objects FOR SELECT
USING (bucket_id = 'ptesol-audio');

CREATE POLICY "Authenticated users can upload audio"
ON storage.objects FOR INSERT
WITH CHECK (bucket_id = 'ptesol-audio' AND auth.role() = 'authenticated');

-- 3. Template SQL untuk update audio URLs setelah upload
-- Ganti YOUR_SUPABASE_URL dengan URL project Anda
-- Format: https://PROJECT_REF.supabase.co/storage/v1/object/public/ptesol-audio/FILENAME.wav

-- Example untuk update 1 soal:
-- UPDATE questions 
-- SET audio_url = 'https://yuzxvbhcozrjwejmbqmy.supabase.co/storage/v1/object/public/ptesol-audio/listening_001_part1.wav'
-- WHERE section = 'listening' AND question_number = 1;

-- Untuk batch update semua 200 soal, gunakan script di bawah:
-- (Generate otomatis dari script Python setelah upload)
