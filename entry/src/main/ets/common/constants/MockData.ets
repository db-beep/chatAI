import { ProgrammingLanguage, QuizQuestion } from '../../model/types';

export const PROGRAMMING_LANGUAGES: ProgrammingLanguage[] = [
  {
    id: 'arkts',
    name: 'ArkTS',
    displayName: 'ArkTS',
    icon: 'https://img.icons8.com/color/96/code.png', // Huawei Logo for ArkTS
    difficulty: 'intermediate'
  },
  {
    id: 'cangjie',
    name: 'Cangjie',
    displayName: '仓颉',
    icon: 'https://img.icons8.com/color/96/code.png', // Generic Code icon for Cangjie
    difficulty: 'advanced'
  },
  {
    id: 'java',
    name: 'Java',
    displayName: 'Java',
    icon: 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/java/java-original.svg',
    difficulty: 'intermediate'
  },
  {
    id: 'python',
    name: 'Python',
    displayName: 'Python',
    icon: 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/python/python-original.svg',
    difficulty: 'beginner'
  },
  {
    id: 'cpp',
    name: 'Cpp',
    displayName: 'C++',
    icon: 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/cplusplus/cplusplus-original.svg',
    difficulty: 'advanced'
  },
  {
    id: 'javascript',
    name: 'JavaScript',
    displayName: 'JavaScript',
    icon: 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/javascript/javascript-original.svg',
    difficulty: 'beginner'
  },
  {
    id: 'typescript',
    name: 'TypeScript',
    displayName: 'TypeScript',
    icon: 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/typescript/typescript-original.svg',
    difficulty: 'intermediate'
  },
  {
    id: 'go',
    name: 'Go',
    displayName: 'Go',
    icon: 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/go/go-original-wordmark.svg',
    difficulty: 'intermediate'
  },
  {
    id: 'rust',
    name: 'Rust',
    displayName: 'Rust',
    icon: 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/rust/rust-original.svg',
    difficulty: 'advanced'
  },
  {
    id: 'swift',
    name: 'Swift',
    displayName: 'Swift',
    icon: 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/swift/swift-original.svg',
    difficulty: 'intermediate'
  },
  {
    id: 'kotlin',
    name: 'Kotlin',
    displayName: 'Kotlin',
    icon: 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/kotlin/kotlin-original.svg',
    difficulty: 'intermediate'
  }
];

