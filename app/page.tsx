'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { useTestStore } from '@/lib/store'
import { getRandomQuestions } from './actions'
import Link from 'next/link'
import { BookOpen, Trophy, Clock, Users } from 'lucide-react'

export default function Home() {
  const [name, setName] = useState('')
  const [isLoading, setIsLoading] = useState(false)
  const router = useRouter()
  const { setParticipantName, setQuestionsData, setSessionId, resetTest } = useTestStore()

  const handleStartTest = async (e: React.FormEvent) => {
    e.preventDefault()
    
    if (!name.trim()) {
      alert('Please enter your name')
      return
    }

    setIsLoading(true)
    
    try {
      // Reset previous test data
      resetTest()
      
      // Get random questions
      const questions = await getRandomQuestions()
      
      // Combine all questions
      const allQuestions = [
        ...questions.listening,
        ...questions.structure,
        ...questions.reading,
      ]
      
      // Generate session ID
      const sessionId = crypto.randomUUID()
      
      // Save to store
      setParticipantName(name)
      setQuestionsData(allQuestions)
      setSessionId(sessionId)
      
      // Navigate to test
      router.push(`/test/${sessionId}`)
    } catch (error) {
      console.error('Error starting test:', error)
      alert('Failed to start test. Please make sure the database is set up correctly.')
    } finally {
      setIsLoading(false)
    }
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-indigo-50">
      {/* Header */}
      <header className="border-b bg-white/80 backdrop-blur-sm">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              <BookOpen className="h-8 w-8 text-blue-600" />
              <div>
                <h1 className="text-2xl font-bold text-gray-900">PTESOL</h1>
                <p className="text-xs text-gray-600">Balai Bahasa UPI</p>
              </div>
            </div>
            <Link 
              href="/leaderboard"
              className="flex items-center gap-2 rounded-lg bg-blue-600 px-4 py-2 text-sm font-medium text-white hover:bg-blue-700 transition-colors"
            >
              <Trophy className="h-4 w-4" />
              Leaderboard
            </Link>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <main className="container mx-auto px-4 py-12">
        <div className="mx-auto max-w-4xl">
          {/* Hero Section */}
          <div className="text-center mb-12">
            <h2 className="text-4xl md:text-5xl font-bold text-gray-900 mb-4">
              Pelatihan Tes Bahasa Inggris Standar Online
            </h2>
            <p className="text-lg text-gray-700 max-w-2xl mx-auto">
              Tes kemampuan bahasa Inggris yang dikembangkan oleh Balai Bahasa 
              Universitas Pendidikan Indonesia (UPI) di Bandung
            </p>
          </div>

          {/* Info Cards */}
          <div className="grid md:grid-cols-3 gap-6 mb-12">
            <div className="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
              <div className="flex items-center gap-3 mb-3">
                <div className="p-2 bg-blue-100 rounded-lg">
                  <BookOpen className="h-5 w-5 text-blue-600" />
                </div>
                <h3 className="font-semibold text-gray-900">3 Sections</h3>
              </div>
              <p className="text-sm text-gray-600">
                Listening, Structure & Grammar, dan Reading Comprehension
              </p>
            </div>

            <div className="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
              <div className="flex items-center gap-3 mb-3">
                <div className="p-2 bg-green-100 rounded-lg">
                  <Clock className="h-5 w-5 text-green-600" />
                </div>
                <h3 className="font-semibold text-gray-900">115 Minutes</h3>
              </div>
              <p className="text-sm text-gray-600">
                35 min Listening, 25 min Structure, 55 min Reading
              </p>
            </div>

            <div className="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
              <div className="flex items-center gap-3 mb-3">
                <div className="p-2 bg-purple-100 rounded-lg">
                  <Users className="h-5 w-5 text-purple-600" />
                </div>
                <h3 className="font-semibold text-gray-900">140 Questions</h3>
              </div>
              <p className="text-sm text-gray-600">
                50 Listening, 40 Structure, 50 Reading
              </p>
            </div>
          </div>

          {/* Start Test Form */}
          <div className="bg-white rounded-2xl shadow-lg p-8 md:p-12">
            <div className="text-center mb-8">
              <h3 className="text-2xl font-bold text-gray-900 mb-2">
                Ready to Start?
              </h3>
              <p className="text-gray-600">
                Enter your name to begin the PTESOL test
              </p>
            </div>

            <form onSubmit={handleStartTest} className="max-w-md mx-auto">
              <div className="mb-6">
                <label htmlFor="name" className="block text-sm font-medium text-gray-900 mb-2">
                  Full Name
                </label>
                <input
                  type="text"
                  id="name"
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                  placeholder="Enter your name"
                  className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition-all text-gray-900 placeholder:text-gray-500"
                  required
                  disabled={isLoading}
                />
              </div>

              <button
                type="submit"
                disabled={isLoading}
                className="w-full bg-blue-600 text-white py-3 px-6 rounded-lg font-semibold hover:bg-blue-700 disabled:bg-gray-400 disabled:cursor-not-allowed transition-colors"
              >
                {isLoading ? 'Loading Questions...' : 'Start Test'}
              </button>
            </form>

            {/* Instructions */}
            <div className="mt-8 pt-8 border-t border-gray-200">
              <h4 className="font-semibold text-gray-900 mb-3">Important Instructions:</h4>
              <ul className="space-y-2 text-sm text-gray-700">
                <li className="flex items-start gap-2">
                  <span className="text-blue-600 mt-1">•</span>
                  <span>Each section has a time limit. Timer will start automatically.</span>
                </li>
                <li className="flex items-start gap-2">
                  <span className="text-blue-600 mt-1">•</span>
                  <span>You can navigate between questions within the same section.</span>
                </li>
                <li className="flex items-start gap-2">
                  <span className="text-blue-600 mt-1">•</span>
                  <span>Once you finish a section, you cannot go back to it.</span>
                </li>
                <li className="flex items-start gap-2">
                  <span className="text-blue-600 mt-1">•</span>
                  <span>Your score will be calculated automatically after submission.</span>
                </li>
                <li className="flex items-start gap-2">
                  <span className="text-blue-600 mt-1">•</span>
                  <span>Score range: 217-677 (similar to TOEFL ITP)</span>
                </li>
              </ul>
            </div>
          </div>

          {/* Footer Info */}
          <div className="text-center mt-12 text-sm text-gray-700">
            <p>© 2025 PTESOL - Andi</p>
          </div>
        </div>
      </main>
    </div>
  )
}
