'use client'

import { use, useEffect, useState } from 'react'
import { useRouter } from 'next/navigation'
import Link from 'next/link'
import { getTestResult } from '@/app/actions'
import { SECTION_QUESTIONS, getScoreLevel } from '@/lib/utils'
import { Trophy, Home, TrendingUp, Clock, CheckCircle, Award } from 'lucide-react'

interface DetailedResult {
  correct: boolean
  user_answer: string
  correct_answer: string
  section: string
  question_number: number
  question_text: string
}

interface ResultData {
  id: string
  participant_name: string
  listening_correct: number
  structure_correct: number
  reading_correct: number
  total_score: number
  duration_minutes: number
  completed_at: string
  rank: number
  detailed_results?: Record<string, DetailedResult>
}

// Generate recommendations based on errors
function generateRecommendations(detailedResults: Record<string, DetailedResult> | undefined, section: string) {
  if (!detailedResults) return []
  
  const sectionResults = Object.values(detailedResults).filter(r => r.section === section)
  const incorrectCount = sectionResults.filter(r => !r.correct).length
  const totalCount = sectionResults.length
  const accuracy = totalCount > 0 ? ((totalCount - incorrectCount) / totalCount) * 100 : 0
  
  const recommendations: string[] = []
  
  if (section === 'listening') {
    if (accuracy < 60) {
      recommendations.push('Practice listening to English podcasts or videos daily')
      recommendations.push('Focus on understanding context and main ideas')
      recommendations.push('Work on note-taking skills while listening')
    } else if (accuracy < 80) {
      recommendations.push('Improve listening for specific details')
      recommendations.push('Practice with various English accents')
    } else {
      recommendations.push('Excellent! Continue practicing to maintain your level')
    }
  } else if (section === 'structure') {
    if (accuracy < 60) {
      recommendations.push('Review basic grammar rules (tenses, subject-verb agreement)')
      recommendations.push('Study common sentence patterns')
      recommendations.push('Practice identifying grammatical errors')
    } else if (accuracy < 80) {
      recommendations.push('Focus on advanced grammar topics')
      recommendations.push('Practice more complex sentence structures')
    } else {
      recommendations.push('Great grammar skills! Keep practicing')
    }
  } else if (section === 'reading') {
    if (accuracy < 60) {
      recommendations.push('Read English articles and passages daily')
      recommendations.push('Build your vocabulary systematically')
      recommendations.push('Practice scanning and skimming techniques')
    } else if (accuracy < 80) {
      recommendations.push('Focus on understanding implied meanings')
      recommendations.push('Practice inference questions')
    } else {
      recommendations.push('Excellent reading comprehension! Keep it up')
    }
  }
  
  return recommendations
}

