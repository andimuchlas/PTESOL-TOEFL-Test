'use client'

import { use, useEffect, useState } from 'react'
import { useRouter } from 'next/navigation'
import { useTestStore } from '@/lib/store'
import { submitTestResults } from '@/app/actions'
import { SECTION_TIME_LIMITS, SECTION_QUESTIONS, SECTION_NAMES, formatTime, getListeningPartInfo } from '@/lib/utils'
import { Clock, ChevronLeft, ChevronRight, CheckCircle, AlertCircle } from 'lucide-react'

export default function TestPage({ params }: { params: Promise<{ sessionId: string }> }) {
  const { sessionId: paramSessionId } = use(params)
  const router = useRouter()
  const {
    sessionId,
    participantName,
    currentSection,
    currentQuestionIndex,
    answers,
    questionsData,
    setCurrentSection,
    setCurrentQuestionIndex,
    setAnswer,
    resetTest,
  } = useTestStore()

  const [timeRemaining, setTimeRemaining] = useState(SECTION_TIME_LIMITS[currentSection])
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [showConfirmNext, setShowConfirmNext] = useState(false)
  const [showConfirmSubmit, setShowConfirmSubmit] = useState(false)
  const [testStartTime] = useState(Date.now())

  // Validate session
  useEffect(() => {
    if (!sessionId || sessionId !== paramSessionId || !participantName || questionsData.length === 0) {
      router.push('/')
    }
  }, [sessionId, paramSessionId, participantName, questionsData, router])

  // Get questions for current section
  const getSectionQuestions = () => {
    return questionsData.filter((q) => q.section === currentSection)
  }

  const sectionQuestions = getSectionQuestions()
  const currentQuestion = sectionQuestions[currentQuestionIndex]

  // Timer effect
  useEffect(() => {
    const timer = setInterval(() => {
      setTimeRemaining((prev) => {
        if (prev <= 1) {
          // Time's up - move to next section or submit
          handleNextSection()
          return 0
        }
        return prev - 1
      })
    }, 1000)

    return () => clearInterval(timer)
  }, [currentSection])

  // Reset timer when section changes
  useEffect(() => {
    setTimeRemaining(SECTION_TIME_LIMITS[currentSection])
  }, [currentSection])

  const handleAnswerSelect = (answer: string) => {
    if (currentQuestion) {
      setAnswer(currentQuestion.id, answer)
    }
  }

  const handlePreviousQuestion = () => {
    if (currentQuestionIndex > 0) {
      setCurrentQuestionIndex(currentQuestionIndex - 1)
    }
  }

  const handleNextQuestion = () => {
    if (currentQuestionIndex < sectionQuestions.length - 1) {
      setCurrentQuestionIndex(currentQuestionIndex + 1)
    }
  }

  const handleNextSection = () => {
    if (currentSection === 'listening') {
      setCurrentSection('structure')
      setCurrentQuestionIndex(0)
      setShowConfirmNext(false)
    } else if (currentSection === 'structure') {
      setCurrentSection('reading')
      setCurrentQuestionIndex(0)
      setShowConfirmNext(false)
    } else {
      // Submit test
      handleSubmitTest()
    }
  }

  const handleSubmitTest = async () => {
    setIsSubmitting(true)
    
    try {
      const durationMinutes = Math.round((Date.now() - testStartTime) / 60000)
      
      const result = await submitTestResults({
        participantName: participantName!,
        answers,
        questionsData,
        durationMinutes,
      })

      // Reset test data
      resetTest()

      // Navigate to result page
      router.push(`/result/${result.id}`)
    } catch (error) {
      console.error('Error submitting test:', error)
      alert('Failed to submit test. Please try again.')
      setIsSubmitting(false)
    }
  }

  const getAnsweredCount = () => {
    return sectionQuestions.filter((q) => answers[q.id]).length
  }

  const isTimeWarning = timeRemaining <= 300 // 5 minutes

  if (!currentQuestion) {
    return (
      <div className="flex min-h-screen items-center justify-center">
        <div className="text-center">
          <p className="text-lg text-gray-600">Loading...</p>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="bg-white border-b sticky top-0 z-10 shadow-sm">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-xl font-bold text-gray-900">
                {SECTION_NAMES[currentSection]}
              </h1>
              <p className="text-sm text-gray-700">{participantName}</p>
            </div>

            <div className="flex items-center gap-4">
              {/* Progress */}
              <div className="hidden md:block text-sm text-gray-800">
                Question {currentQuestionIndex + 1} of {sectionQuestions.length}
                <span className="ml-2">
                  ({getAnsweredCount()}/{sectionQuestions.length} answered)
                </span>
              </div>

              {/* Timer */}
              <div className={`flex items-center gap-2 px-4 py-2 rounded-lg font-mono text-lg font-semibold ${
                isTimeWarning ? 'bg-red-100 text-red-700' : 'bg-blue-100 text-blue-700'
              }`}>
                <Clock className="h-5 w-5" />
                {formatTime(timeRemaining)}
              </div>
            </div>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <main className="container mx-auto px-4 py-8">
        <div className="mx-auto max-w-4xl">
          {/* Section Instructions - Only show for listening with parts */}
          {currentSection === 'listening' && currentQuestion.part && (
            <div className="bg-gradient-to-r from-purple-50 to-blue-50 border border-purple-200 rounded-xl p-4 mb-6 shadow-sm">
              <div className="flex items-start gap-3">
                <svg className="h-5 w-5 text-purple-600 mt-0.5 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <div>
                  <h3 className="font-semibold text-purple-900 text-sm mb-1">
                    {getListeningPartInfo(currentQuestion.part).name}
                  </h3>
                  <p className="text-sm text-purple-700">
                    {getListeningPartInfo(currentQuestion.part).instruction}
                  </p>
                </div>
              </div>
            </div>
          )}

          <div className="bg-white rounded-xl shadow-lg p-6 md:p-8">
            {/* Question Number & Part Info */}
            <div className="mb-6 flex items-center gap-3 flex-wrap">
              <span className="inline-block px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-sm font-semibold">
                Question {currentQuestionIndex + 1}
              </span>
              {currentSection === 'listening' && currentQuestion.part && (
                <span className="inline-block px-3 py-1 bg-purple-100 text-purple-700 rounded-full text-xs font-semibold">
                  {currentQuestion.part === 1 && 'Part A: Short Conversations'}
                  {currentQuestion.part === 2 && 'Part B: Longer Conversations'}
                  {currentQuestion.part === 3 && 'Part C: Talks & Lectures'}
                </span>
              )}
            </div>

            {/* Question Text */}
            <div className="mb-8">
              {/* Audio player - ONLY for listening section */}
              {currentSection === 'listening' && currentQuestion.audio_url && (
                <div className="mb-4 bg-blue-50 border border-blue-200 rounded-lg p-4">
                  <div className="flex items-center gap-2 mb-2">
                    <svg className="h-5 w-5 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15.536 8.464a5 5 0 010 7.072m2.828-9.9a9 9 0 010 12.728M5.586 15H4a1 1 0 01-1-1v-4a1 1 0 011-1h1.586l4.707-4.707C10.923 3.663 12 4.109 12 5v14c0 .891-1.077 1.337-1.707.707L5.586 15z" />
                    </svg>
                    <span className="text-sm font-semibold text-blue-700">Listen to the audio:</span>
                  </div>
                  <audio 
                    key={currentQuestion.id} 
                    controls 
                    className="w-full"
                    preload="auto"
                  >
                    <source src={currentQuestion.audio_url} type="audio/wav" />
                    Your browser does not support the audio element.
                  </audio>
                </div>
              )}
              <p className="text-lg text-gray-900 leading-relaxed">
                {currentQuestion.question_text}
              </p>
            </div>

            {/* Answer Options */}
            <div className="space-y-3">
              {['a', 'b', 'c', 'd'].map((option) => {
                const optionText = currentQuestion[`option_${option}` as keyof typeof currentQuestion]
                const isSelected = answers[currentQuestion.id] === option

                return (
                  <button
                    key={option}
                    onClick={() => handleAnswerSelect(option)}
                    className={`w-full text-left p-4 rounded-lg border-2 transition-all ${
                      isSelected
                        ? 'border-blue-500 bg-blue-50'
                        : 'border-gray-200 hover:border-blue-300 hover:bg-gray-50'
                    }`}
                  >
                    <div className="flex items-start gap-3">
                      <span className={`flex-shrink-0 w-8 h-8 rounded-full flex items-center justify-center font-semibold ${
                        isSelected
                          ? 'bg-blue-500 text-white'
                          : 'bg-gray-200 text-gray-700'
                      }`}>
                        {option.toUpperCase()}
                      </span>
                      <span className="text-gray-900 pt-1">{optionText}</span>
                    </div>
                  </button>
                )
              })}
            </div>
          </div>

          {/* Navigation */}
          <div className="mt-6 flex items-center justify-between gap-4">
            <button
              onClick={handlePreviousQuestion}
              disabled={currentQuestionIndex === 0}
              className="flex items-center gap-2 px-6 py-3 bg-gray-100 text-gray-700 rounded-lg font-semibold hover:bg-gray-200 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
            >
              <ChevronLeft className="h-5 w-5" />
              Previous
            </button>

            <div className="flex-1 text-center text-sm text-gray-800 md:hidden">
              {currentQuestionIndex + 1} / {sectionQuestions.length}
            </div>

            {currentQuestionIndex === sectionQuestions.length - 1 ? (
              <button
                onClick={() => currentSection === 'reading' ? setShowConfirmSubmit(true) : setShowConfirmNext(true)}
                className="flex items-center gap-2 px-6 py-3 bg-green-600 text-white rounded-lg font-semibold hover:bg-green-700 transition-colors"
              >
                {currentSection === 'reading' ? (
                  <>
                    <CheckCircle className="h-5 w-5" />
                    Submit Test
                  </>
                ) : (
                  <>
                    Next Section
                    <ChevronRight className="h-5 w-5" />
                  </>
                )}
              </button>
            ) : (
              <button
                onClick={handleNextQuestion}
                className="flex items-center gap-2 px-6 py-3 bg-blue-600 text-white rounded-lg font-semibold hover:bg-blue-700 transition-colors"
              >
                Next
                <ChevronRight className="h-5 w-5" />
              </button>
            )}
          </div>

          {/* Answer Overview */}
          <div className="mt-8 bg-white rounded-xl shadow-lg p-6">
            <h3 className="font-semibold text-gray-900 mb-4">Answer Overview</h3>
            <div className="grid grid-cols-10 gap-2">
              {sectionQuestions.map((q, idx) => {
                const isAnswered = !!answers[q.id]
                const isCurrent = idx === currentQuestionIndex

                return (
                  <button
                    key={q.id}
                    onClick={() => setCurrentQuestionIndex(idx)}
                    className={`aspect-square rounded-lg text-sm font-semibold transition-all ${
                      isCurrent
                        ? 'bg-blue-600 text-white scale-110'
                        : isAnswered
                        ? 'bg-green-100 text-green-700 hover:bg-green-200'
                        : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
                    }`}
                  >
                    {idx + 1}
                  </button>
                )
              })}
            </div>
            <div className="mt-4 flex items-center gap-4 text-sm text-gray-800">
              <div className="flex items-center gap-2">
                <div className="w-4 h-4 bg-green-100 rounded"></div>
                <span>Answered</span>
              </div>
              <div className="flex items-center gap-2">
                <div className="w-4 h-4 bg-gray-100 rounded"></div>
                <span>Unanswered</span>
              </div>
              <div className="flex items-center gap-2">
                <div className="w-4 h-4 bg-blue-600 rounded"></div>
                <span>Current</span>
              </div>
            </div>
          </div>
        </div>
      </main>

      {/* Confirm Next Section Modal */}
      {showConfirmNext && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-xl p-6 max-w-md w-full">
            <div className="flex items-center gap-3 mb-4">
              <AlertCircle className="h-6 w-6 text-orange-600" />
              <h3 className="text-xl font-bold text-gray-900">Continue to Next Section?</h3>
            </div>
            <p className="text-gray-700 mb-2">
              You have answered {getAnsweredCount()} out of {sectionQuestions.length} questions.
            </p>
            <p className="text-gray-700 mb-6">
              Once you proceed, you cannot return to this section.
            </p>
            <div className="flex gap-3">
              <button
                onClick={() => setShowConfirmNext(false)}
                className="flex-1 px-4 py-2 bg-gray-100 text-gray-700 rounded-lg font-semibold hover:bg-gray-200 transition-colors"
              >
                Review Answers
              </button>
              <button
                onClick={handleNextSection}
                className="flex-1 px-4 py-2 bg-blue-600 text-white rounded-lg font-semibold hover:bg-blue-700 transition-colors"
              >
                Continue
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Confirm Submit Modal */}
      {showConfirmSubmit && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-xl p-6 max-w-md w-full">
            <div className="flex items-center gap-3 mb-4">
              <CheckCircle className="h-6 w-6 text-green-600" />
              <h3 className="text-xl font-bold text-gray-900">Submit Test?</h3>
            </div>
            <p className="text-gray-700 mb-2">
              You have answered {getAnsweredCount()} out of {sectionQuestions.length} questions in this section.
            </p>
            <p className="text-gray-700 mb-6">
              Once you submit, you cannot change your answers.
            </p>
            <div className="flex gap-3">
              <button
                onClick={() => setShowConfirmSubmit(false)}
                disabled={isSubmitting}
                className="flex-1 px-4 py-2 bg-gray-100 text-gray-700 rounded-lg font-semibold hover:bg-gray-200 disabled:opacity-50 transition-colors"
              >
                Review Answers
              </button>
              <button
                onClick={handleSubmitTest}
                disabled={isSubmitting}
                className="flex-1 px-4 py-2 bg-green-600 text-white rounded-lg font-semibold hover:bg-green-700 disabled:opacity-50 transition-colors"
              >
                {isSubmitting ? 'Submitting...' : 'Submit Test'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
