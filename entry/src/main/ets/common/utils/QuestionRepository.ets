import { StorageUtil } from './StorageUtil';
import { MOCK_QUESTIONS } from '../constants/MockData';
import { QuizQuestion } from '../../model/types';

const STORAGE_KEY_CUSTOM_QUESTIONS = 'saved_custom_questions';

export class QuestionRepository {
  static async getAllQuestions(): Promise<QuizQuestion[]> {
    let customQuestions: QuizQuestion[] = [];
    try {
      const jsonStr = await StorageUtil.getInstance().get(STORAGE_KEY_CUSTOM_QUESTIONS, '[]') as string;
      customQuestions = JSON.parse(jsonStr);
    } catch (e) {
      console.error('Failed to load custom questions', e);
      customQuestions = [];
    }
    
    // Merge MOCK and CUSTOM
    // Note: In a real app, you might want to de-duplicate by ID, but assuming IDs are unique enough
    return [...MOCK_QUESTIONS, ...customQuestions];
  }

  static async saveQuestions(newQuestions: QuizQuestion[]): Promise<void> {
    try {
      const jsonStr = await StorageUtil.getInstance().get(STORAGE_KEY_CUSTOM_QUESTIONS, '[]') as string;
      let existingQuestions: QuizQuestion[] = [];
      try {
        existingQuestions = JSON.parse(jsonStr);
      } catch (e) {
        existingQuestions = [];
      }

      // Filter out duplicates based on ID
      const existingIds = new Set(existingQuestions.map(q => q.id));
      const questionsToAdd = newQuestions.filter(q => !existingIds.has(q.id));

      if (questionsToAdd.length > 0) {
        const updatedList = [...existingQuestions, ...questionsToAdd];
        await StorageUtil.getInstance().put(STORAGE_KEY_CUSTOM_QUESTIONS, JSON.stringify(updatedList));
      }
    } catch (e) {
      console.error('Failed to save questions', e);
      throw new Error('Failed to save questions: ' + JSON.stringify(e));
    }
  }

  static async getQuestionsByLanguage(languageId: string): Promise<QuizQuestion[]> {
    const all = await QuestionRepository.getAllQuestions();
    return all.filter(q => q.language.toLowerCase() === languageId.toLowerCase());
  }
}
