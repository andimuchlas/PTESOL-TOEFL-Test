# Database Setup Guide

## Step 1: Access Supabase SQL Editor

1. Login to your Supabase dashboard
2. Select your project
3. Go to **SQL Editor** (left sidebar)
4. Click **New Query**

## Step 2: Run Schema SQL

Copy the entire content from `database/schema.sql` and paste it into the SQL Editor, then click **Run**.

This will create:
- ✅ `questions` table
- ✅ `test_results` table
- ✅ Indexes for performance
- ✅ Functions: `get_random_questions()`, `calculate_ptesol_score()`
- ✅ Row Level Security policies
- ✅ Sample data (6 questions)

## Step 3: Verify Tables Created

Go to **Table Editor** and check:
- `questions` table should have 6 sample rows
- `test_results` table should be empty

## Step 4: Add More Questions

### Option A: Via Table Editor (Recommended for beginners)

1. Go to **Table Editor** → `questions`
2. Click **Insert** → **Insert row**
3. Fill in the fields:
   - `section`: listening/structure/reading
   - `part`: 1, 2, or 3 (only for listening, otherwise NULL)
   - `question_number`: sequential number
   - `question_text`: The question
   - `option_a`, `option_b`, `option_c`, `option_d`: Answer choices
   - `correct_answer`: a, b, c, or d
   - `audio_url`: URL to audio file (optional, for listening)
4. Click **Save**

### Option B: Via SQL (For bulk insert)

```sql
INSERT INTO questions (section, part, question_number, question_text, option_a, option_b, option_c, option_d, correct_answer) VALUES
-- Listening questions
('listening', 1, 3, 'What does the man suggest?', 'Going to the library', 'Studying together', 'Taking a break', 'Postponing the exam', 'b'),
('listening', 1, 4, 'Where is this conversation taking place?', 'At a restaurant', 'At a bookstore', 'At a university', 'At a hospital', 'c'),

-- Structure questions
('structure', NULL, 3, 'The professor _____ the lecture when the fire alarm rang.', 'gives', 'was giving', 'has given', 'had given', 'b'),
('structure', NULL, 4, '_____ his busy schedule, he always finds time for his family.', 'Although', 'Despite', 'In spite', 'Even', 'b'),

-- Reading questions
('reading', NULL, 3, 'The word "elaborate" in line 10 is closest in meaning to', 'simple', 'detailed', 'expensive', 'difficult', 'b'),
('reading', NULL, 4, 'What can be inferred from the passage?', 'The author agrees', 'The author disagrees', 'The author is neutral', 'The author is confused', 'a');
```

### Option C: Import from CSV

1. Prepare CSV file with columns:
   ```
   section,part,question_number,question_text,option_a,option_b,option_c,option_d,correct_answer,audio_url
   ```
2. Go to **Table Editor** → `questions`
3. Click **Import data** → Upload CSV
4. Map columns and import

## Step 5: Recommended Question Distribution

For optimal test experience:

| Section | Target Questions | Min Required |
|---------|------------------|--------------|
| Listening | 200+ | 50 |
| Structure | 150+ | 40 |
| Reading | 200+ | 50 |
| **Total** | **550+** | **140** |

Having more questions ensures better randomization!

## Step 6: Test the Setup

1. Run the app: `npm run dev`
2. Go to `http://localhost:3000`
3. Enter your name
4. Click **Start Test**
5. If you see questions → ✅ Success!

## Common Issues

### "Failed to fetch questions"
- **Cause**: Tables not created or RLS policies blocking access
- **Fix**: Re-run the schema.sql script

### "No questions available"
- **Cause**: Not enough questions in database
- **Fix**: Add at least 140 questions (50 listening, 40 structure, 50 reading)

### Questions not randomizing
- **Cause**: Same questions every time means small question pool
- **Fix**: Add more questions to the database

## Sample Question Format

### Listening Question
```sql
INSERT INTO questions (section, part, question_number, question_text, audio_url, option_a, option_b, option_c, option_d, correct_answer) VALUES
('listening', 1, 1, 'What is the main topic of the conversation?', 
 'https://yourdomain.com/audio/listening-1.mp3',
 'A campus event', 'A research project', 'A job interview', 'A class assignment', 'b');
```

### Structure Question
```sql
INSERT INTO questions (section, part, question_number, question_text, option_a, option_b, option_c, option_d, correct_answer) VALUES
('structure', NULL, 1, 'The committee _____ a decision by next week.',
 'will make', 'will have made', 'makes', 'is making', 'b');
```

### Reading Question
```sql
INSERT INTO questions (section, part, question_number, question_text, option_a, option_b, option_c, option_d, correct_answer) VALUES
('reading', NULL, 1, 'According to paragraph 2, what is the author''s main argument?',
 'Climate change is natural', 'Human activity causes climate change', 'Climate change is not real', 'More research is needed', 'b');
```

## Backup Your Data

To backup questions:
```sql
-- Export questions to JSON
SELECT json_agg(questions) FROM questions;
```

Copy the output and save as `backup.json`.

## Next Steps

After database setup:
1. ✅ Add minimum 140 questions (50/40/50)
2. ✅ Test the application
3. ✅ Add audio files for listening section (optional)
4. ✅ Deploy to production
5. ✅ Monitor test_results table for submissions

---

Need help? Check the main README.md or open an issue!