export const MOCK_QUESTIONS: QuizQuestion[] = [
  // --- ArkTS Questions ---
  {
    id: 'arkts_1',
    language: 'arkts',
    type: 'single',
    question: 'ArkTS中，@State装饰器的作用是什么？',
    options: [
      '定义组件的输入参数',
      '定义组件的内部状态，当状态改变时会触发UI刷新',
      '定义组件的样式',
      '定义全局变量'
    ],
    correctAnswer: '定义组件的内部状态，当状态改变时会触发UI刷新',
    explanation: '@State装饰的变量是组件内部的状态数据，当这些状态数据被修改时，会触发组件的build方法进行UI刷新。',
    difficulty: 1,
    tags: ['ArkTS', 'Decorator', 'State']
  },
  {
    id: 'arkts_2',
    language: 'arkts',
    type: 'single',
    question: '在ArkTS中，用于标记自定义组件的入口的装饰器是？',
    options: [
      '@Component',
      '@Entry',
      '@Builder',
      '@Preview'
    ],
    correctAnswer: '@Entry',
    explanation: '@Entry装饰的自定义组件将作为页面的入口组件，在页面加载时首先进行渲染。',
    difficulty: 1,
    tags: ['ArkTS', 'Decorator']
  },
  {
    id: 'arkts_3',
    language: 'arkts',
    type: 'single',
    question: 'ArkTS是基于哪种语言扩展而来的？',
    options: [
      'JavaScript',
      'TypeScript',
      'Java',
      'C++'
    ],
    correctAnswer: 'TypeScript',
    explanation: 'ArkTS是基于TypeScript（TS）语言扩展而来的，继承了TS的所有特性，并进行了静态类型检查和运行时优化。',
    difficulty: 1,
    tags: ['ArkTS', 'Basics']
  },
  {
    id: 'arkts_4',
    language: 'arkts',
    type: 'single',
    question: '在ArkUI中，如何创建一个垂直排列的容器？',
    options: [
      'Row()',
      'Column()',
      'Stack()',
      'Flex()'
    ],
    correctAnswer: 'Column()',
    explanation: 'Column容器组件用于将子组件垂直排列。',
    difficulty: 1,
    tags: ['ArkUI', 'Layout']
  },
  {
    id: 'arkts_5',
    language: 'arkts',
    type: 'single',
    question: 'ArkTS中，用于父子组件双向同步状态的装饰器是？',
    options: [
      '@Prop',
      '@Link',
      '@State',
      '@Provide'
    ],
    correctAnswer: '@Link',
    explanation: '@Link装饰的变量可以和父组件的@State变量建立双向同步关系。',
    difficulty: 2,
    tags: ['ArkTS', 'State Management']
  },
  {
    id: 'arkts_6',
    language: 'arkts',
    type: 'single',
    question: 'ArkTS中，关于ForEach循环渲染，以下说法错误的是？',
    options: [
      'ForEach必须在容器组件内使用',
      'keyGenerator参数是可选的，但建议提供',
      'ForEach的第一个参数必须是数组',
      'ForEach生成的组件不需要唯一的键值'
    ],
    correctAnswer: 'ForEach生成的组件不需要唯一的键值',
    explanation: 'ForEach要求为每个数组元素生成一个唯一的键值（key），以便框架识别数组元素的变化并进行高效更新。',
    difficulty: 2,
    tags: ['ArkTS', 'Rendering']
  },
  {
    id: 'arkts_7',
    language: 'arkts',
    type: 'single',
    question: '在自定义组件生命周期中，组件即将出现时调用的回调是？',
    options: [
      'aboutToDisappear',
      'aboutToAppear',
      'onPageShow',
      'onBackPress'
    ],
    correctAnswer: 'aboutToAppear',
    explanation: 'aboutToAppear函数在组件即将创建自定义组件的实例后，在执行其build()函数之前执行。',
    difficulty: 2,
    tags: ['ArkTS', 'Lifecycle']
  },
  {
    id: 'arkts_8',
    language: 'arkts',
    type: 'single',
    question: '用于轻量级复用UI结构的装饰器是？',
    options: [
      '@Component',
      '@Builder',
      '@CustomDialog',
      '@Styles'
    ],
    correctAnswer: '@Builder',
    explanation: '@Builder装饰的方法用于定义轻量级的UI元素复用逻辑，可以在组件内部或全局定义。',
    difficulty: 2,
    tags: ['ArkTS', 'Decorator']
  },
  {
    id: 'arkts_9',
    language: 'arkts',
    type: 'single',
    question: '用于监听@State变量变化的装饰器是？',
    options: [
      '@Watch',
      '@Observe',
      '@Link',
      '@Prop'
    ],
    correctAnswer: '@Watch',
    explanation: '@Watch装饰器用于监听状态变量的变化，当状态变量变化时，会调用指定的回调方法。',
    difficulty: 2,
    tags: ['ArkTS', 'Decorator', 'State']
  },
  {
    id: 'arkts_10',
    language: 'arkts',
    type: 'single',
    question: 'AppStorage的主要作用是什么？',
    options: [
      '存储页面级数据',
      '存储应用全局的UI状态数据',
      '持久化存储数据到磁盘',
      '存储组件内部状态'
    ],
    correctAnswer: '存储应用全局的UI状态数据',
    explanation: 'AppStorage是应用全局的UI状态存储，在应用启动时创建，所有页面和组件都可以访问。',
    difficulty: 2,
    tags: ['ArkTS', 'State Management']
  },
  {
    id: 'arkts_11',
    language: 'arkts',
    type: 'single',
    question: '处理大数据量列表渲染时，推荐使用哪个组件以优化性能？',
    options: [
      'ForEach',
      'LazyForEach',
      'List',
      'Scroll'
    ],
    correctAnswer: 'LazyForEach',
    explanation: 'LazyForEach用于按需迭代数据并创建组件，特别适用于数据量大、列表长的场景，能显著降低内存占用和渲染时间。',
    difficulty: 3,
    tags: ['ArkTS', 'Performance']
  },

  // --- Cangjie Questions ---
  {
    id: 'cangjie_1',
    language: 'cangjie',
    type: 'single',
    question: '仓颉编程语言是哪家公司开发的？',
    options: [
      'Google',
      'Apple',
      'Huawei',
      'Microsoft'
    ],
    correctAnswer: 'Huawei',
    explanation: '仓颉编程语言是由华为自主研发的下一代编程语言，面向全场景智能。',
    difficulty: 1,
    tags: ['Cangjie', 'General']
  },
  {
    id: 'cangjie_2',
    language: 'cangjie',
    type: 'single',
    question: '仓颉语言的主要应用场景包括？',
    options: [
      '仅Web前端开发',
      '仅后端服务器开发',
      '鸿蒙原生应用及全场景智能开发',
      '仅嵌入式开发'
    ],
    correctAnswer: '鸿蒙原生应用及全场景智能开发',
    explanation: '仓颉语言设计初衷是面向全场景智能，特别是在HarmonyOS NEXT生态中作为核心开发语言之一。',
    difficulty: 1,
    tags: ['Cangjie', 'Application']
  },
  {
    id: 'cangjie_3',
    language: 'cangjie',
    type: 'single',
    question: '关于仓颉语言的类型系统，以下说法正确的是？',
    options: [
      '它是动态类型语言',
      '它是静态类型语言',
      '它没有类型检查',
      '它完全兼容Python语法'
    ],
    correctAnswer: '它是静态类型语言',
    explanation: '仓颉是一种静态强类型语言，这有助于在编译期发现错误，提高代码的安全性和性能。',
    difficulty: 2,
    tags: ['Cangjie', 'Type System']
  },
  {
    id: 'cangjie_4',
    language: 'cangjie',
    type: 'single',
    question: '仓颉语言支持哪种内存管理机制？',
    options: [
      '手动malloc/free',
      '自动垃圾回收 (GC)',
      '仅栈内存分配',
      '引用计数'
    ],
    correctAnswer: '自动垃圾回收 (GC)',
    explanation: '现代高级语言如仓颉通常具备自动内存管理机制（GC），以降低开发者的内存管理负担。',
    difficulty: 2,
    tags: ['Cangjie', 'Memory']
  },
  {
    id: 'cangjie_5',
    language: 'cangjie',
    type: 'single',
    question: '在仓颉中，定义变量使用哪个关键字？',
    options: [
      'let',
      'var',
      'const',
      'def'
    ],
    correctAnswer: 'var',
    explanation: '在仓颉中，var用于定义变量（可变），let用于定义常量（不可变）。',
    difficulty: 1,
    tags: ['Cangjie', 'Syntax']
  },
  {
    id: 'cangjie_6',
    language: 'cangjie',
    type: 'single',
    question: '仓颉语言中，程序的入口函数通常是？',
    options: [
      'func main(): Unit',
      'main()',
      'public static void main',
      'def main'
    ],
    correctAnswer: 'main()',
    explanation: '仓颉程序的入口通常是一个名为main的函数，例如 main() { ... }。',
    difficulty: 1,
    tags: ['Cangjie', 'Syntax']
  },
  {
    id: 'cangjie_7',
    language: 'cangjie',
    type: 'single',
    question: '仓颉中的字符串插值语法是？',
    options: [
      '${expression}',
      '#{expression}',
      '%s',
      '{{expression}}'
    ],
    correctAnswer: '${expression}',
    explanation: '仓颉支持字符串插值，使用${}语法在字符串字面量中嵌入表达式。',
    difficulty: 1,
    tags: ['Cangjie', 'Syntax']
  },
  {
    id: 'cangjie_8',
    language: 'cangjie',
    type: 'single',
    question: '仓颉的基础整数类型Int64占用多少位？',
    options: [
      '32',
      '64',
      '128',
      '取决于平台'
    ],
    correctAnswer: '64',
    explanation: 'Int64明确表示占用64位的有符号整数。',
    difficulty: 1,
    tags: ['Cangjie', 'Data Types']
  },
  {
    id: 'cangjie_9',
    language: 'cangjie',
    type: 'single',
    question: '仓颉中用于模式匹配的关键字是？',
    options: [
      'switch',
      'match',
      'case',
      'check'
    ],
    correctAnswer: 'match',
    explanation: '仓颉使用match表达式进行强大的模式匹配，类似于Rust和Scala。',
    difficulty: 2,
    tags: ['Cangjie', 'Control Flow']
  },
  {
    id: 'cangjie_10',
    language: 'cangjie',
    type: 'single',
    question: '仓颉中处理可能不存在的值的类型是？',
    options: [
      'Optional<T>',
      'Option<T>',
      'Maybe<T>',
      'Nullable<T>'
    ],
    correctAnswer: 'Option<T>',
    explanation: '仓颉使用Option<T>枚举类型来表示一个值可能存在（Some）或不存在（None），避免空指针异常。',
    difficulty: 2,
    tags: ['Cangjie', 'Types']
  },

  // --- Java Questions ---
  {
    id: 'java_1',
    language: 'java',
    type: 'single',
    question: 'Java程序的入口方法签名是什么？',
    options: [
      'public void main(String[] args)',
      'public static void main(String[] args)',
      'static void main(String args)',
      'public static int main(String[] args)'
    ],
    correctAnswer: 'public static void main(String[] args)',
    explanation: 'Java程序的入口是public static void main(String[] args)方法，JVM通过该方法启动程序。',
    difficulty: 1,
    tags: ['Java', 'Basics']
  },
  {
    id: 'java_2',
    language: 'java',
    type: 'single',
    question: 'Java中，int类型占用多少字节？',
    options: [
      '2',
      '4',
      '8',
      '取决于操作系统'
    ],
    correctAnswer: '4',
    explanation: '在Java中，int类型固定占用4个字节（32位），具有跨平台一致性。',
    difficulty: 1,
    tags: ['Java', 'Data Types']
  },
  {
    id: 'java_3',
    language: 'java',
    type: 'single',
    question: '以下哪个关键字用于继承类？',
    options: [
      'implements',
      'extends',
      'inherits',
      'super'
    ],
    correctAnswer: 'extends',
    explanation: 'extends关键字用于类的继承，implements用于实现接口。',
    difficulty: 1,
    tags: ['Java', 'OOP']
  },
  {
    id: 'java_4',
    language: 'java',
    type: 'single',
    question: 'ArrayList和LinkedList的主要区别是？',
    options: [
      'ArrayList是线程安全的，LinkedList不是',
      'ArrayList基于动态数组，LinkedList基于双向链表',
      'LinkedList查询更快',
      '没有区别'
    ],
    correctAnswer: 'ArrayList基于动态数组，LinkedList基于双向链表',
    explanation: 'ArrayList底层是数组，随机访问快；LinkedList底层是链表，插入删除快。',
    difficulty: 2,
    tags: ['Java', 'Collections']
  },
  {
    id: 'java_5',
    language: 'java',
    type: 'single',
    question: '关于Java接口（Interface），以下说法错误的是？',
    options: [
      '接口不能被实例化',
      '一个类可以实现多个接口',
      '接口中的方法默认是private的',
      '接口可以包含常量'
    ],
    correctAnswer: '接口中的方法默认是private的',
    explanation: '在Java接口中，方法默认是public abstract的（Java 8之前），不能是private（Java 9开始支持private方法用于内部复用，但常规接口方法对外是public的）。',
    difficulty: 2,
    tags: ['Java', 'OOP']
  },
  {
    id: 'java_6',
    language: 'java',
    type: 'single',
    question: 'Java中final关键字修饰变量意味着什么？',
    options: [
      '变量可见性为public',
      '变量的值一旦赋值后不可修改',
      '变量必须是静态的',
      '变量可以被继承'
    ],
    correctAnswer: '变量的值一旦赋值后不可修改',
    explanation: 'final修饰的变量表示常量，一旦初始化后其值就不能被改变。',
    difficulty: 1,
    tags: ['Java', 'Keywords']
  },
  {
    id: 'java_7',
    language: 'java',
    type: 'single',
    question: '处理异常的关键字顺序通常是？',
    options: [
      'try-catch-finally',
      'catch-try-finally',
      'try-finally-catch',
      'finally-try-catch'
    ],
    correctAnswer: 'try-catch-finally',
    explanation: '标准的异常处理结构是先try块，后接一个或多个catch块，最后可选finally块。',
    difficulty: 1,
    tags: ['Java', 'Exceptions']
  },
  {
    id: 'java_8',
    language: 'java',
    type: 'single',
    question: 'Java支持多重类继承吗？',
    options: [
      '支持',
      '不支持，但支持多重接口实现',
      '取决于JVM版本',
      '仅支持抽象类多重继承'
    ],
    correctAnswer: '不支持，但支持多重接口实现',
    explanation: 'Java不支持类的多继承（一个类只能extends一个父类），但允许实现多个接口。',
    difficulty: 2,
    tags: ['Java', 'OOP']
  },
  {
    id: 'java_9',
    language: 'java',
    type: 'single',
    question: 'String a = "xyz"; String b = "xyz"; a == b 的结果是？',
    options: [
      'true',
      'false',
      '编译错误',
      '运行时异常'
    ],
    correctAnswer: 'true',
    explanation: 'Java中有字符串常量池。字面量相同的字符串在常量池中是同一个对象，因此引用相等。',
    difficulty: 2,
    tags: ['Java', 'Strings']
  },
  {
    id: 'java_10',
    language: 'java',
    type: 'single',
    question: 'HashMap的工作原理基于什么？',
    options: [
      'Hashing',
      'Indexing',
      'Sorting',
      'Recursion'
    ],
    correctAnswer: 'Hashing',
    explanation: 'HashMap使用哈希算法（HashCode）来计算键的存储位置（Bucket）。',
    difficulty: 2,
    tags: ['Java', 'Collections']
  },

  // --- Python Questions ---
  {
    id: 'python_1',
    language: 'python',
    type: 'single',
    question: 'Python中，用于定义函数的关键字是？',
    options: [
      'function',
      'func',
      'def',
      'define'
    ],
    correctAnswer: 'def',
    explanation: 'Python使用def关键字来定义函数。',
    difficulty: 1,
    tags: ['Python', 'Basics']
  },
  {
    id: 'python_2',
    language: 'python',
    type: 'single',
    question: 'Python中的列表（List）是可变的吗？',
    options: [
      '是',
      '否',
      '取决于内容',
      '仅在函数内可变'
    ],
    correctAnswer: '是',
    explanation: 'Python的列表是可变序列，可以随时添加、删除或修改其中的元素。',
    difficulty: 1,
    tags: ['Python', 'Data Structures']
  },
  {
    id: 'python_3',
    language: 'python',
    type: 'single',
    question: '以下哪个数据结构是键值对集合？',
    options: [
      'List',
      'Tuple',
      'Set',
      'Dictionary'
    ],
    correctAnswer: 'Dictionary',
    explanation: 'Dictionary（字典）是Python中用于存储键值对的数据结构。',
    difficulty: 1,
    tags: ['Python', 'Data Structures']
  },
  {
    id: 'python_4',
    language: 'python',
    type: 'single',
    question: 'Python中创建列表推导式的正确语法是？',
    options: [
      '[x for x in range(10)]',
      '{x for x in range(10)}',
      '(x for x in range(10))',
      'list(x in range(10))'
    ],
    correctAnswer: '[x for x in range(10)]',
    explanation: '[]用于列表推导式，{}用于集合或字典推导式，()用于生成器表达式。',
    difficulty: 2,
    tags: ['Python', 'Syntax']
  },
  {
    id: 'python_5',
    language: 'python',
    type: 'single',
    question: 'Python类的构造函数名称是？',
    options: [
      'init',
      'constructor',
      '__init__',
      'main'
    ],
    correctAnswer: '__init__',
    explanation: 'Python类的初始化方法（构造函数）名为__init__。',
    difficulty: 1,
    tags: ['Python', 'OOP']
  },
  {
    id: 'python_6',
    language: 'python',
    type: 'single',
    question: '如何导入模块中的特定函数？',
    options: [
      'import func from module',
      'from module import func',
      'import module.func',
      'using module.func'
    ],
    correctAnswer: 'from module import func',
    explanation: 'from module import func 是从模块中导入特定成员的标准语法。',
    difficulty: 1,
    tags: ['Python', 'Modules']
  },
  {
    id: 'python_7',
    language: 'python',
    type: 'single',
    question: 'Python中lambda关键字用于？',
    options: [
      '定义类',
      '定义匿名函数',
      '导入库',
      '异常处理'
    ],
    correctAnswer: '定义匿名函数',
    explanation: 'lambda关键字用于创建小型的匿名函数。',
    difficulty: 2,
    tags: ['Python', 'Syntax']
  },
  {
    id: 'python_8',
    language: 'python',
    type: 'single',
    question: 'Python中 *args 的作用是？',
    options: [
      '传递键值对参数',
      '传递可变数量的位置参数',
      '指针解引用',
      '乘法运算'
    ],
    correctAnswer: '传递可变数量的位置参数',
    explanation: '*args允许函数接收任意数量的位置参数，它们在函数内部被组织成一个元组。',
    difficulty: 2,
    tags: ['Python', 'Functions']
  },
  {
    id: 'python_9',
    language: 'python',
    type: 'single',
    question: 'GIL (Global Interpreter Lock) 对Python多线程的影响是？',
    options: [
      '加速多线程执行',
      '限制同一时刻只能有一个线程执行Python字节码',
      '自动管理内存',
      '防止死锁'
    ],
    correctAnswer: '限制同一时刻只能有一个线程执行Python字节码',
    explanation: 'GIL确保同一时刻只有一个线程在解释器中运行，这意味着Python多线程无法利用多核CPU进行并行计算（CPU密集型任务）。',
    difficulty: 3,
    tags: ['Python', 'Concurrency']
  },

  // --- C++ Questions ---
  {
    id: 'cpp_1',
    language: 'cpp',
    type: 'single',
    question: 'C++中，用于输出到控制台的标准对象是？',
    options: [
      'cin',
      'cout',
      'print',
      'System.out'
    ],
    correctAnswer: 'cout',
    explanation: 'cout是C++标准库中的标准输出流对象，通常与<<运算符配合使用。',
    difficulty: 1,
    tags: ['C++', 'Basics']
  },
  {
    id: 'cpp_2',
    language: 'cpp',
    type: 'single',
    question: '以下哪个符号表示指针？',
    options: [
      '~',
      '*',
      '&',
      '::'
    ],
    correctAnswer: '*',
    explanation: '在声明变量时，*表示该变量是一个指针；在解引用时，*用于访问指针指向的值。',
    difficulty: 2,
    tags: ['C++', 'Pointers']
  },
  {
    id: 'cpp_3',
    language: 'cpp',
    type: 'single',
    question: 'C++中，析构函数的名称特点是？',
    options: [
      '与类名相同',
      'void',
      '~加上类名',
      'destructor'
    ],
    correctAnswer: '~加上类名',
    explanation: '析构函数的名称是在类名前加上波浪号~，且没有返回值和参数。',
    difficulty: 2,
    tags: ['C++', 'OOP']
  },
  {
    id: 'cpp_4',
    language: 'cpp',
    type: 'single',
    question: '要在C++中动态分配内存，应使用哪个关键字？',
    options: [
      'malloc',
      'alloc',
      'new',
      'create'
    ],
    correctAnswer: 'new',
    explanation: 'new操作符用于在堆上动态分配内存并调用构造函数（如果是对象）。malloc是C语言函数。',
    difficulty: 2,
    tags: ['C++', 'Memory']
  },
  {
    id: 'cpp_5',
    language: 'cpp',
    type: 'single',
    question: '引用（Reference）变量的声明符号是？',
    options: [
      '*',
      '&',
      '->',
      '@'
    ],
    correctAnswer: '&',
    explanation: '在类型声明中使用&符号表示引用，例如 int& ref = a;。',
    difficulty: 2,
    tags: ['C++', 'References']
  },
  {
    id: 'cpp_6',
    language: 'cpp',
    type: 'single',
    question: '实现多态性通常需要使用什么关键字？',
    options: [
      'virtual',
      'static',
      'friend',
      'inline'
    ],
    correctAnswer: 'virtual',
    explanation: 'virtual关键字用于声明虚函数，允许在派生类中重写，从而实现运行时多态。',
    difficulty: 2,
    tags: ['C++', 'OOP']
  },
  {
    id: 'cpp_7',
    language: 'cpp',
    type: 'single',
    question: '头文件包含指令是？',
    options: [
      'import',
      'include',
      '#include',
      'using'
    ],
    correctAnswer: '#include',
    explanation: '#include预处理指令用于将指定文件的内容插入到当前文件中。',
    difficulty: 1,
    tags: ['C++', 'Preprocessor']
  },
  {
    id: 'cpp_8',
    language: 'cpp',
    type: 'single',
    question: 'unique_ptr 和 shared_ptr 的主要区别是？',
    options: [
      'unique_ptr允许共享所有权，shared_ptr独占所有权',
      'unique_ptr独占所有权，shared_ptr允许共享所有权',
      'unique_ptr是旧标准，shared_ptr是新标准',
      '没有区别'
    ],
    correctAnswer: 'unique_ptr独占所有权，shared_ptr允许共享所有权',
    explanation: 'unique_ptr同一时间只能有一个所有者，不可复制；shared_ptr使用引用计数，允许多个指针指向同一对象。',
    difficulty: 3,
    tags: ['C++', 'Memory', 'Smart Pointers']
  },
  {
    id: 'cpp_9',
    language: 'cpp',
    type: 'single',
    question: 'C++中，const_cast主要用于？',
    options: [
      '将int转换为float',
      '移除变量的const或volatile属性',
      '向下转型',
      '静态类型检查'
    ],
    correctAnswer: '移除变量的const或volatile属性',
    explanation: 'const_cast是唯一可以移除const限定符的转换操作符。',
    difficulty: 3,
    tags: ['C++', 'Casting']
  },

  // --- JavaScript Questions ---
  {
    id: 'js_1',
    language: 'javascript',
    type: 'single',
    question: 'JavaScript中，以下哪个值不是Falsy值？',
    options: [
      '0',
      'null',
      'undefined',
      '"false"'
    ],
    correctAnswer: '"false"',
    explanation: '在JS中，非空字符串（包括"false"）都是Truthy值。0、null、undefined、NaN、""和false是Falsy值。',
    difficulty: 1,
    tags: ['JavaScript', 'Basics']
  },
  {
    id: 'js_2',
    language: 'javascript',
    type: 'single',
    question: '如何判断一个变量是数组？',
    options: [
      'typeof arr === "array"',
      'arr instanceof Array',
      'Array.isArray(arr)',
      'Both B and C'
    ],
    correctAnswer: 'Both B and C',
    explanation: 'typeof数组返回"object"。instanceof和Array.isArray()都可以用来判断数组，后者更稳健。',
    difficulty: 1,
    tags: ['JavaScript', 'Types']
  },
  {
    id: 'js_3',
    language: 'javascript',
    type: 'single',
    question: 'ES6中引入的块级作用域变量声明关键字是？',
    options: [
      'var',
      'let',
      'const',
      'Both B and C'
    ],
    correctAnswer: 'Both B and C',
    explanation: 'let和const都具有块级作用域，而var是函数作用域。',
    difficulty: 1,
    tags: ['JavaScript', 'ES6']
  },
  {
    id: 'js_4',
    language: 'javascript',
    type: 'single',
    question: '以下代码输出什么？console.log(1 + "2" + "2");',
    options: [
      '122',
      '32',
      '14',
      'NaN'
    ],
    correctAnswer: '122',
    explanation: '当数字与字符串相加时，JavaScript会将数字强制转换为字符串并进行拼接。',
    difficulty: 1,
    tags: ['JavaScript', 'Coercion']
  },
  {
    id: 'js_5',
    language: 'javascript',
    type: 'single',
    question: '闭包（Closure）的主要特性是？',
    options: [
      '可以访问外部函数的变量',
      '自动内存管理',
      '提升性能',
      '所有函数都是闭包'
    ],
    correctAnswer: '可以访问外部函数的变量',
    explanation: '闭包允许函数访问其词法作用域之外的变量，即使外部函数已经执行完毕。',
    difficulty: 2,
    tags: ['JavaScript', 'Advanced']
  },
  {
    id: 'js_6',
    language: 'javascript',
    type: 'single',
    question: 'Promise.all([p1, p2]) 什么时候reject？',
    options: [
      '当所有Promise都reject时',
      '当任意一个Promise reject时',
      '当所有Promise都resolve时',
      '永远不会reject'
    ],
    correctAnswer: '当任意一个Promise reject时',
    explanation: 'Promise.all采用“快速失败”机制，只要有一个Promise reject，整个Promise.all就会立即reject。',
    difficulty: 2,
    tags: ['JavaScript', 'Async']
  },
  {
    id: 'js_7',
    language: 'javascript',
    type: 'single',
    question: '箭头函数（Arrow Function）中的this指向哪里？',
    options: [
      '调用时的对象',
      '全局对象',
      '定义时所在的词法作用域',
      'undefined'
    ],
    correctAnswer: '定义时所在的词法作用域',
    explanation: '箭头函数没有自己的this，它会捕获其所在上下文的this值，这被称为词法作用域。',
    difficulty: 2,
    tags: ['JavaScript', 'ES6', 'Scope']
  },

  // --- TypeScript Questions ---
  {
    id: 'ts_1',
    language: 'typescript',
    type: 'single',
    question: 'TypeScript中，any类型表示什么？',
    options: [
      '任何类型，跳过类型检查',
      '所有类型的联合',
      '空类型',
      '未定义类型'
    ],
    correctAnswer: '任何类型，跳过类型检查',
    explanation: 'any类型允许变量持有任何值，并会绕过编译器的类型检查，应谨慎使用。',
    difficulty: 1,
    tags: ['TypeScript', 'Types']
  },
  {
    id: 'ts_2',
    language: 'typescript',
    type: 'single',
    question: '如何定义一个只读属性的接口？',
    options: [
      'const prop: type',
      'readonly prop: type',
      'static prop: type',
      'final prop: type'
    ],
    correctAnswer: 'readonly prop: type',
    explanation: '在接口中使用readonly关键字可以将属性标记为只读，初始化后不可修改。',
    difficulty: 1,
    tags: ['TypeScript', 'Interfaces']
  },
  {
    id: 'ts_3',
    language: 'typescript',
    type: 'single',
    question: 'TS中，用于定义联合类型的符号是？',
    options: [
      '&',
      '|',
      '!',
      '?'
    ],
    correctAnswer: '|',
    explanation: '竖线 | 用于定义联合类型（Union Types），表示值可以是几种类型之一。',
    difficulty: 1,
    tags: ['TypeScript', 'Types']
  },
  {
    id: 'ts_4',
    language: 'typescript',
    type: 'single',
    question: '以下哪个是TypeScript特有的特性（JS没有）？',
    options: [
      'Class',
      'Enum',
      'Module',
      'Arrow Function'
    ],
    correctAnswer: 'Enum',
    explanation: 'Enum（枚举）是TypeScript引入的特性，原生JavaScript（ES6之前）没有，ES6+也未直接支持Enum语法。',
    difficulty: 1,
    tags: ['TypeScript', 'Features']
  },
  {
    id: 'ts_5',
    language: 'typescript',
    type: 'single',
    question: 'TS中泛型（Generics）的主要作用是？',
    options: [
      '提高运行时性能',
      '增加代码体积',
      '创建可重用的组件，同时保持类型安全',
      '加密代码'
    ],
    correctAnswer: '创建可重用的组件，同时保持类型安全',
    explanation: '泛型允许在定义函数、接口或类时不预先指定具体的类型，而是在使用时再指定，提高了代码复用性。',
    difficulty: 2,
    tags: ['TypeScript', 'Generics']
  },
  {
    id: 'ts_6',
    language: 'typescript',
    type: 'single',
    question: 'Partial<T>工具类型的作用是？',
    options: [
      '将T的所有属性变为必选',
      '将T的所有属性变为可选',
      '将T的所有属性变为只读',
      '移除T的所有属性'
    ],
    correctAnswer: '将T的所有属性变为可选',
    explanation: 'Partial<T>构造一个类型，该类型包含T的所有子集，即T的所有属性都变为可选的。',
    difficulty: 2,
    tags: ['TypeScript', 'Utility Types']
  },
  {
    id: 'ts_7',
    language: 'typescript',
    type: 'single',
    question: 'unknown 类型和 any 类型的区别是？',
    options: [
      '没有区别',
      'unknown 是类型安全的any，使用前必须进行类型检查',
      'any 是类型安全的unknown',
      'unknown 不能赋值给任何变量'
    ],
    correctAnswer: 'unknown 是类型安全的any，使用前必须进行类型检查',
    explanation: 'unknown表示未知类型，但在对其进行操作之前，必须先进行类型断言或类型收窄，比any更安全。',
    difficulty: 3,
    tags: ['TypeScript', 'Types']
  },

  // --- Go Questions ---
  {
    id: 'go_1',
    language: 'go',
    type: 'single',
    question: 'Go语言中，用于声明包的关键字是？',
    options: [
      'module',
      'pkg',
      'package',
      'namespace'
    ],
    correctAnswer: 'package',
    explanation: '每个Go源文件都必须以package声明开头，表明该文件属于哪个包。',
    difficulty: 1,
    tags: ['Go', 'Basics']
  },
  {
    id: 'go_2',
    language: 'go',
    type: 'single',
    question: 'Go语言支持哪种循环结构？',
    options: [
      'for, while, do-while',
      'only for',
      'for, while',
      'loop'
    ],
    correctAnswer: 'only for',
    explanation: 'Go语言只有for循环，但for可以模拟while和无限循环。',
    difficulty: 1,
    tags: ['Go', 'Control Flow']
  },
  {
    id: 'go_3',
    language: 'go',
    type: 'single',
    question: '在Go中，如何启动一个新的Goroutine？',
    options: [
      'new Thread(func).start()',
      'async func()',
      'go func()',
      'start func()'
    ],
    correctAnswer: 'go func()',
    explanation: '使用go关键字后跟函数调用，即可启动一个新的Goroutine（轻量级线程）。',
    difficulty: 2,
    tags: ['Go', 'Concurrency']
  },
  {
    id: 'go_4',
    language: 'go',
    type: 'single',
    question: 'Go语言中的defer关键字有什么作用？',
    options: [
      '推迟函数执行直到上层函数返回',
      '定义异步函数',
      '声明常量',
      '立即停止程序'
    ],
    correctAnswer: '推迟函数执行直到上层函数返回',
    explanation: 'defer用于注册延迟调用，这些调用直到包含它的函数执行完毕（返回）时才执行，常用于资源释放。',
    difficulty: 2,
    tags: ['Go', 'Keywords']
  },
  {
    id: 'go_5',
    language: 'go',
    type: 'single',
    question: 'Go中的切片（Slice）和数组的区别是？',
    options: [
      '切片是固定长度的，数组是动态的',
      '切片是动态长度的，数组是固定长度的',
      '没有区别',
      '切片不能存储结构体'
    ],
    correctAnswer: '切片是动态长度的，数组是固定长度的',
    explanation: '数组是值类型且长度固定；切片是对数组的引用，长度可变，更灵活。',
    difficulty: 1,
    tags: ['Go', 'Data Structures']
  },
  {
    id: 'go_6',
    language: 'go',
    type: 'single',
    question: 'make 和 new 的区别是？',
    options: [
      'make只用于slice, map, channel; new用于各种类型',
      'make返回指针，new返回引用',
      '没有区别',
      'new用于初始化内置结构'
    ],
    correctAnswer: 'make只用于slice, map, channel; new用于各种类型',
    explanation: 'make用于初始化内置的数据结构（切片、映射、通道）并返回（非零）值；new用于分配内存并返回零值指针。',
    difficulty: 2,
    tags: ['Go', 'Memory']
  },
  {
    id: 'go_7',
    language: 'go',
    type: 'single',
    question: 'Go语言中的interface{}（空接口）代表什么？',
    options: [
      '没有任何方法的接口，可以表示任何类型',
      '空指针',
      '抽象类',
      '错误的语法'
    ],
    correctAnswer: '没有任何方法的接口，可以表示任何类型',
    explanation: '空接口interface{}没有任何方法，因此所有类型都实现了空接口，可以用来存储任意类型的值。',
    difficulty: 2,
    tags: ['Go', 'Interfaces']
  },

  // --- Rust Questions ---
  {
    id: 'rust_1',
    language: 'rust',
    type: 'single',
    question: 'Rust中最核心的内存管理概念是？',
    options: [
      'Garbage Collection',
      'Ownership',
      'Manual Memory Management',
      'Reference Counting'
    ],
    correctAnswer: 'Ownership',
    explanation: 'Ownership（所有权）系统是Rust的核心，它在编译时保证内存安全，无需GC。',
    difficulty: 1,
    tags: ['Rust', 'Core']
  },
  {
    id: 'rust_2',
    language: 'rust',
    type: 'single',
    question: 'Rust中默认的变量可变性是？',
    options: [
      'Mutable (可变)',
      'Immutable (不可变)',
      'Dynamic',
      'Static'
    ],
    correctAnswer: 'Immutable (不可变)',
    explanation: '在Rust中，变量默认是不可变的。如果需要修改，必须使用mut关键字声明。',
    difficulty: 1,
    tags: ['Rust', 'Basics']
  },
  {
    id: 'rust_3',
    language: 'rust',
    type: 'single',
    question: 'Rust中用于模式匹配的强大控制流运算符是？',
    options: [
      'switch',
      'match',
      'case',
      'select'
    ],
    correctAnswer: 'match',
    explanation: 'match表达式允许将一个值与一系列模式进行比较，并根据匹配的模式执行代码，比switch更强大。',
    difficulty: 1,
    tags: ['Rust', 'Control Flow']
  },
  {
    id: 'rust_4',
    language: 'rust',
    type: 'single',
    question: 'Rust的包管理和构建工具是？',
    options: [
      'npm',
      'pip',
      'cargo',
      'maven'
    ],
    correctAnswer: 'cargo',
    explanation: 'Cargo是Rust的官方构建系统和包管理器。',
    difficulty: 1,
    tags: ['Rust', 'Tools']
  },
  {
    id: 'rust_5',
    language: 'rust',
    type: 'single',
    question: 'Rust中，&mut T表示什么？',
    options: [
      '不可变引用',
      '可变引用',
      '解引用',
      '静态引用'
    ],
    correctAnswer: '可变引用',
    explanation: '&mut T表示对类型T的可变引用，允许借用方修改数据。',
    difficulty: 2,
    tags: ['Rust', 'References']
  },
  {
    id: 'rust_6',
    language: 'rust',
    type: 'single',
    question: 'Rust中的Result<T, E>枚举主要用于？',
    options: [
      '循环控制',
      '错误处理',
      '内存分配',
      '并发编程'
    ],
    correctAnswer: '错误处理',
    explanation: 'Result<T, E>用于返回可能失败的操作结果，Ok(T)表示成功，Err(E)表示失败。',
    difficulty: 2,
    tags: ['Rust', 'Error Handling']
  },
  {
    id: 'rust_7',
    language: 'rust',
    type: 'single',
    question: 'String 和 &str 的区别是？',
    options: [
      'String是堆分配的可变字符串，&str是字符串切片',
      'String是栈分配，&str是堆分配',
      '没有区别',
      'String是不可变的'
    ],
    correctAnswer: 'String是堆分配的可变字符串，&str是字符串切片',
    explanation: 'String是拥有所有权的、可增长的堆字符串；&str是对字符串数据的借用（引用/切片），通常是不可变的。',
    difficulty: 2,
    tags: ['Rust', 'Strings']
  },

  // --- Swift Questions ---
  {
    id: 'swift_1',
    language: 'swift',
    type: 'single',
    question: 'Swift中用于声明常量的关键字是？',
    options: [
      'var',
      'let',
      'const',
      'final'
    ],
    correctAnswer: 'let',
    explanation: 'Swift使用let声明常量，var声明变量。',
    difficulty: 1,
    tags: ['Swift', 'Basics']
  },
  {
    id: 'swift_2',
    language: 'swift',
    type: 'single',
    question: 'Swift中的Optional类型用于处理什么情况？',
    options: [
      '多线程',
      '值可能缺失（nil）',
      '网络请求',
      '泛型'
    ],
    correctAnswer: '值可能缺失（nil）',
    explanation: 'Optional（可选类型）用于处理值可能不存在的情况，是Swift安全性的重要体现。',
    difficulty: 1,
    tags: ['Swift', 'Types']
  },
  {
    id: 'swift_3',
    language: 'swift',
    type: 'single',
    question: 'Struct和Class在Swift中的主要区别是？',
    options: [
      'Struct是引用类型，Class是值类型',
      'Struct是值类型，Class是引用类型',
      '没有区别',
      'Struct不支持方法'
    ],
    correctAnswer: 'Struct是值类型，Class是引用类型',
    explanation: 'Struct（结构体）是值类型，传递时会复制；Class（类）是引用类型，传递时传递引用。',
    difficulty: 2,
    tags: ['Swift', 'OOP']
  },
  {
    id: 'swift_4',
    language: 'swift',
    type: 'single',
    question: 'Swift中强制解包Optional使用的符号是？',
    options: [
      '?',
      '!',
      '#',
      '@'
    ],
    correctAnswer: '!',
    explanation: '在Optional变量后加!可以强制解包，但如果值为nil会导致崩溃。',
    difficulty: 1,
    tags: ['Swift', 'Syntax']
  },
  {
    id: 'swift_5',
    language: 'swift',
    type: 'single',
    question: 'Swift UI框架是声明式还是命令式？',
    options: [
      '命令式',
      '声明式',
      '函数式',
      '逻辑式'
    ],
    correctAnswer: '声明式',
    explanation: 'SwiftUI（以及Flutter, ArkUI等现代UI框架）采用声明式语法来构建用户界面。',
    difficulty: 1,
    tags: ['Swift', 'UI']
  },
  {
    id: 'swift_6',
    language: 'swift',
    type: 'single',
    question: 'guard 语句的主要用途是？',
    options: [
      '循环控制',
      '提前退出（Early Exit）以确保条件满足',
      '定义类',
      '加密数据'
    ],
    correctAnswer: '提前退出（Early Exit）以确保条件满足',
    explanation: 'guard语句用于校验条件，如果条件不满足则执行else块（通常包含return或throw），常用于解包Optional。',
    difficulty: 2,
    tags: ['Swift', 'Control Flow']
  },
  {
    id: 'swift_7',
    language: 'swift',
    type: 'single',
    question: 'defer 语句块中的代码何时执行？',
    options: [
      '立即执行',
      '在当前作用域退出之前执行',
      '异步执行',
      '手动调用时执行'
    ],
    correctAnswer: '在当前作用域退出之前执行',
    explanation: 'defer块中的代码会在当前作用域（如函数）结束前最后执行，无论函数是正常返回还是抛出错误。',
    difficulty: 2,
    tags: ['Swift', 'Keywords']
  },

  // --- Kotlin Questions ---
  {
    id: 'kotlin_1',
    language: 'kotlin',
    type: 'single',
    question: 'Kotlin中，如何定义一个不可为null的变量？',
    options: [
      'var x: String?',
      'var x: String',
      'val x: String?',
      'Nullable<String> x'
    ],
    correctAnswer: 'var x: String',
    explanation: 'Kotlin默认类型不可为null。String?表示可为null，String表示不可为null。',
    difficulty: 1,
    tags: ['Kotlin', 'Null Safety']
  },
  {
    id: 'kotlin_2',
    language: 'kotlin',
    type: 'single',
    question: 'Kotlin完全兼容哪种语言？',
    options: [
      'Python',
      'C++',
      'Java',
      'Swift'
    ],
    correctAnswer: 'Java',
    explanation: 'Kotlin设计为与Java完全互操作，可以无缝调用Java代码库。',
    difficulty: 1,
    tags: ['Kotlin', 'General']
  },
  {
    id: 'kotlin_3',
    language: 'kotlin',
    type: 'single',
    question: '用于异步编程的Kotlin特性是？',
    options: [
      'Threads',
      'Coroutines',
      'Promises',
      'Tasks'
    ],
    correctAnswer: 'Coroutines',
    explanation: 'Coroutines（协程）是Kotlin提供的轻量级线程解决方案，用于简化异步编程。',
    difficulty: 2,
    tags: ['Kotlin', 'Concurrency']
  },
  {
    id: 'kotlin_4',
    language: 'kotlin',
    type: 'single',
    question: 'Kotlin中的data class主要用于？',
    options: [
      '定义UI组件',
      '只保存数据的类，自动生成toString, equals等方法',
      '定义单例',
      '数据库操作'
    ],
    correctAnswer: '只保存数据的类，自动生成toString, equals等方法',
    explanation: 'data class专门用于存储数据，编译器会自动为它生成标准方法。',
    difficulty: 1,
    tags: ['Kotlin', 'OOP']
  },
  {
    id: 'kotlin_5',
    language: 'kotlin',
    type: 'single',
    question: 'Kotlin中定义函数的关键字是？',
    options: [
      'func',
      'def',
      'fun',
      'function'
    ],
    correctAnswer: 'fun',
    explanation: 'Kotlin使用fun关键字来定义函数。',
    difficulty: 1,
    tags: ['Kotlin', 'Syntax']
  },
  {
    id: 'kotlin_6',
    language: 'kotlin',
    type: 'single',
    question: 'Kotlin中的object关键字用于？',
    options: [
      '定义类',
      '定义接口',
      '定义单例（Singleton）',
      '定义变量'
    ],
    correctAnswer: '定义单例（Singleton）',
    explanation: 'object关键字用于声明一个类并同时创建一个实例（单例模式）。',
    difficulty: 2,
    tags: ['Kotlin', 'Keywords']
  },
  {
    id: 'kotlin_7',
    language: 'kotlin',
    type: 'single',
    question: 'Kotlin中 ?. 操作符的作用是？',
    options: [
      '强制解包',
      '安全调用（Safe Call）',
      'Elvis操作符',
      '类型转换'
    ],
    correctAnswer: '安全调用（Safe Call）',
    explanation: '?.用于安全调用，如果对象为null，则不执行后续调用并返回null，避免NPE。',
    difficulty: 1,
    tags: ['Kotlin', 'Syntax']
  }
];
