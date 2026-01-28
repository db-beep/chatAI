export interface ProgrammingLanguage {
  id: string;
  name: string;
  displayName: string;
  icon: string | Resource;
  difficulty: 'beginner' | 'intermediate' | 'advanced';
}

export interface QuizQuestion {
  id: string;
  language: string;
  type: 'single' | 'multiple' | 'fill' | 'code';
  question: string;
  code?: string;
  options?: string[];
  correctAnswer: string | string[];
  explanation: string;
  difficulty: number;
  tags: string[];
}

export interface AIModelConfig {
  id: string;
  provider: string;
  modelName: string;
  apiEndpoint: string;
  apiKey: string;
  maxTokens: number;
  temperature: number;
  isActive: boolean;
}

export interface ChatMessage {
  id: string;
  role: 'user' | 'assistant';
  content: string;
  type?: 'text' | 'image' | 'audio';
  mediaUrl?: string; // Base64 or local path
  duration?: number; // For audio
  timestamp: number;
  modelId?: string;
}

export interface QuizRecord {
  id: string;
  questionId: string;
  userAnswer: string | string[];
  isCorrect: boolean;
  completedAt: number;
  timeSpent: number;
}

export interface MistakeRecord {
  id: string;
  questionId: string;
  languageId: string;
  question: string;
  wrongAnswer: string;
  correctAnswer: string;
  explanation: string;
  timestamp: number;
}
