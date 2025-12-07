// ============================================
// FILE: lib/data/final_quiz_data.dart
// ============================================

import '../models/lesson.dart'; // Import Lesson which now holds QuestionType

final List<Question> finalQuizQuestions = const [
  //======= IMPERATIVE PROGRAMMING =======
  Question(
    question: 'What type would you use to store a true/false value in Java?',
    options: ['int', 'boolean', 'String', 'double'],
    correctAnswer: 'boolean',
    explanation: 'The boolean type represents logical true/false values in Java.',
    type: QuestionType.multipleChoice,
  ),
  Question(
    question: 'Fill in the blank: The statement if (score > 10) { ... } is an ______ statement.',
    correctAnswer: 'if',
    explanation: 'An if statement allows conditional execution based on a Boolean condition.',
    type: QuestionType.fillBlank,
  ),
  Question(
    question: 'Which loop ensures the body runs at least once, even if the condition is false?',
    options: ['for loop', 'while loop', 'do-while loop', 'foreach loop'],
    correctAnswer: 'do-while loop',
    explanation: 'The do-while loop evaluates the condition after running the body, so it executes at least once.',
    type: QuestionType.multipleChoice,
  ),
  Question(
    question: 'True or False: In Java, arrays are indexed starting at 0.',
    correctAnswer: 'true',
    explanation: 'Java arrays use zero-based indexing, so the first element is at index 0.',
    type: QuestionType.trueFalse,
  ),
  Question(
    question: 'Match each control statement to its purpose.',
    type: QuestionType.matching,
    options: [
      'Decides based on condition',
      'Loops with known count',
      'Skips the rest of current iteration',
      'Exits a loop early',
    ],
    matchingPairs: {
      'if-else': 'Decides based on condition',
      'for': 'Loops with known count',
      'continue': 'Skips the rest of current iteration',
      'break': 'Exits a loop early',
    },
    correctAnswer: '',
    explanation: 'Each control statement matches a key use case in imperative programming.',
  ),

  //======= OBJECT-ORIENTED PROGRAMMING =======
  Question(
    question: 'Which OOP principle involves using private fields and public methods?',
    options: ['Inheritance', 'Encapsulation', 'Polymorphism', 'Abstraction'],
    correctAnswer: 'Encapsulation',
    explanation: 'Encapsulation means hiding internal details and providing controlled access.',
    type: QuestionType.multipleChoice,
  ),
  Question(
    question: 'Fill in the blank: Inheritance enables a class to reuse ______ from another class.',
    correctAnswer: 'properties',
    explanation: 'Inheritance allows one class to reuse code from another.',
    type: QuestionType.fillBlank,
  ),
  Question(
    question: 'What Java keyword is used to establish inheritance?',
    options: ['inherits', 'extends', 'implements', 'super'],
    correctAnswer: 'extends',
    explanation: 'The extends keyword creates inheritance relationships.',
    type: QuestionType.multipleChoice,
  ),
  Question(
    question: 'True or False: Objects are instances of classes in Java.',
    correctAnswer: 'true',
    explanation: 'A class is a blueprint; objects are instances.',
    type: QuestionType.trueFalse,
  ),
  Question(
    question: 'Match each OOP concept with its definition.',
    type: QuestionType.matching,
    options: [
      'Wrapping data and methods together',
      'Using inherited code',
      'Multiple behaviors from one interface',
      'Hiding complex implementation',
    ],
    matchingPairs: {
      'Encapsulation': 'Wrapping data and methods together',
      'Inheritance': 'Using inherited code',
      'Polymorphism': 'Multiple behaviors from one interface',
      'Abstraction': 'Hiding complex implementation',
    },
    correctAnswer: '',
    explanation: 'These map directly to the four main OOP principles.',
  ),

  //======= CLASSES IN DETAIL =======
  Question(
    question: 'What is the primary purpose of a constructor in Java?',
    options: ['To destroy objects', 'To initialize objects', 'To inherit properties', 'To define variables'],
    correctAnswer: 'To initialize objects',
    explanation: 'Constructors set up the initial state for an object.',
    type: QuestionType.multipleChoice,
  ),
  Question(
    question: 'Fill in the blank: The ______ keyword creates a field or method that belongs to the class rather than objects.',
    correctAnswer: 'static',
    explanation: 'static makes a member belong to the class instead of an object.',
    type: QuestionType.fillBlank,
  ),
  Question(
    question: 'Which member of a Java class can be accessed without creating an object?',
    options: ['Instance variable', 'Instance method', 'Static field or method', 'Constructor'],
    correctAnswer: 'Static field or method',
    explanation: 'Static members are called using the class name and exist without objects.',
    type: QuestionType.multipleChoice,
  ),
  Question(
    question: 'True or False: A Java class can have multiple constructors as long as their parameters are different.',
    correctAnswer: 'true',
    explanation: 'Constructor overloading allows multiple constructors with different parameter lists.',
    type: QuestionType.trueFalse,
  ),
  Question(
    question: 'Match each class component to its role.',
    type: QuestionType.matching,
    options: [
      'Initializes object',
      'Stores data',
      'Contains logic',
      'Represents instance',
    ],
    matchingPairs: {
      'Constructor': 'Initializes object',
      'Field': 'Stores data',
      'Method': 'Contains logic',
      'Object': 'Represents instance',
    },
    correctAnswer: '',
    explanation: 'The constructor, field, method, and object serve different roles in a class.',
  ),

  //======= METHODS =======
  Question(
    question: 'What does the keyword void indicate in a Java method declaration?',
    options: ['No parameters', 'No return value', 'Private method', 'Overloaded method'],
    correctAnswer: 'No return value',
    explanation: 'void means the method does not return a value.',
    type: QuestionType.multipleChoice,
  ),
  Question(
    question: 'Fill in the blank: Passing different arguments to overloaded methods is called ______.',
    correctAnswer: 'overloading',
    explanation: 'Method overloading allows several methods with the same name and different parameters.',
    type: QuestionType.fillBlank,
  ),
  Question(
    question: 'Which Java keyword is used to return a value from a method?',
    options: ['get', 'set', 'return', 'break'],
    correctAnswer: 'return',
    explanation: 'The return keyword exits the method and gives a value back.',
    type: QuestionType.multipleChoice,
  ),
  Question(
    question: 'True or False: Methods in Java can have the same name if their parameter lists are different.',
    correctAnswer: 'true',
    explanation: 'This is method overloading; only the parameter list must change.',
    type: QuestionType.trueFalse,
  ),
  Question(
    question: 'Match each method component to its purpose.',
    type: QuestionType.matching,
    options: [
      'Name of the method',
      'What it gives back',
      'Values it receives',
      'Code that runs',
    ],
    matchingPairs: {
      'Method name': 'Name of the method',
      'Return type': 'What it gives back',
      'Parameters': 'Values it receives',
      'Body': 'Code that runs',
    },
    correctAnswer: '',
    explanation: 'Each part of a method serves a specific purpose in Java.',
  ),

  //======= DATA STRUCTURES =======
  Question(
    question: 'Which Java collection should you use for fast lookup using unique keys?',
    options: ['Array', 'ArrayList', 'HashMap', 'Stack'],
    correctAnswer: 'HashMap',
    explanation: 'HashMap provides fast key-value lookups by using unique keys.',
    type: QuestionType.multipleChoice,
  ),
  Question(
    question: 'Fill in the blank: The first element of a Java array is at index ______.',
    correctAnswer: '0',
    explanation: 'Java arrays are zero-indexed: first element is at position 0.',
    type: QuestionType.fillBlank,
  ),
  Question(
    question: 'Which data structure can increase or decrease in size automatically?',
    options: ['Array', 'ArrayList', 'HashMap', 'int[]'],
    correctAnswer: 'ArrayList',
    explanation: 'ArrayList can change its size dynamically.',
    type: QuestionType.multipleChoice,
  ),
  Question(
    question: 'True or False: You can store different data types in the same Java array.',
    correctAnswer: 'false',
    explanation: 'Java arrays only store elements of one type.',
    type: QuestionType.trueFalse,
  ),
  Question(
    question: 'Match each data structure to its key trait.',
    type: QuestionType.matching,
    options: [
      'Fixed size',
      'Dynamic size',
      'Key-value storage',
      'LIFO order',
    ],
    matchingPairs: {
      'Array': 'Fixed size',
      'ArrayList': 'Dynamic size',
      'HashMap': 'Key-value storage',
      'Stack': 'LIFO order',
    },
    correctAnswer: '',
    explanation: 'Each data structure has a unique feature for storing/accessing data.',
  ),
];