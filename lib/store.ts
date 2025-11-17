import { create } from 'zustand'
import { persist } from 'zustand/middleware'

interface TestState {
  sessionId: string | null
  participantName: string | null
  currentSection: 'listening' | 'structure' | 'reading'
  currentQuestionIndex: number
  answers: Record<string, string> // questionId: answer
  sectionStartTime: number | null
  sectionTimeRemaining: number // in seconds
  questionsData: any[]
  
  // Actions
  setSessionId: (id: string) => void
  setParticipantName: (name: string) => void
  setCurrentSection: (section: 'listening' | 'structure' | 'reading') => void
  setCurrentQuestionIndex: (index: number) => void
  setAnswer: (questionId: string, answer: string) => void
  setSectionStartTime: (time: number) => void
  setSectionTimeRemaining: (time: number) => void
  setQuestionsData: (questions: any[]) => void
  resetTest: () => void
}

export const useTestStore = create<TestState>()(
  persist(
    (set) => ({
      sessionId: null,
      participantName: null,
      currentSection: 'listening',
      currentQuestionIndex: 0,
      answers: {},
      sectionStartTime: null,
      sectionTimeRemaining: 0,
      questionsData: [],

      setSessionId: (id) => set({ sessionId: id }),
      setParticipantName: (name) => set({ participantName: name }),
      setCurrentSection: (section) => set({ currentSection: section }),
      setCurrentQuestionIndex: (index) => set({ currentQuestionIndex: index }),
      setAnswer: (questionId, answer) => 
        set((state) => ({ 
          answers: { ...state.answers, [questionId]: answer } 
        })),
      setSectionStartTime: (time) => set({ sectionStartTime: time }),
      setSectionTimeRemaining: (time) => set({ sectionTimeRemaining: time }),
      setQuestionsData: (questions) => set({ questionsData: questions }),
      resetTest: () => set({
        sessionId: null,
        participantName: null,
        currentSection: 'listening',
        currentQuestionIndex: 0,
        answers: {},
        sectionStartTime: null,
        sectionTimeRemaining: 0,
        questionsData: [],
      }),
    }),
    {
      name: 'ptesol-test-storage',
    }
  )
)
