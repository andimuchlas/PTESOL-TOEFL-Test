# 🚀 PTESOL Full Database Restructure Guide

## ⚠️ IMPORTANT: Backup First!

Before running any SQL, backup your database:
```sql
-- Export current questions table
SELECT * FROM questions;
```

## 📋 What Will Change:

### 1. Structure Section (Error Identification Q16-40)
**Before:**
```
Question: A pharmacist supplies prescribed medications...
Options: supplies | gives | to patients | theirs
```

**After:**
```
Question: A pharmacist <u>supplies</u> prescribed medications and <u>gives</u> information <u>to patients</u> about <u>theirs</u> use.
Options: supplies | gives | to patients | theirs
```
✅ Underlines visible in question text
✅ User can identify which part is wrong

### 2. Reading Section (All 50 Questions)
**Before:**
- 5 passages, 10 questions each
- Some questions without proper context

**After:**
- 10 passages, 4-5 questions each
- Every question has relevant passage

**Passages:**
1. Coral Reefs (Q1-5)
2. Ancient Rome (Q6-10)
3. Climate Change (Q11-15)
4. Memory & Learning (Q16-20)
5. Renaissance Art (Q21-25)
6. Ocean Currents (Q26-29)
7. Photosynthesis (Q30-34)
8. Urban Planning (Q35-39)
9. Antibiotics (Q40-44)
10. Sleep Science (Q45-50)

## 🔧 Deployment Steps:

### Step 1: Run Structure Restructure
```sql
-- In Supabase SQL Editor, run:
-- File: database/restructure_structure_full.sql

-- This will update 25 questions (Q16-40)
-- Time: ~5 seconds
```

### Step 2: Run Reading Restructure
```sql
-- In Supabase SQL Editor, run:
-- File: database/restructure_reading_full.sql

-- This will update 50 questions (Q1-50) with new passages
-- Time: ~10 seconds
```

### Step 3: Verify Changes
1. Go to Supabase → Table Editor → questions
2. Check question_number 37 (Structure):
   - question_text should have `<u>` tags
3. Check question_number 26 (Reading):
   - passage_text should be about Ocean Currents

### Step 4: Test Frontend
1. Start a new test
2. Navigate to Structure section → Check if underlines appear
3. Navigate to Reading section → Check if passages display
4. Complete test → Check if analytics work

## 🎯 Expected Results:

**Structure Error Identification:**
```
A pharmacist supplies prescribed medications 
                ^^^^^^^^^^^
and gives information to patients about theirs use.
    ^^^^^              ^^^^^^^^^^^      ^^^^^^
```

**Reading Comprehension:**
```
┌─── Ocean Currents Passage ───────────────┐
│ Ocean currents are continuous, directed  │
│ movements of seawater...                 │
│                                          │
│ [3 paragraphs]                           │
└──────────────────────────────────────────┘

Q26: What is the main topic of the passage?
Q27: According to the passage, what creates ocean currents?
Q28: The author mentions the Gulf Stream to illustrate
Q29: What can be inferred about upwelling currents?
```

## 🔄 Rollback (if needed):

If something goes wrong:

```sql
-- Restore from backup
-- Or re-run: database/complete_insert_all.sql
-- Then re-run: database/add_passage_text.sql
```

## ✅ Success Criteria:

- [ ] Structure Q16-40 have underlined text in question_text
- [ ] Reading Q1-50 all have passage_text
- [ ] Frontend displays underlines correctly
- [ ] Frontend displays passages in styled box
- [ ] Result page analytics work correctly
- [ ] No database errors

## 📊 Statistics:

- **Structure Questions Updated**: 25 (Q16-40)
- **Reading Questions Updated**: 50 (Q1-50)
- **New Passages Created**: 10
- **Total SQL Statements**: 75 UPDATE queries
- **Estimated Execution Time**: ~15 seconds

## 🆘 Troubleshooting:

**Problem**: Underlines not showing
- **Solution**: Check if HTML is rendering (dangerouslySetInnerHTML)

**Problem**: Passages missing
- **Solution**: Check passage_text column exists (run add_passage_text.sql first)

**Problem**: Questions out of order
- **Solution**: Question numbers are preserved, just content updated

## 📝 Notes:

- Original question numbers preserved
- Correct answers unchanged
- Only question_text and passage_text updated
- Options updated for Structure Q16-40 to match underlined parts
