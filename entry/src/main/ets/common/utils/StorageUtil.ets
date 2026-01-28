import dataPreferences from '@ohos.data.preferences';
import common from '@ohos.app.ability.common';
import { BusinessError } from '@ohos.base';

const PREFERENCES_NAME = 'chatAI_prefs';

export class StorageUtil {
  private static instance: StorageUtil;
  private preferences: dataPreferences.Preferences | null = null;

  private constructor() {}

  public static getInstance(): StorageUtil {
    if (!StorageUtil.instance) {
      StorageUtil.instance = new StorageUtil();
    }
    return StorageUtil.instance;
  }

  async init(context: common.UIAbilityContext): Promise<void> {
    try {
      this.preferences = await dataPreferences.getPreferences(context, PREFERENCES_NAME);
    } catch (err) {
      let error = err as BusinessError;
      console.error(`Failed to get preferences. Code: ${error.code}, message: ${error.message}`);
    }
  }

  async put(key: string, value: dataPreferences.ValueType): Promise<void> {
    if (!this.preferences) return;
    try {
      await this.preferences.put(key, value);
      await this.preferences.flush();
    } catch (err) {
      let error = err as BusinessError;
      console.error(`Failed to put value. Code: ${error.code}, message: ${error.message}`);
    }
  }

  async get(key: string, defaultValue: dataPreferences.ValueType): Promise<dataPreferences.ValueType> {
    if (!this.preferences) return defaultValue;
    try {
      return await this.preferences.get(key, defaultValue);
    } catch (err) {
      let error = err as BusinessError;
      console.error(`Failed to get value. Code: ${error.code}, message: ${error.message}`);
      return defaultValue;
    }
  }

  async delete(key: string): Promise<void> {
    if (!this.preferences) return;
    try {
      await this.preferences.delete(key);
      await this.preferences.flush();
    } catch (err) {
      let error = err as BusinessError;
      console.error(`Failed to delete value. Code: ${error.code}, message: ${error.message}`);
    }
  }
}
