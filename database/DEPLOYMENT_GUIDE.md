# 🚀 PTESOL Database Cleanup & Restructure Guide

## 📊 New Question Distribution

### Total Question Bank: 330 Questions
- **Listening:** 180 questions (unchanged)
- **Structure:** 75 questions (Q1-25 completion, Q26-75 error identification)
- **Reading:** 75 questions (15 passages, 5 questions each)

### Test Format: 100 Questions (randomly selected)
- **Listening:** 50 questions (from 180 pool)
- **Structure:** 25 questions (from 75 pool)
- **Reading:** 25 questions (from 75 pool)

## ⚠️ IMPORTANT: Backup First!

Before running any SQL:
```sql
-- Export current questions table
SELECT * FROM questions;
-- Save output as backup.sql
```

## 🔧 Single SQL File Deployment

Execute **ONE file** in Supabase SQL Editor:

### `cleanup_and_restructure.sql`

This file does everything in the correct order:
1. ✅ Deletes excess Listening questions (keeps only Q1-180)
2. ✅ Deletes excess Structure questions (keeps only Q1-75)
3. ✅ Deletes excess Reading questions (keeps only Q1-75)
4. ✅ Adds `passage_text` column if not exists
5. ✅ Updates Structure Q1-25 with completion format
6. ✅ Updates Structure Q26-75 with error identification (HTML underlines)
7. ✅ Updates Reading Q1-75 with 15 complete passages

**Execution Time:** ~30 seconds
**Total Operations:** 150 UPDATEs + 3 DELETEs

## 📋 What Changes:

### Structure Section (75 Questions)

**Q1-25: Sentence Completion**
```
Before: Random format, no consistency
After: "The company's new policy _____ all employees to work from home twice a week."
```

**Q26-75: Error Identification**
```
Before: Plain text without underlines
After: "A pharmacist <u>supplies</u> prescribed medications and <u>gives</u> information <u>to patients</u> about <u>theirs</u> use."
```

### Reading Section (75 Questions, 15 Passages)

**Passages:**
1. Coral Reefs (Q1-5)
2. Ancient Rome (Q6-10)
3. Climate Change (Q11-15)
4. Memory & Learning (Q16-20)
5. Renaissance Art (Q21-25)
6. Ocean Currents (Q26-30)
7. Photosynthesis (Q31-35)
8. Urban Planning (Q36-40)
9. Antibiotics (Q41-45)
10. Sleep Science (Q46-50)
11. Artificial Intelligence (Q51-55)
12. Volcanic Activity (Q56-60)
13. Renewable Energy (Q61-65)
14. Ancient Egypt (Q66-70)
15. Biodiversity (Q71-75)

## 📝 Step-by-Step Deployment

### Step 1: Open Supabase SQL Editor
1. Login to Supabase dashboard
2. Select your project
3. Go to **SQL Editor** → **New Query**

### Step 2: Run Cleanup SQL
```sql
-- Copy entire content from: database/cleanup_and_restructure.sql
-- Paste into SQL Editor
-- Click "Run"
-- Wait ~30 seconds
```

### Step 3: Verify Changes

**Check question counts:**
```sql
SELECT section, COUNT(*) as total 
FROM questions 
GROUP BY section 
ORDER BY section;
```

**Expected result:**
```
listening: 180
reading:   75
structure: 75
TOTAL:     330
```

**Check Structure formats:**
```sql
-- Verify completion (Q1-25)
SELECT question_number, LEFT(question_text, 60) 
FROM questions 
WHERE section = 'structure' AND question_number BETWEEN 1 AND 25
ORDER BY question_number
LIMIT 3;

-- Verify error identification (Q26-75)
SELECT question_number, LEFT(question_text, 80) 
FROM questions 
WHERE section = 'structure' AND question_number BETWEEN 26 AND 75
AND question_text LIKE '%<u>%'
ORDER BY question_number
LIMIT 3;
```

**Check Reading passages:**
```sql
SELECT 
  question_number,
  CASE WHEN passage_text IS NOT NULL THEN 'HAS PASSAGE' ELSE 'NO PASSAGE' END as status,
  LEFT(passage_text, 50) as passage_preview
FROM questions 
WHERE section = 'reading' 
AND question_number IN (1, 6, 16, 26, 36, 46, 56, 66, 71)
ORDER BY question_number;
```

### Step 4: Test Frontend

1. **Start dev server:**
   ```bash
   npm run dev
   ```

2. **Start new test:**
   - Enter name
   - Start test
   - Check: Should receive 50 listening + 25 structure + 25 reading = 100 questions

