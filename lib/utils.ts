// Section time limits in seconds
export const SECTION_TIME_LIMITS = {
  listening: 35 * 60, // 35 minutes
  structure: 25 * 60, // 25 minutes
  reading: 55 * 60,   // 55 minutes
}

// Number of questions per section
export const SECTION_QUESTIONS = {
  listening: 50,
  structure: 40,
  reading: 50,
}

// Total questions
export const TOTAL_QUESTIONS = 140

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
  // Convert raw scores to scaled scores (31-68 range)
  const listeningScore = Math.round(31 + (listeningCorrect / 50) * 37)
  const structureScore = Math.round(31 + (structureCorrect / 40) * 37)
  const readingScore = Math.round(31 + (readingCorrect / 50) * 37)
  
  // Calculate total score
  const totalScore = Math.round((listeningScore + structureScore + readingScore) * 10 / 3)
  
  // Ensure within valid range
  return Math.max(MIN_SCORE, Math.min(MAX_SCORE, totalScore))
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
