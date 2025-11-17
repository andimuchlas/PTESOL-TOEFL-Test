import { createClient } from '@supabase/supabase-js'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

// Types
export type Section = 'listening' | 'structure' | 'reading'

export interface Question {
  id: string
  section: Section
  part: number | null
  question_number: number
  question_text: string
  audio_url: string | null
  option_a: string
  option_b: string
  option_c: string
  option_d: string
  correct_answer: 'a' | 'b' | 'c' | 'd'
  created_at: string
}

export interface TestResult {
  id: string
  participant_name: string
  listening_correct: number
  structure_correct: number
  reading_correct: number
  total_score: number
  duration_minutes: number
  questions_used: string[]
  answers: Record<string, string>
  completed_at: string
  created_at: string
}

export interface LeaderboardEntry {
  id: string
  participant_name: string
  total_score: number
  completed_at: string
  rank?: number
}