3. **Check Structure Section:**
   - Q1-25: Should show "Sentence Completion" with blanks
   - Q26-75 (if selected): Should show "Error Identification" with underlines visible

4. **Check Reading Section:**
   - Should display passage text above questions
   - Should show "Passage X (Questions Y-Z)" badge
   - Passage should change every 5 questions

5. **Complete Test:**
   - Submit answers
   - Should navigate to result page (not home)
   - Score calculation: 0 correct = 217 (minimum)

## 🎯 Frontend Updates (Already Applied)

### Constants Updated (`lib/utils.ts`):
```typescript
SECTION_QUESTIONS = {
  listening: 50,  // selected from 180 total
  structure: 25,  // selected from 75 total
  reading: 25,    // selected from 75 total
}
TOTAL_QUESTIONS = 100
```

### Score Calculation:
```typescript
// Now uses correct totals: 50, 25, 25
listeningScore = 31 + (listeningCorrect / 50) * 37
structureScore = 31 + (structureCorrect / 25) * 37
readingScore = 31 + (readingCorrect / 25) * 37
```

### Passage Mapping:
```typescript
// Updated to support 15 passages (Q1-5, Q6-10, ..., Q71-75)
getPassageNumber(questionNumber) → { passage: 1-15, range: 'X-Y' }
```

### Structure Instructions:
```typescript
// Updated threshold from 15 to 25
if (questionNumber <= 25) → "Sentence Completion"
else → "Error Identification"
```

## ✅ Benefits of New Structure

1. **Consistent Quality:**
   - All Structure questions properly formatted
   - All Reading questions have complete passages
   - No broken or incomplete questions

2. **Better Randomization:**
   - Larger pool (330 vs 140) ensures variety
   - Each test unique even with 100 questions

3. **Manageable Size:**
   - Reduced from 550 to 330 (40% reduction)
   - Easier to maintain and update
   - All questions properly structured

4. **Proper Formatting:**
   - Structure Q1-25: Completion with blanks
   - Structure Q26-75: Error ID with underlines
   - Reading Q1-75: 15 passages, 5 questions each

## 🐛 Common Issues & Solutions

### Issue: "Column passage_text does not exist"
**Solution:** The SQL file includes `ADD COLUMN IF NOT EXISTS`, so this should not occur. If it does, run separately:
```sql
ALTER TABLE questions ADD COLUMN IF NOT EXISTS passage_text TEXT;
```

### Issue: "Still seeing old questions"
**Solution:** Clear browser cache and reload. Or check if SQL executed successfully:
```sql
SELECT COUNT(*) FROM questions WHERE section = 'structure' AND question_number > 75;
-- Should return 0
```

### Issue: "Underlines not showing"
**Solution:** Verify HTML rendering in frontend. Check if dangerouslySetInnerHTML is used:
```tsx
<div dangerouslySetInnerHTML={{ __html: question_text }} />
```

### Issue: "Passages not displaying"
**Solution:** Verify passage_text column has data:
```sql
SELECT question_number, LENGTH(passage_text) 
FROM questions 
WHERE section = 'reading' 
ORDER BY question_number 
LIMIT 10;
```

## 📊 Verification Checklist

After deployment, verify:
- [ ] Total questions = 330 (180+75+75)
- [ ] Structure Q1-25 have _____ blanks
- [ ] Structure Q26-75 have <u> tags visible in database
- [ ] Reading Q1-75 all have passage_text
- [ ] Frontend shows 100 questions per test (50+25+25)
- [ ] Passage indicators show "Passage 1-15 (Questions X-Y)"
- [ ] Structure instructions switch at Q25 (not Q15)
- [ ] Score calculation: 0 correct = 217
- [ ] Result page displays after submit (not home redirect)

## 🔄 Rollback Procedure

If something goes wrong:

1. **Restore from backup:**
   ```sql
   -- Drop current table
   DROP TABLE questions CASCADE;
   
   -- Restore from backup.sql
   -- (paste your backup SQL here)
   ```

2. **Or re-run original schema:**
   ```sql
   -- Run: database/schema.sql
   ```

## 📞 Support

Files created:
- ✅ `database/cleanup_and_restructure.sql` - Main deployment file
- ✅ `database/DEPLOYMENT_GUIDE.md` - This guide
- ✅ `lib/utils.ts` - Updated constants and functions
- ✅ `app/test/[sessionId]/page.tsx` - Updated UI thresholds

**Ready to deploy! 🚀**
