'use server'

import { supabase } from '@/lib/supabase'
import { calculateScore } from '@/lib/utils'

export async function getRandomQuestions() {
  try {
    // Get 50 listening questions ordered by question_number (not random)
    const { data: listeningQuestions, error: listeningError } = await supabase
      .from('questions')
      .select('*')
      .eq('section', 'listening')
      .order('question_number')
      .limit(50)
    
    const { data: structureQuestions, error: structureError } = await supabase
      .rpc('get_random_questions', { p_section: 'structure', p_limit: 40 })
    
    if (listeningError || structureError) {
      throw new Error('Failed to fetch listening or structure questions')
    }

    // For reading: Select 5 random passages (each passage = 5 questions)
    // Get all reading questions grouped by passage
    const { data: allReadingQuestions, error: readingError } = await supabase
      .from('questions')
      .select('*')
      .eq('section', 'reading')
      .order('question_number')
    
    if (readingError) {
      throw new Error('Failed to fetch reading questions')
    }

    // Group questions by passage (every 5 questions = 1 passage)
    const passages: any[][] = []
    for (let i = 0; i < allReadingQuestions.length; i += 5) {
      const passage = allReadingQuestions.slice(i, i + 5)
      if (passage.length === 5) {
        passages.push(passage)
      }
    }

    // Randomly select 10 passages (10 passages × 5 questions = 50 questions)
    const selectedPassages: any[] = []
    const passageIndices = Array.from({ length: passages.length }, (_, i) => i)
    
    // Shuffle passage indices
    for (let i = passageIndices.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [passageIndices[i], passageIndices[j]] = [passageIndices[j], passageIndices[i]]
    }
    
    // Take first 10 passages
    for (let i = 0; i < 10 && i < passageIndices.length; i++) {
      selectedPassages.push(...passages[passageIndices[i]])
    }

    return {
      listening: listeningQuestions || [],
      structure: structureQuestions || [],
      reading: selectedPassages,
    }
  } catch (error) {
    console.error('Error fetching questions:', error)
    throw error
  }
}

export async function submitTestResults(data: {
  participantName: string
  answers: Record<string, string>
  questionsData: any[]
  durationMinutes: number
}) {
  try {
    // Calculate correct answers per section and detailed results
    let listeningCorrect = 0
    let structureCorrect = 0
    let readingCorrect = 0
    const detailedResults: Record<string, any> = {}

    const questionIds = Object.keys(data.answers)
    
    for (const questionId of questionIds) {
      const question = data.questionsData.find((q) => q.id === questionId)
      if (question) {
        const isCorrect = data.answers[questionId] === question.correct_answer
        
        // Store detailed result for each question
        detailedResults[questionId] = {
          correct: isCorrect,
          user_answer: data.answers[questionId],
          correct_answer: question.correct_answer,
          section: question.section,
          question_number: question.question_number,
          question_text: question.question_text,
          option_a: question.option_a,
          option_b: question.option_b,
          option_c: question.option_c,
          option_d: question.option_d,
          explanation: question.explanation,
          part: question.part, // for listening
          passage_text: question.passage_text, // for reading
        }
        
        if (isCorrect) {
          if (question.section === 'listening') listeningCorrect++
          else if (question.section === 'structure') structureCorrect++
          else if (question.section === 'reading') readingCorrect++
        }
      }
    }

    // Calculate total score
    const totalScore = calculateScore(listeningCorrect, structureCorrect, readingCorrect)

    // Insert test result
    const { data: result, error } = await supabase
      .from('test_results')
      .insert({
        participant_name: data.participantName,
        listening_correct: listeningCorrect,
        structure_correct: structureCorrect,
        reading_correct: readingCorrect,
        total_score: totalScore,
        duration_minutes: data.durationMinutes,
        questions_used: data.questionsData.map((q) => q.id),
        answers: data.answers,
        detailed_results: detailedResults,
      })
      .select()
      .single()

    if (error) {
      console.error('Error submitting test results:', error)
      throw error
    }

    return {
      id: result.id,
      listeningCorrect,
      structureCorrect,
      readingCorrect,
      totalScore,
    }
  } catch (error) {
    console.error('Error submitting test:', error)
    throw error
  }
}

export async function getLeaderboard(limit: number = 100) {
  try {
    const { data, error } = await supabase
      .from('test_results')
      .select('id, participant_name, total_score, completed_at')
      .order('total_score', { ascending: false })
      .order('completed_at', { ascending: true })
      .limit(limit)

    if (error) throw error

    // Add rank
    const leaderboard = data?.map((entry, index) => ({
      ...entry,
      rank: index + 1,
    }))

    return leaderboard || []
  } catch (error) {
    console.error('Error fetching leaderboard:', error)
    throw error
  }
}

export async function getTestResult(resultId: string) {
  try {
    const { data, error } = await supabase
      .from('test_results')
      .select('*')
      .eq('id', resultId)
      .single()

    if (error) throw error

    // Get rank
    const { data: leaderboard } = await supabase
      .from('test_results')
      .select('id, total_score')
      .order('total_score', { ascending: false })
      .order('completed_at', { ascending: true })

    const rank = leaderboard ? leaderboard.findIndex((entry) => entry.id === resultId) + 1 : 0

    return {
      ...data,
      rank,
    }
  } catch (error) {
    console.error('Error fetching test result:', error)
    throw error
  }
}
