# PTESOL - Pelatihan Tes Bahasa Inggris Standar Online

![Next.js](https://img.shields.io/badge/Next.js-14-black) ![TypeScript](https://img.shields.io/badge/TypeScript-5-blue) ![Supabase](https://img.shields.io/badge/Supabase-PostgreSQL-green)

Aplikasi web untuk tes kemampuan bahasa Inggris yang dikembangkan oleh Balai Bahasa Universitas Pendidikan Indonesia (UPI). PTESOL adalah tes prediksi TOEFL dengan format mirip TOEFL ITP.

## 🎯 Fitur Utama

- ✅ **No Authentication** - Cukup input nama untuk mulai tes
- 🎲 **Random Questions** - Soal diacak dari bank soal database
- ⏱️ **Timer Per Section** - 35 min Listening, 25 min Structure, 55 min Reading
- 📊 **Auto Scoring** - Perhitungan skor otomatis dengan formula PTESOL
- 🏆 **Public Leaderboard** - Ranking real-time untuk semua peserta
- 📱 **Full Responsive** - Optimal di mobile & desktop

## 📋 Format Tes

**3 Sections - 140 Questions Total**

1. **Listening Comprehension** (50 soal, 35 menit)
2. **Structure and Written Expression** (40 soal, 25 menit)
3. **Reading Comprehension** (50 soal, 55 menit)

**Score Range: 217-677**

## 🚀 Quick Start

### 1. Install Dependencies
```bash
npm install
```

### 2. Setup Environment Variables
Create `.env.local`:
```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 3. Setup Database
Copy dan run SQL dari `database/schema.sql` di Supabase SQL Editor

### 4. Run Development Server
```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000)

## 📁 Project Structure

```
ptesol/
├── app/
│   ├── actions.ts              # Server actions
│   ├── page.tsx                # Landing page
│   ├── test/[sessionId]/       # Test interface
│   ├── result/[resultId]/      # Result page
│   └── leaderboard/            # Leaderboard
├── lib/
│   ├── supabase.ts             # Supabase client
│   ├── store.ts                # State management
│   └── utils.ts                # Utilities
└── database/
    └── schema.sql              # Database schema
```

## 📊 Database Schema

### Tables
- **questions** - Bank soal (section, question_text, options, correct_answer)
- **test_results** - Hasil tes (participant_name, scores, answers)

### Functions
- `get_random_questions(section, limit)` - Random soal per section
- `calculate_ptesol_score(l, s, r)` - Hitung total score

## 🎨 Tech Stack

- **Frontend**: Next.js 14 (App Router), TypeScript, Tailwind CSS
- **State**: Zustand (with persist)
- **Database**: Supabase (PostgreSQL)
- **Icons**: Lucide React
- **Date**: date-fns

## 📝 How to Add Questions

Via Supabase Table Editor atau SQL:

```sql
INSERT INTO questions (section, question_number, question_text, 
  option_a, option_b, option_c, option_d, correct_answer) 
VALUES ('reading', 1, 'Question text?', 'A', 'B', 'C', 'D', 'a');
```

## 🎯 Score Calculation

```
Section Score = 31 + (Correct/Total × 37)
Total Score = (L + S + R) × 10 / 3
Range: 217-677
```

## 🚀 Deploy to Vercel

1. Push to GitHub
2. Import di Vercel
3. Add environment variables
4. Deploy!

## 📄 License

MIT License

---

**© 2025 PTESOL - Balai Bahasa UPI**
