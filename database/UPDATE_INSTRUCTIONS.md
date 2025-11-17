# Database Update Instructions

## ⚠️ IMPORTANT: Run these SQL files in Supabase SQL Editor

After deploying the latest changes, you need to update your Supabase database:

### Step 1: Add passage_text column
```sql
-- Run: database/add_passage_text.sql
```
This adds the `passage_text` column to the questions table.

### Step 2: Update reading questions with passages
```sql
-- Run: database/update_reading_passages.sql
```
This populates the reading questions (1-50) with 5 complete passage texts:
- **Passage 1** (Q1-10): Coral Reefs & Marine Biology
- **Passage 2** (Q11-20): Industrial Revolution & History
- **Passage 3** (Q21-30): Climate Change & Environment
- **Passage 4** (Q31-40): Memory & Learning Psychology
- **Passage 5** (Q41-50): Renaissance Art & Culture

### What's New?

#### 1. Reading Section 📚
- **Full passage texts** now display above questions
- Questions like "According to the passage..." now have proper context
- No more temporary warnings!

#### 2. Structure Section ✍️
- **Error Identification** (Q16-40): Options are now **underlined** in blue
- **Sentence Completion** (Q1-15): Normal text (no underline)
- Clear visual distinction between the two question types

### Testing
After running the SQL updates:
1. Start a new test
2. Navigate to Reading section → You should see passage text above questions
3. Navigate to Structure section → Questions 16-40 should have underlined options
4. Navigate to Listening section → Should show Part A/B/C badges and audio

### Rollback (if needed)
```sql
-- To remove passage_text column
ALTER TABLE questions DROP COLUMN IF EXISTS passage_text;
```
