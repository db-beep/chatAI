export interface AIProvider {
  name: string;
  defaultEndpoint: string;
  models: string[];
}

export const AI_PROVIDERS: AIProvider[] = [
  {
    name: 'OpenAI',
    defaultEndpoint: 'https://api.openai.com/v1',
    models: [
      'gpt-3.5-turbo',
      'gpt-4',
      'gpt-4-turbo',
      'gpt-4o'
    ]
  },
  {
    name: 'Anthropic (via Relay)',
    defaultEndpoint: 'https://api.anthropic.com/v1',
    models: [
      'claude-3-opus-20240229',
      'claude-3-sonnet-20240229',
      'claude-3-haiku-20240307'
    ]
  },
  {
    name: 'DeepSeek',
    defaultEndpoint: 'https://api.deepseek.com',
    models: [
      'deepseek-chat',
      'deepseek-coder'
    ]
  },
  {
    name: 'Moonshot (Kimi)',
    defaultEndpoint: 'https://api.moonshot.cn/v1',
    models: [
      'moonshot-v1-8k',
      'moonshot-v1-32k',
      'moonshot-v1-128k'
    ]
  },
  {
    name: 'Zhipu AI (GLM)',
    defaultEndpoint: 'https://open.bigmodel.cn/api/paas/v4',
    models: [
      'glm-4',
      'glm-3-turbo'
    ]
  },
  {
    name: 'Aliyun (Qwen)',
    defaultEndpoint: 'https://dashscope.aliyuncs.com/compatible-mode/v1',
    models: [
      'qwen-turbo',
      'qwen-plus',
      'qwen-max'
    ]
  }
];
