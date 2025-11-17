// Section time limits in seconds
export const SECTION_TIME_LIMITS = {
  listening: 35 * 60, // 35 minutes
  structure: 25 * 60, // 25 minutes
  reading: 55 * 60,   // 55 minutes
}

// Number of questions per section (randomly selected from larger question bank)
export const SECTION_QUESTIONS = {
  listening: 50,  // selected from 180 total
  structure: 25,  // selected from 75 total
  reading: 25,    // selected from 75 total
}

// Total questions in a test
export const TOTAL_QUESTIONS = 100

// Score range
export const MIN_SCORE = 217
export const MAX_SCORE = 677

// Section names for display
export const SECTION_NAMES = {
  listening: 'Listening Comprehension',
  structure: 'Structure and Written Expression',
  reading: 'Reading Comprehension',
}

// Format time from seconds to MM:SS
export function formatTime(seconds: number): string {
  const mins = Math.floor(seconds / 60)
  const secs = seconds % 60
  return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`
}

// Calculate PTESOL score
export function calculateScore(
  listeningCorrect: number,
  structureCorrect: number,
  readingCorrect: number
): number {
  // PTESOL formula: Each section scored 31-68, then averaged and scaled
  // Score range: 217-677
  
  const totalCorrect = listeningCorrect + structureCorrect + readingCorrect
  
  // If no questions answered correctly at all, return absolute minimum
  if (totalCorrect === 0) {
    return MIN_SCORE // 217
  }
  
  // Convert raw scores to scaled scores (31-68 range)
  const listeningScore = 31 + (listeningCorrect / 50) * 37
  const structureScore = 31 + (structureCorrect / 25) * 37
  const readingScore = 31 + (readingCorrect / 25) * 37
  
  // Calculate average section score and scale to final range
  // Formula: (section1 + section2 + section3) * 10 / 3
  const averageScore = (listeningScore + structureScore + readingScore) / 3
  const scaledScore = averageScore * 10
  
  // Round and ensure within valid range
  const finalScore = Math.round(scaledScore)
  return Math.max(MIN_SCORE, Math.min(MAX_SCORE, finalScore))
}

// Get passage number for reading questions (15 passages total, 5 questions each)
export function getPassageNumber(questionNumber: number): { passage: number; range: string } {
  if (questionNumber >= 1 && questionNumber <= 5) return { passage: 1, range: '1-5' }
  if (questionNumber >= 6 && questionNumber <= 10) return { passage: 2, range: '6-10' }
  if (questionNumber >= 11 && questionNumber <= 15) return { passage: 3, range: '11-15' }
  if (questionNumber >= 16 && questionNumber <= 20) return { passage: 4, range: '16-20' }
  if (questionNumber >= 21 && questionNumber <= 25) return { passage: 5, range: '21-25' }
  if (questionNumber >= 26 && questionNumber <= 30) return { passage: 6, range: '26-30' }
  if (questionNumber >= 31 && questionNumber <= 35) return { passage: 7, range: '31-35' }
  if (questionNumber >= 36 && questionNumber <= 40) return { passage: 8, range: '36-40' }
  if (questionNumber >= 41 && questionNumber <= 45) return { passage: 9, range: '41-45' }
  if (questionNumber >= 46 && questionNumber <= 50) return { passage: 10, range: '46-50' }
  if (questionNumber >= 51 && questionNumber <= 55) return { passage: 11, range: '51-55' }
  if (questionNumber >= 56 && questionNumber <= 60) return { passage: 12, range: '56-60' }
  if (questionNumber >= 61 && questionNumber <= 65) return { passage: 13, range: '61-65' }
  if (questionNumber >= 66 && questionNumber <= 70) return { passage: 14, range: '66-70' }
  if (questionNumber >= 71 && questionNumber <= 75) return { passage: 15, range: '71-75' }
  return { passage: 0, range: '' }
}

// Get score level description
export function getScoreLevel(score: number): { level: string; color: string; description: string } {
  if (score >= 600) {
    return {
      level: 'Advanced',
      color: 'text-green-600',
      description: 'Excellent English proficiency'
    }
  } else if (score >= 500) {
    return {
      level: 'Intermediate High',
      color: 'text-blue-600',
      description: 'Good English proficiency'
    }
  } else if (score >= 400) {
    return {
      level: 'Intermediate',
      color: 'text-yellow-600',
      description: 'Fair English proficiency'
    }
  } else {
    return {
      level: 'Elementary',
      color: 'text-orange-600',
      description: 'Basic English proficiency'
    }
  }
}

// Get part name and instructions for listening section
export function getListeningPartInfo(part: number | null): { name: string; instruction: string } {
  if (part === 1) {
    return {
      name: 'Part A: Short Conversations',
      instruction: 'Listen to short conversations between two people and answer questions about what they say.'
    }
  } else if (part === 2) {
    return {
      name: 'Part B: Longer Conversations',
      instruction: 'Listen to longer conversations and answer multiple questions about each conversation.'
    }
  } else if (part === 3) {
    return {
      name: 'Part C: Talks & Lectures',
      instruction: 'Listen to talks or academic lectures and answer questions about the content.'
    }
  }
  return {
    name: '',
    instruction: ''
  }
}

// Get instructions for structure section based on question number
export function getStructureInstruction(questionNumber: number): string {
  if (questionNumber <= 25) {
    return 'Complete the sentence by choosing the correct answer.'
  } else {
    return 'Identify the underlined part that is grammatically incorrect.'
  }
}

// Get instructions for reading section
export function getReadingInstruction(): string {
  return 'Read the passage carefully and answer the questions based on the information provided.'
}
