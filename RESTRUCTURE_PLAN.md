# PTESOL Database Restructuring Plan

## Issues to Fix:

### 1. Structure Section - Error Identification Format ❌
**Current Problem:**
- Options show isolated words without context
- No underline in question text
- User can't see which part of sentence to identify

**Example Current (Wrong):**
```
Question: A pharmacist supplies prescribed medications and gives information to patients about theirs use.
Options:
A. supplies
B. gives
C. to patients
D. theirs
```

**Should Be:**
```
Question: A pharmacist <u>supplies</u> prescribed medications and <u>gives</u> information <u>to patients</u> about <u>theirs</u> use.
Options:
A. supplies
B. gives
C. to patients
D. theirs (CORRECT - should be "their")
```

### 2. Reading Section - Passage Organization 📖
**Current Problem:**
- 5 passages for 50 questions (10 questions each)
- Too many questions per passage
- Some questions don't have passage context

**Should Be:**
- 10-12 passages total
- 4-5 questions per passage
- More natural TOEFL-style format

**New Structure:**
```
Passage 1 (Q1-5): Coral Reefs
Passage 2 (Q6-10): Ancient Rome
Passage 3 (Q11-14): Climate Change
Passage 4 (Q15-19): Memory & Learning
Passage 5 (Q20-24): Renaissance Art
Passage 6 (Q25-28): Ocean Currents
Passage 7 (Q29-33): Industrial Revolution
Passage 8 (Q34-37): Photosynthesis
Passage 9 (Q38-42): Urban Planning
Passage 10 (Q43-47): Literature Analysis
Passage 11 (Q48-50): Technology Impact
```

### 3. Result Page - Already Good! ✅
The result page already has:
- ✅ Chart per section (blue/green/purple bars)
- ✅ Percentage accuracy
- ✅ Recommendations based on performance
- ✅ Question-by-question review
- ✅ Weak areas identification

## Files to Create:

1. `database/restructure_structure_questions.sql` - Fix underline format
2. `database/restructure_reading_passages.sql` - Better passage organization
3. `database/RESTRUCTURE_INSTRUCTIONS.md` - Step-by-step guide

## Implementation Priority:

**High Priority (Do Now):**
1. ✅ Result page already has analytics - DONE
2. ⚠️ Structure underline format - NEEDS FIX
3. ⚠️ Reading passage reorganization - NEEDS FIX

**Medium Priority:**
4. Frontend rendering of HTML underlines - DONE (dangerouslySetInnerHTML)
5. Better passage styling - DONE (gradient box)

## Next Steps:

Since this is a massive database restructure (150+ structure questions + 50+ reading questions need updating), I recommend:

1. **Test with a few examples first** (5-10 questions)
2. **Verify frontend displays correctly**
3. **Then bulk update all questions**

Would you like me to:
A. Create test SQL with 5-10 example questions for Structure & Reading?
B. Create full restructure SQL (time-consuming, 200+ UPDATE statements)?
C. Focus on fixing just the most visible issues first?
