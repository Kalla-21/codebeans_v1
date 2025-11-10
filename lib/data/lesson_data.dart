import '../models/lesson.dart';

List<Lesson> initialLessons = [
  // Lesson 1: Imperative Programming
  Lesson(
    id: 'java_001',
    title: 'Imperative Programming',
    description: 'Learn the basics of imperative programming in Java',
    subTopics: [
      SubTopic(
        title: 'Variables & Data Types',
        content: 'In Java, variables are containers for storing data values. Java has different data types:\n\n• Primitive types: int, double, boolean, char\n• Reference types: String, arrays, objects\n\nExample:\nint age = 25;\nString name = "John";\nboolean isStudent = true;',
      ),
      SubTopic(
        title: 'Control Flow',
        content: 'Control flow statements determine the order in which code executes:\n\n• if-else: Make decisions\n• switch: Multiple choice selection\n• Conditional operators: &&, ||, !\n\nExample:\nif (age >= 18) {\n    System.out.println("Adult");\n} else {\n    System.out.println("Minor");\n}',
      ),
      SubTopic(
        title: 'Loops',
        content: 'Loops allow you to repeat code multiple times:\n\n• for loop: Known number of iterations\n• while loop: Condition-based repetition\n• do-while loop: Execute at least once\n\nExample:\nfor (int i = 0; i < 5; i++) {\n    System.out.println(i);\n}',
      ),
    ],
    questions: [
      Question(
        question: 'What type would you use to store a whole number in Java?',
        type: QuestionType.multipleChoice,
        options: [
          'int',
          'String',
          'boolean',
          'double'
        ],
        correctAnswer: 'int',
        explanation: 'int stores whole numbers, while double is for decimals, boolean is true/false, and String is text.',
      ),
      Question(
        question:
        'Fill in the blank: The statement if (x > 10) { ... } is called a(n) ______ statement.',
        type: QuestionType.fillBlank,
        correctAnswer: 'if',
        explanation: 'if statements allow conditional execution based on whether a condition is true.',
      ),
      Question(
        question: 'Which loop guarantees at least one execution of its body?',
        type: QuestionType.multipleChoice,
        options: [
          'for loop',
          'while loop',
          'do-while loop',
          'for each'
        ],
        correctAnswer: 'do-while loop',
        explanation: 'A do-while loop checks its condition after running the body once, so it always executes at least once.',
      ),
      Question(
        question: 'True or False: In Java, arrays start their index at 1.',
        type: QuestionType.trueFalse,
        correctAnswer: 'false',
        explanation: 'Java arrays are zero-indexed, so the first element is at index 0.',
      ),
      Question(
        question: 'Match each control flow concept with its purpose.',
        type: QuestionType.matching,
        options: [
          'Decision making',
          'Repetition (fixed count)',
          'Early exit from loop',
          'Skip to next iteration',
        ],
        matchingPairs: {
          'if-else': 'Decision making',
          'for': 'Repetition (fixed count)',
          'break': 'Early exit from loop',
          'continue': 'Skip to next iteration',
        },
        correctAnswer: '',
        explanation: 'Each control flow feature matches a common programming purpose: if-else for decisions, for for counting, break to exit early, and continue to skip to the next iteration.',
      ),
    ],
    isCompleted: false,
  ),

  // Lesson 2: Object-Oriented Programming
  Lesson(
    id: 'java_002',
    title: 'Object-Oriented Programming',
    description: 'Master the principles of OOP in Java',
    subTopics: [
      SubTopic(
        title: 'Classes & Objects',
        content: 'A class is a blueprint for creating objects. Objects are instances of classes.\n\n• Class: Template/Blueprint\n• Object: Instance created from class\n• new keyword: Creates objects\n\nExample:\nclass Dog {\n    String name;\n    int age;\n}\n\nDog myDog = new Dog();',
      ),
      SubTopic(
        title: 'Encapsulation',
        content: 'Encapsulation is hiding data within a class and providing controlled access:\n\n• private fields\n• public getter/setter methods\n• Data protection\n\nExample:\nclass Person {\n    private String name;\n    \n    public String getName() {\n        return name;\n    }\n}',
      ),
      SubTopic(
        title: 'Inheritance & Polymorphism',
        content: 'Inheritance allows classes to inherit properties from other classes. Polymorphism allows objects to take many forms.\n\n• extends keyword\n• Parent-child relationship\n• Method overriding\n\nExample:\nclass Animal { }\nclass Dog extends Animal { }',
      ),
    ],
    questions: [
      Question(
        question: 'A _____ is a blueprint for creating objects in Java.',
        type: QuestionType.fillBlank,
        correctAnswer: 'class',
        explanation: 'A class defines structure and behavior.',
      ),
      Question(
        question: 'What keyword is used to create an instance from a class?',
        type: QuestionType.fillBlank,
        correctAnswer: 'new',
        explanation: 'The "new" keyword allocates and constructs.',
      ),
      Question(
        question: 'Which access modifier makes a field visible only within its class?',
        type: QuestionType.multipleChoice,
        options: ['public', 'private', 'protected', 'default'],
        correctAnswer: 'private',
        explanation: 'private restricts to the declaring class.',
      ),
      Question(
        question: 'What keyword is used to inherit from another class?',
        type: QuestionType.multipleChoice,
        options: ['inherits', 'extends', 'implements', 'super'],
        correctAnswer: 'extends',
        explanation: 'extends sets up parent-child inheritance.',
      ),
      Question(
        question: 'Match the class concept with its role.',
        type: QuestionType.matching,
        options: [
          'Initializes object',
          'Stores data',
          'Performs actions',
          'An object created from a class',
        ],
        matchingPairs: {
          'Constructor': 'Initializes object',
          'Field': 'Stores data',
          'Method': 'Performs actions',
          'Instance': 'An object created from a class',
        },
        correctAnswer: '',
        explanation: 'Typical responsibilities of class parts.',
      ),
    ],
    isCompleted: false,
  ),

  // Lesson 3: Classes in Detail
  Lesson(
    id: 'java_003',
    title: 'Classes in Detail',
    description: 'Deep dive into Java classes and their components',
    subTopics: [
      SubTopic(
        title: 'Constructors',
        content: 'Constructors are special methods that initialize objects:\n\n• Same name as class\n• No return type\n• Called with "new" keyword\n• Can be overloaded\n\nExample:\nclass Car {\n    String model;\n    \n    Car(String m) {\n        model = m;\n    }\n}',
      ),
      SubTopic(
        title: 'Static Members',
        content: 'Static members belong to the class, not instances:\n\n• static keyword\n• Shared across all objects\n• Called using class name\n\nExample:\nclass Math {\n    static double PI = 3.14159;\n    \n    static int add(int a, int b) {\n        return a + b;\n    }\n}',
      ),
      SubTopic(
        title: 'Inner Classes',
        content: 'Classes can be defined inside other classes:\n\n• Inner class: Inside another class\n• Static nested class\n• Local class: Inside a method\n• Anonymous class\n\nExample:\nclass Outer {\n    class Inner {\n        // Inner class code\n    }\n}',
      ),
    ],
    questions: [
      Question(
        question: 'What is the purpose of a constructor?',
        type: QuestionType.multipleChoice,
        options: ['To destroy objects', 'To initialize objects', 'To inherit classes', 'To create methods'],
        correctAnswer: 'To initialize objects',
        explanation: 'Constructors set up initial state.',
      ),
      Question(
        question: 'True or False: A constructor has a return type.',
        type: QuestionType.trueFalse,
        correctAnswer: 'false',
        explanation: 'Constructors have no return type.',
      ),
      Question(
        question: 'Which keyword creates a member shared across all instances?',
        type: QuestionType.fillBlank,
        correctAnswer: 'static',
        explanation: 'static members belong to the class.',
      ),
      Question(
        question: 'How do you call a static method calculate() of class Math?',
        type: QuestionType.multipleChoice,
        options: ['Math.calculate()', 'new Math().calculate()', 'Math->calculate()', 'calculate.Math()'],
        correctAnswer: 'Math.calculate()',
        explanation: 'Static members are accessed via the class name.',
      ),
      Question(
        question: 'True or False: A class may have multiple constructors with different parameters.',
        type: QuestionType.trueFalse,
        correctAnswer: 'true',
        explanation: 'Constructor overloading is allowed.',
      ),
    ],
    isCompleted: false,
  ),

  // Lesson 4: Methods
  Lesson(
    id: 'java_004',
    title: 'Methods',
    description: 'Understanding methods and their usage in Java',
    subTopics: [
      SubTopic(
        title: 'Method Declaration',
        content: 'Methods are blocks of code that perform specific tasks:\n\n• Access modifier (public, private)\n• Return type (or void)\n• Method name\n• Parameters (optional)\n• Method body\n\nExample:\npublic int add(int a, int b) {\n    return a + b;\n}',
      ),
      SubTopic(
        title: 'Method Overloading',
        content: 'Method overloading allows multiple methods with the same name but different parameters:\n\n• Same method name\n• Different parameter lists\n• Return type can differ\n\nExample:\nint add(int a, int b) { }\ndouble add(double a, double b) { }\nint add(int a, int b, int c) { }',
      ),
      SubTopic(
        title: 'Pass by Value',
        content: 'Java is strictly pass-by-value:\n\n• Primitive types: Copy of value passed\n• Objects: Copy of reference passed\n• Original variables unchanged (primitives)\n\nExample:\nvoid modify(int x) {\n    x = 10; // Original not changed\n}',
      ),
    ],
    questions: [
      Question(
        question: 'What does "void" mean in a method declaration?',
        type: QuestionType.multipleChoice,
        options: [
          'The method is empty',
          'The method returns nothing',
          'The method is private',
          'The method has no parameters'
        ],
        correctAnswer: 'The method returns nothing',
        explanation: 'void indicates no return value.',
      ),
      Question(
        question: 'When multiple methods share a name but differ in parameters, it is called _____.',
        type: QuestionType.fillBlank,
        correctAnswer: 'overloading',
        explanation: 'Overloading varies the parameter list.',
      ),
      Question(
        question: 'Which of these is a valid method declaration?',
        type: QuestionType.multipleChoice,
        options: ['public void myMethod()', 'void public myMethod()', 'myMethod() public void', 'public myMethod void()'],
        correctAnswer: 'public void myMethod()',
        explanation: 'Order: access-modifier, return-type, name, params.',
      ),
      Question(
        question: 'In Java, primitive types are passed by _____.',
        type: QuestionType.multipleChoice,
        options: ['value', 'reference'],
        correctAnswer: 'value',
        explanation: 'Primitives pass copies of values.',
      ),
      Question(
        question: 'True or False: Two overloaded methods may differ only in return type.',
        type: QuestionType.trueFalse,
        correctAnswer: 'false',
        explanation: 'They must differ in parameter lists.',
      ),
    ],
    isCompleted: false,
  ),

  // Lesson 5: Data Structures
  Lesson(
    id: 'java_005',
    title: 'Data Structures',
    description: 'Learn fundamental data structures in Java',
    subTopics: [
      SubTopic(
        title: 'Arrays',
        content: 'Arrays are fixed-size containers for storing multiple values:\n\n• Fixed size\n• Same data type\n• Zero-indexed\n• Fast access\n\nExample:\nint[] numbers = new int[5];\nString[] names = {"Alice", "Bob"};\nnumbers[0] = 10;',
      ),
      SubTopic(
        title: 'ArrayList',
        content: 'ArrayList is a dynamic array that can grow or shrink:\n\n• Dynamic size\n• Part of Collections framework\n• Methods: add, remove, get, size\n\nExample:\nArrayList<String> list = new ArrayList<>();\nlist.add("Hello");\nlist.remove(0);',
      ),
      SubTopic(
        title: 'HashMap',
        content: 'HashMap stores key-value pairs:\n\n• Key-value storage\n• Fast lookup\n• No duplicate keys\n• Methods: put, get, remove\n\nExample:\nHashMap<String, Integer> map = new HashMap<>();\nmap.put("age", 25);\nint age = map.get("age");',
      ),
    ],
    questions: [
      Question(
        question: 'How do you declare an array of integers with size 10?',
        type: QuestionType.multipleChoice,
        options: [
          'int[] arr = new int[10]',
          'int arr[10]',
          'array<int> arr = 10',
          'int[10] arr'
        ],
        correctAnswer: 'int[] arr = new int[10]',
        explanation: 'Java uses new int[size] syntax.',
      ),
      Question(
        question: 'What is the index of the first element in an array?',
        type: QuestionType.identification,
        correctAnswer: '0',
        explanation: 'Arrays are zero-indexed.',
      ),
      Question(
        question: 'Which collection allows dynamic resizing?',
        type: QuestionType.multipleChoice,
        options: ['Array', 'ArrayList', 'Both', 'Neither'],
        correctAnswer: 'ArrayList',
        explanation: 'ArrayList grows and shrinks at runtime.',
      ),
      Question(
        question: 'In HashMap, each entry consists of a _____ and a _____.',
        type: QuestionType.fillBlank,
        correctAnswer: 'key and value',
        explanation: 'HashMap stores key-value pairs.',
      ),
      Question(
        question: 'A stack follows which access order?',
        type: QuestionType.multipleChoice,
        options: ['FIFO', 'LIFO', 'Random', 'Sorted'],
        correctAnswer: 'LIFO',
        explanation: 'Stack is Last-In, First-Out.',
      ),
    ],
    isCompleted: false,
  ),
];
