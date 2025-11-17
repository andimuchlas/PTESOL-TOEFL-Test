'use client'

import { useEffect, useState } from 'react'
import Link from 'next/link'
import { getLeaderboard } from '@/app/actions'
import { getScoreLevel } from '@/lib/utils'
import { Trophy, Medal, Award, Home, TrendingUp, Calendar } from 'lucide-react'
import { formatDistanceToNow } from 'date-fns'

interface LeaderboardEntry {
  id: string
  participant_name: string
  total_score: number
  completed_at: string
  rank: number
}

export default function LeaderboardPage() {
  const [leaderboard, setLeaderboard] = useState<LeaderboardEntry[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [filter, setFilter] = useState<'all' | 'top10' | 'top50'>('all')

  useEffect(() => {
    async function fetchLeaderboard() {
      try {
        const data = await getLeaderboard(100)
        setLeaderboard(data)
      } catch (error) {
        console.error('Error fetching leaderboard:', error)
      } finally {
        setIsLoading(false)
      }
    }

    fetchLeaderboard()
  }, [])

  const filteredLeaderboard = leaderboard.slice(
    0,
    filter === 'top10' ? 10 : filter === 'top50' ? 50 : leaderboard.length
  )

  const getRankIcon = (rank: number) => {
    if (rank === 1) return <Trophy className="h-6 w-6 text-yellow-500" />
    if (rank === 2) return <Medal className="h-6 w-6 text-gray-400" />
    if (rank === 3) return <Medal className="h-6 w-6 text-orange-600" />
    return null
  }

  const getRankColor = (rank: number) => {
    if (rank === 1) return 'bg-gradient-to-r from-yellow-50 to-yellow-100 border-yellow-300'
    if (rank === 2) return 'bg-gradient-to-r from-gray-50 to-gray-100 border-gray-300'
    if (rank === 3) return 'bg-gradient-to-r from-orange-50 to-orange-100 border-orange-300'
    return 'bg-white border-gray-200'
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-indigo-50">
      {/* Header */}
      <header className="border-b bg-white/80 backdrop-blur-sm sticky top-0 z-10">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <Trophy className="h-8 w-8 text-blue-600" />
              <div>
                <h1 className="text-2xl font-bold text-gray-900">Leaderboard</h1>
                <p className="text-sm text-gray-700">Top PTESOL Scores</p>
              </div>
            </div>
            <Link 
              href="/"
              className="flex items-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-lg font-semibold hover:bg-blue-700 transition-colors"
            >
              <Home className="h-4 w-4" />
              Home
            </Link>
          </div>
        </div>
      </header>

      <main className="container mx-auto px-4 py-12">
        <div className="mx-auto max-w-5xl">
          {/* Stats Cards */}
          <div className="grid md:grid-cols-3 gap-6 mb-8">
            <div className="bg-white rounded-xl shadow-lg p-6">
              <div className="flex items-center gap-3 mb-2">
                <div className="p-2 bg-yellow-100 rounded-lg">
                  <Trophy className="h-6 w-6 text-yellow-600" />
                </div>
                <h3 className="font-semibold text-gray-900">Total Tests</h3>
              </div>
              <p className="text-3xl font-bold text-gray-900">{leaderboard.length}</p>
            </div>

            <div className="bg-white rounded-xl shadow-lg p-6">
              <div className="flex items-center gap-3 mb-2">
                <div className="p-2 bg-green-100 rounded-lg">
                  <TrendingUp className="h-6 w-6 text-green-600" />
                </div>
                <h3 className="font-semibold text-gray-900">Highest Score</h3>
              </div>
              <p className="text-3xl font-bold text-gray-900">
                {leaderboard.length > 0 ? leaderboard[0].total_score : '-'}
              </p>
            </div>

            <div className="bg-white rounded-xl shadow-lg p-6">
              <div className="flex items-center gap-3 mb-2">
                <div className="p-2 bg-blue-100 rounded-lg">
                  <Award className="h-6 w-6 text-blue-600" />
                </div>
                <h3 className="font-semibold text-gray-900">Average Score</h3>
              </div>
              <p className="text-3xl font-bold text-gray-900">
                {leaderboard.length > 0
                  ? Math.round(leaderboard.reduce((sum, entry) => sum + entry.total_score, 0) / leaderboard.length)
                  : '-'}
              </p>
            </div>
          </div>

          {/* Filters */}
          <div className="bg-white rounded-xl shadow-lg p-4 mb-6">
            <div className="flex items-center gap-2">
              <span className="text-sm font-semibold text-gray-700">Show:</span>
              <button
                onClick={() => setFilter('all')}
                className={`px-4 py-2 rounded-lg text-sm font-semibold transition-colors ${
                  filter === 'all'
                    ? 'bg-blue-600 text-white'
                    : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                }`}
              >
                All
              </button>
              <button
                onClick={() => setFilter('top10')}
                className={`px-4 py-2 rounded-lg text-sm font-semibold transition-colors ${
                  filter === 'top10'
                    ? 'bg-blue-600 text-white'
                    : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                }`}
              >
                Top 10
              </button>
              <button
                onClick={() => setFilter('top50')}
                className={`px-4 py-2 rounded-lg text-sm font-semibold transition-colors ${
                  filter === 'top50'
                    ? 'bg-blue-600 text-white'
                    : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                }`}
              >
                Top 50
              </button>
            </div>
          </div>

          {/* Leaderboard Table */}
          {isLoading ? (
            <div className="bg-white rounded-xl shadow-lg p-12 text-center">
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto mb-4"></div>
              <p className="text-gray-700">Loading leaderboard...</p>
            </div>
          ) : leaderboard.length === 0 ? (
            <div className="bg-white rounded-xl shadow-lg p-12 text-center">
              <Trophy className="h-16 w-16 text-gray-300 mx-auto mb-4" />
              <h3 className="text-xl font-bold text-gray-900 mb-2">No results yet</h3>
              <p className="text-gray-700 mb-6">Be the first to take the PTESOL test!</p>
              <Link
                href="/"
                className="inline-flex items-center gap-2 bg-blue-600 text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-700 transition-colors"
              >
                Start Test
              </Link>
            </div>
          ) : (
            <div className="space-y-3">
              {/* Top 3 - Special Cards */}
              {filteredLeaderboard.slice(0, 3).map((entry) => (
                <div
                  key={entry.id}
                  className={`rounded-xl shadow-lg p-6 border-2 ${getRankColor(entry.rank)}`}
                >
                  <div className="flex items-center gap-4">
                    {/* Rank */}
                    <div className="flex-shrink-0 w-12 text-center">
                      {getRankIcon(entry.rank) || (
                        <div className="text-2xl font-bold text-gray-700">#{entry.rank}</div>
                      )}
                    </div>

                    {/* Name */}
                    <div className="flex-1 min-w-0">
                      <h3 className="text-lg font-bold text-gray-900 truncate">
                        {entry.participant_name}
                      </h3>
                      <div className="flex items-center gap-2 text-sm text-gray-700">
                        <Calendar className="h-4 w-4" />
                        <span>{formatDistanceToNow(new Date(entry.completed_at), { addSuffix: true })}</span>
                      </div>
                    </div>

                    {/* Score */}
                    <div className="text-right">
                      <div className="text-3xl font-bold text-gray-900">{entry.total_score}</div>
                      <div className={`text-sm font-semibold ${getScoreLevel(entry.total_score).color}`}>
                        {getScoreLevel(entry.total_score).level}
                      </div>
                    </div>
                  </div>
                </div>
              ))}

              {/* Rest of the leaderboard */}
              {filteredLeaderboard.slice(3).map((entry) => (
                <div
                  key={entry.id}
                  className="bg-white rounded-xl shadow-sm p-4 border border-gray-200 hover:shadow-md transition-shadow"
                >
                  <div className="flex items-center gap-4">
                    {/* Rank */}
                    <div className="flex-shrink-0 w-12 text-center">
                      <div className="text-xl font-bold text-gray-700">#{entry.rank}</div>
                    </div>

                    {/* Name */}
                    <div className="flex-1 min-w-0">
                      <h3 className="font-semibold text-gray-900 truncate">
                        {entry.participant_name}
                      </h3>
                      <div className="flex items-center gap-2 text-xs text-gray-700">
                        <Calendar className="h-3 w-3" />
                        <span>{formatDistanceToNow(new Date(entry.completed_at), { addSuffix: true })}</span>
                      </div>
                    </div>

                    {/* Score */}
                    <div className="text-right">
                      <div className="text-2xl font-bold text-gray-900">{entry.total_score}</div>
                      <div className={`text-xs font-semibold ${getScoreLevel(entry.total_score).color}`}>
                        {getScoreLevel(entry.total_score).level}
                      </div>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </main>
    </div>
  )
}