export default function ResultPage({ params }: { params: Promise<{ resultId: string }> }) {
  const { resultId } = use(params)
  const [result, setResult] = useState<ResultData | null>(null)
  const [isLoading, setIsLoading] = useState(true)
  const [showDetailedAnalysis, setShowDetailedAnalysis] = useState(false)
  const router = useRouter()

  useEffect(() => {
    async function fetchResult() {
      try {
        const data = await getTestResult(resultId)
        setResult(data)
      } catch (error) {
        console.error('Error fetching result:', error)
        alert('Failed to load result')
        router.push('/')
      } finally {
        setIsLoading(false)
      }
    }

    fetchResult()
  }, [resultId, router])

  if (isLoading) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-gray-50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-lg text-gray-600">Calculating your score...</p>
        </div>
      </div>
    )
  }

  if (!result) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-gray-50">
        <div className="text-center">
          <p className="text-lg text-gray-600">Result not found</p>
          <Link href="/" className="text-blue-600 hover:underline mt-4 inline-block">
            Go to Home
          </Link>
        </div>
      </div>
    )
  }

  const scoreLevel = getScoreLevel(result.total_score)
  const listeningPercentage = (result.listening_correct / SECTION_QUESTIONS.listening) * 100
  const structurePercentage = (result.structure_correct / SECTION_QUESTIONS.structure) * 100
  const readingPercentage = (result.reading_correct / SECTION_QUESTIONS.reading) * 100

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-indigo-50">
      {/* Header */}
      <header className="border-b bg-white/80 backdrop-blur-sm">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <h1 className="text-2xl font-bold text-gray-900">Test Result</h1>
            <Link 
              href="/"
              className="flex items-center gap-2 px-4 py-2 bg-gray-100 text-gray-700 rounded-lg font-semibold hover:bg-gray-200 transition-colors"
            >
              <Home className="h-4 w-4" />
              Home
            </Link>
          </div>
        </div>
      </header>

      <main className="container mx-auto px-4 py-12">
        <div className="mx-auto max-w-4xl">
          {/* Congratulations Card */}
          <div className="bg-white rounded-2xl shadow-lg p-8 md:p-12 mb-8 text-center">
            <div className="flex justify-center mb-6">
              <div className="p-4 bg-blue-100 rounded-full">
                <Award className="h-12 w-12 text-blue-600" />
              </div>
            </div>
            <h2 className="text-3xl font-bold text-gray-900 mb-2">
              Congratulations, {result.participant_name}!
            </h2>
            <p className="text-gray-700 mb-8">
              You have completed the PTESOL test
            </p>

            {/* Total Score */}
            <div className="bg-gradient-to-r from-blue-500 to-indigo-600 rounded-2xl p-8 text-white mb-6">
              <p className="text-lg mb-2 opacity-90">Your PTESOL Score</p>
              <div className="text-6xl md:text-7xl font-bold mb-4">
                {result.total_score}
              </div>
              <div className="flex items-center justify-center gap-2">
                <TrendingUp className="h-5 w-5" />
                <span className="text-xl font-semibold">{scoreLevel.level}</span>
              </div>
              <p className="mt-2 opacity-90">{scoreLevel.description}</p>
            </div>

            {/* Rank */}
            <div className="flex items-center justify-center gap-3 text-gray-800">
              <Trophy className="h-5 w-5 text-yellow-500" />
              <span className="text-lg">
                Rank <span className="font-bold text-gray-900">#{result.rank}</span> on the leaderboard
              </span>
            </div>
          </div>

          {/* Section Breakdown */}
          <div className="bg-white rounded-2xl shadow-lg p-8 mb-8">
            <h3 className="text-2xl font-bold text-gray-900 mb-6">Section Breakdown</h3>
            
            <div className="space-y-6">
              {/* Listening */}
              <div>
                <div className="flex items-center justify-between mb-2">
                  <h4 className="font-semibold text-gray-900">Listening Comprehension</h4>
                  <span className="text-sm text-gray-600">
                    {result.listening_correct} / {SECTION_QUESTIONS.listening} correct
                  </span>
                </div>
                <div className="w-full bg-gray-200 rounded-full h-3 overflow-hidden">
                  <div 
                    className="bg-blue-600 h-full rounded-full transition-all duration-1000"
                    style={{ width: `${listeningPercentage}%` }}
                  ></div>
                </div>
                <p className="text-sm text-gray-700 mt-1">
                  {listeningPercentage.toFixed(1)}% accuracy
                </p>
              </div>

              {/* Structure */}
              <div>
                <div className="flex items-center justify-between mb-2">
                  <h4 className="font-semibold text-gray-900">Structure and Written Expression</h4>
                  <span className="text-sm text-gray-700">
                    {result.structure_correct} / {SECTION_QUESTIONS.structure} correct
                  </span>
                </div>
                <div className="w-full bg-gray-200 rounded-full h-3 overflow-hidden">
                  <div 
                    className="bg-green-600 h-full rounded-full transition-all duration-1000"
                    style={{ width: `${structurePercentage}%` }}
                  ></div>
                </div>
                <p className="text-sm text-gray-700 mt-1">
                  {structurePercentage.toFixed(1)}% accuracy
                </p>
              </div>

              {/* Reading */}
              <div>
                <div className="flex items-center justify-between mb-2">
                  <h4 className="font-semibold text-gray-900">Reading Comprehension</h4>
                  <span className="text-sm text-gray-700">
                    {result.reading_correct} / {SECTION_QUESTIONS.reading} correct
                  </span>
                </div>
                <div className="w-full bg-gray-200 rounded-full h-3 overflow-hidden">
                  <div 
                    className="bg-purple-600 h-full rounded-full transition-all duration-1000"
                    style={{ width: `${readingPercentage}%` }}
                  ></div>
                </div>
                <p className="text-sm text-gray-700 mt-1">
                  {readingPercentage.toFixed(1)}% accuracy
                </p>
              </div>
            </div>
          </div>

          {/* Additional Info */}
          <div className="grid md:grid-cols-2 gap-6 mb-8">
            <div className="bg-white rounded-xl shadow-lg p-6">
              <div className="flex items-center gap-3 mb-3">
                <Clock className="h-6 w-6 text-blue-600" />
                <h4 className="font-semibold text-gray-900">Duration</h4>
              </div>
              <p className="text-2xl font-bold text-gray-900">
                {result.duration_minutes} minutes
              </p>
            </div>

            <div className="bg-white rounded-xl shadow-lg p-6">
              <div className="flex items-center gap-3 mb-3">
                <CheckCircle className="h-6 w-6 text-green-600" />
                <h4 className="font-semibold text-gray-900">Total Correct</h4>
              </div>
              <p className="text-2xl font-bold text-gray-900">
                {result.listening_correct + result.structure_correct + result.reading_correct} / 140
              </p>
            </div>
          </div>

          {/* Detailed Analysis & Recommendations */}
          <div className="bg-white rounded-2xl shadow-lg p-8 mb-8">
            <div className="flex items-center justify-between mb-6">
              <h3 className="text-2xl font-bold text-gray-900">Performance Analysis</h3>
              <button
                onClick={() => setShowDetailedAnalysis(!showDetailedAnalysis)}
                className="text-blue-600 hover:text-blue-700 font-semibold text-sm"
              >
                {showDetailedAnalysis ? 'Hide Details' : 'Show Detailed Analysis'}
              </button>
            </div>

            {/* Section Analysis with Charts */}
            <div className="space-y-6">
              {/* Listening Analysis */}
              <div className="border-l-4 border-blue-500 pl-6 py-4 bg-blue-50 rounded-r-lg">
                <h4 className="font-bold text-gray-900 mb-2 flex items-center gap-2">
                  <span className="text-blue-600">📊</span>
                  Listening Comprehension Analysis
                </h4>
                <div className="flex items-center gap-4 mb-3">
                  <div className="flex-1">
                    <div className="flex justify-between text-sm mb-1">
                      <span className="text-gray-700">Correct: {result.listening_correct}</span>
                      <span className="text-gray-700">Wrong: {SECTION_QUESTIONS.listening - result.listening_correct}</span>
                    </div>
                    <div className="w-full bg-gray-200 rounded-full h-2 overflow-hidden">
                      <div className="bg-blue-600 h-full" style={{ width: `${listeningPercentage}%` }}></div>
                    </div>
                  </div>
                  <div className="text-right">
                    <div className="text-2xl font-bold text-blue-600">{listeningPercentage.toFixed(0)}%</div>
                  </div>
                </div>
                <div className="mt-4">
                  <p className="font-semibold text-sm text-gray-900 mb-2">💡 Recommendations:</p>
                  <ul className="text-sm text-gray-700 space-y-1">
                    {generateRecommendations(result.detailed_results, 'listening').map((rec, idx) => (
                      <li key={idx} className="flex items-start gap-2">
                        <span className="text-blue-600 mt-0.5">•</span>
                        <span>{rec}</span>
                      </li>
                    ))}
                  </ul>
                </div>
              </div>

              {/* Structure Analysis */}
              <div className="border-l-4 border-green-500 pl-6 py-4 bg-green-50 rounded-r-lg">
                <h4 className="font-bold text-gray-900 mb-2 flex items-center gap-2">
                  <span className="text-green-600">📊</span>
                  Structure & Grammar Analysis
                </h4>
                <div className="flex items-center gap-4 mb-3">
                  <div className="flex-1">
                    <div className="flex justify-between text-sm mb-1">
                      <span className="text-gray-700">Correct: {result.structure_correct}</span>
                      <span className="text-gray-700">Wrong: {SECTION_QUESTIONS.structure - result.structure_correct}</span>
                    </div>
                    <div className="w-full bg-gray-200 rounded-full h-2 overflow-hidden">
                      <div className="bg-green-600 h-full" style={{ width: `${structurePercentage}%` }}></div>
                    </div>
                  </div>
                  <div className="text-right">
                    <div className="text-2xl font-bold text-green-600">{structurePercentage.toFixed(0)}%</div>
                  </div>
                </div>
                <div className="mt-4">
                  <p className="font-semibold text-sm text-gray-900 mb-2">💡 Recommendations:</p>
                  <ul className="text-sm text-gray-700 space-y-1">
                    {generateRecommendations(result.detailed_results, 'structure').map((rec, idx) => (
                      <li key={idx} className="flex items-start gap-2">
                        <span className="text-green-600 mt-0.5">•</span>
                        <span>{rec}</span>
                      </li>
                    ))}
                  </ul>
                </div>
              </div>

              {/* Reading Analysis */}
              <div className="border-l-4 border-purple-500 pl-6 py-4 bg-purple-50 rounded-r-lg">
                <h4 className="font-bold text-gray-900 mb-2 flex items-center gap-2">
                  <span className="text-purple-600">📊</span>
                  Reading Comprehension Analysis
                </h4>
                <div className="flex items-center gap-4 mb-3">
                  <div className="flex-1">
                    <div className="flex justify-between text-sm mb-1">
                      <span className="text-gray-700">Correct: {result.reading_correct}</span>
                      <span className="text-gray-700">Wrong: {SECTION_QUESTIONS.reading - result.reading_correct}</span>
                    </div>
                    <div className="w-full bg-gray-200 rounded-full h-2 overflow-hidden">
                      <div className="bg-purple-600 h-full" style={{ width: `${readingPercentage}%` }}></div>
                    </div>
                  </div>
                  <div className="text-right">
                    <div className="text-2xl font-bold text-purple-600">{readingPercentage.toFixed(0)}%</div>
                  </div>
                </div>
                <div className="mt-4">
                  <p className="font-semibold text-sm text-gray-900 mb-2">💡 Recommendations:</p>
                  <ul className="text-sm text-gray-700 space-y-1">
                    {generateRecommendations(result.detailed_results, 'reading').map((rec, idx) => (
                      <li key={idx} className="flex items-start gap-2">
                        <span className="text-purple-600 mt-0.5">•</span>
                        <span>{rec}</span>
                      </li>
                    ))}
                  </ul>
                </div>
              </div>
            </div>

            {/* Detailed Question-by-Question Analysis */}
            {showDetailedAnalysis && result.detailed_results && (
              <div className="mt-8 pt-8 border-t border-gray-200">
                <h4 className="font-bold text-gray-900 mb-4">Question-by-Question Review</h4>
                <div className="space-y-3 max-h-96 overflow-y-auto">
                  {Object.entries(result.detailed_results)
                    .sort(([, a], [, b]) => {
                      if (a.section !== b.section) {
                        const order = { listening: 0, structure: 1, reading: 2 }
                        return order[a.section as keyof typeof order] - order[b.section as keyof typeof order]
                      }
                      return a.question_number - b.question_number
                    })
                    .map(([questionId, detail]) => (
                    <div
                      key={questionId}
                      className={`p-4 rounded-lg border-2 ${
                        detail.correct
                          ? 'border-green-200 bg-green-50'
                          : 'border-red-200 bg-red-50'
                      }`}
                    >
                      <div className="flex items-start justify-between gap-4">
                        <div className="flex-1">
                          <div className="flex items-center gap-2 mb-2">
                            <span className={`px-2 py-1 rounded text-xs font-semibold ${
                              detail.section === 'listening' ? 'bg-blue-100 text-blue-700' :
                              detail.section === 'structure' ? 'bg-green-100 text-green-700' :
                              'bg-purple-100 text-purple-700'
                            }`}>
                              {detail.section.toUpperCase()} #{detail.question_number}
                            </span>
                            {detail.correct ? (
                              <span className="text-green-600 font-semibold text-sm">✓ Correct</span>
                            ) : (
                              <span className="text-red-600 font-semibold text-sm">✗ Wrong</span>
                            )}
                          </div>
                          <p className="text-sm text-gray-700 mb-2">{detail.question_text}</p>
                          <div className="text-xs">
                            <span className="text-gray-700">Your answer: </span>
                            <span className={`font-semibold ${
                              detail.correct ? 'text-green-700' : 'text-red-700'
                            }`}>
                              {detail.user_answer.toUpperCase()}
                            </span>
                            {!detail.correct && (
                              <>
                                <span className="text-gray-700 ml-4">Correct answer: </span>
                                <span className="font-semibold text-green-700">
                                  {detail.correct_answer.toUpperCase()}
                                </span>
                              </>
                            )}
                          </div>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>

          {/* Action Buttons */}
          <div className="flex flex-col md:flex-row gap-4">
            <Link 
              href="/leaderboard"
              className="flex-1 flex items-center justify-center gap-2 bg-blue-600 text-white py-4 px-6 rounded-xl font-semibold hover:bg-blue-700 transition-colors"
            >
              <Trophy className="h-5 w-5" />
              View Leaderboard
            </Link>
            <Link 
              href="/"
              className="flex-1 flex items-center justify-center gap-2 bg-gray-100 text-gray-700 py-4 px-6 rounded-xl font-semibold hover:bg-gray-200 transition-colors"
            >
              <Home className="h-5 w-5" />
              Take Another Test
            </Link>
          </div>

          {/* Score Interpretation */}
          <div className="mt-8 bg-blue-50 border border-blue-200 rounded-xl p-6">
            <h4 className="font-semibold text-gray-900 mb-3">Score Interpretation</h4>
            <div className="grid md:grid-cols-4 gap-4 text-sm">
              <div>
                <div className="font-semibold text-green-700">600-677</div>
                <div className="text-gray-800">Advanced</div>
              </div>
              <div>
                <div className="font-semibold text-blue-700">500-599</div>
                <div className="text-gray-800">Intermediate High</div>
              </div>
              <div>
                <div className="font-semibold text-yellow-700">400-499</div>
                <div className="text-gray-800">Intermediate</div>
              </div>
              <div>
                <div className="font-semibold text-orange-700">217-399</div>
                <div className="text-gray-800">Elementary</div>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>
  )
}
