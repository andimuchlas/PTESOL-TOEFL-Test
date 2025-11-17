'use server'

import { supabase } from '@/lib/supabase'
import { calculateScore } from '@/lib/utils'

export async function getRandomQuestions() {
  try {
    // Get random questions for each section
    const { data: listeningQuestions, error: listeningError } = await supabase
      .rpc('get_random_questions', { p_section: 'listening', p_limit: 50 })
    
    const { data: structureQuestions, error: structureError } = await supabase
      .rpc('get_random_questions', { p_section: 'structure', p_limit: 40 })
    
    const { data: readingQuestions, error: readingError } = await supabase
      .rpc('get_random_questions', { p_section: 'reading', p_limit: 50 })

    if (listeningError || structureError || readingError) {
      throw new Error('Failed to fetch questions')
    }

    return {
      listening: listeningQuestions || [],
      structure: structureQuestions || [],
      reading: readingQuestions || [],
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
