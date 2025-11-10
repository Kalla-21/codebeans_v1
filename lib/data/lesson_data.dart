import '../models/lesson.dart';

const List<Lesson> initialLessons = [
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
        question: 'What will this code print?\nint x = 5;\nx = x + 3;\nSystem.out.println(x);',
        options: ['5', '8', '3', '53'],
        correctAnswer: '8',
        explanation: 'The variable x starts at 5, then adds 3 to become 8, which is what gets printed.',
        type: QuestionType.multipleChoice,
      ),
      Question(
        question: 'Which loop executes at least once regardless of the condition?',
        options: ['for loop', 'while loop', 'do-while loop', 'foreach loop'],
        correctAnswer: 'do-while loop',
        explanation: 'The do-while loop checks the condition after executing the code block, ensuring at least one execution.',
        type: QuestionType.multipleChoice,
      ),
      Question(
        question: 'What is the correct syntax for an if statement in Java?',
        options: ['if x > 5 then', 'if (x > 5)', 'if x > 5:', 'if [x > 5]'],
        correctAnswer: 'if (x > 5)',
        explanation: 'Java uses parentheses around conditions and curly braces for the code block.',
        type: QuestionType.multipleChoice,
      ),
      Question(
        question: 'Which data type would you use to store the value 3.14?',
        options: ['int', 'double', 'boolean', 'char'],
        correctAnswer: 'double',
        explanation: 'double is used for decimal numbers, while int is only for whole numbers.',
        type: QuestionType.multipleChoice,
      ),
      Question(
        question: 'What operator is used for "AND" logic in Java?',
        options: ['&', '&&', 'AND', 'and'],
        correctAnswer: '&&',
        explanation: 'The && operator performs a logical AND operation, checking if both conditions are true.',
        type: QuestionType.multipleChoice,
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
        question: 'Fill in the blank: A _____ is a blueprint for creating objects in Java.',
        correctAnswer: 'class',
        explanation: 'A class serves as a blueprint or template that defines the structure and behavior for creating objects.',
        type: QuestionType.fillBlank,
      ),
      Question(
        question: 'What keyword is used to create a new object from a class?',
        correctAnswer: 'new',
        explanation: 'The "new" keyword allocates memory and creates an instance of a class.',
        type: QuestionType.fillBlank,
      ),
      Question(
        question: 'Which OOP principle is about hiding data inside a class?',
        options: ['Encapsulation', 'Inheritance', 'Polymorphism', 'Abstraction'],
        correctAnswer: 'Encapsulation',
        explanation: 'Encapsulation protects data by keeping it private and providing controlled access through methods.',
        type: QuestionType.multipleChoice,
      ),
      Question(
        question: 'What keyword is used to inherit from another class?',
        options: ['inherits', 'extends', 'implements', 'super'],
        correctAnswer: 'extends',
        explanation: 'The extends keyword creates an inheritance relationship between a child class and parent class.',
        type: QuestionType.multipleChoice,
      ),
      Question(
        question: 'Which access modifier makes a field accessible only within its own class?',
        options: ['public', 'private', 'protected', 'default'],
        correctAnswer: 'private',
        explanation: 'The private modifier restricts access to only within the class itself, supporting encapsulation.',
        type: QuestionType.multipleChoice,
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
        options: ['To destroy objects', 'To initialize objects', 'To inherit classes', 'To create methods'],
        correctAnswer: 'To initialize objects',
        explanation: 'Constructors are called when an object is created to set up its initial state.',
        type: QuestionType.multipleChoice,
      ),
      Question(
        question: 'True or False: A constructor has a return type.',
        options: ['True', 'False'],
        correctAnswer: 'False',
        explanation: 'Constructors do not have return types, not even void. They are special methods for initialization.',
        type: QuestionType.multipleChoice,
      ),
      Question(
        question: 'Which keyword is used to create a class member that is shared by all instances?',
        correctAnswer: 'static',
        explanation: 'The static keyword creates members that belong to the class itself rather than individual objects.',
        type: QuestionType.fillBlank,
      ),
      Question(
        question: 'How do you access a static method named "calculate" in a class named "Math"?',
        options: ['Math.calculate()', 'new Math().calculate()', 'Math->calculate()', 'calculate.Math()'],
        correctAnswer: 'Math.calculate()',
        explanation: 'Static methods are called using the class name followed by a dot and the method name.',
        type: QuestionType.multipleChoice,
      ),
      Question(
        question: 'Can a class have multiple constructors?',
        options: ['Yes', 'No'],
        correctAnswer: 'Yes',
        explanation: 'Constructor overloading allows a class to have multiple constructors with different parameters.',
        type: QuestionType.multipleChoice,
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
        options: ['The method is empty', 'The method returns nothing', 'The method is private', 'The method has no parameters'],
        correctAnswer: 'The method returns nothing',
        explanation: 'The void keyword indicates that a method does not return any value to the caller.',
        type: QuestionType.multipleChoice,
      ),
      Question(
        question: 'What is it called when multiple methods have the same name but different parameters?',
        correctAnswer: 'overloading',
        explanation: 'Method overloading allows multiple methods with the same name but different parameter lists.',
        type: QuestionType.fillBlank,
      ),
      Question(
        question: 'Which of these is a valid method declaration?',
        options: ['public void myMethod()', 'void public myMethod()', 'myMethod() public void', 'public myMethod void()'],
        correctAnswer: 'public void myMethod()',
        explanation: 'The correct order is: access-modifier return-type method-name parentheses.',
        type: QuestionType.multipleChoice,
      ),
      Question(
        question: 'In Java, are primitive types passed by value or reference?',
        options: ['By value', 'By reference'],
        correctAnswer: 'By value',
        explanation: 'Java passes primitives by value, meaning a copy of the value is passed to methods.',
        type: QuestionType.multipleChoice,
      ),
      Question(
        question: 'Can two overloaded methods differ only in return type?',
        options: ['Yes', 'No'],
        correctAnswer: 'No',
        explanation: 'Overloaded methods must differ in their parameter lists, not just return type.',
        type: QuestionType.multipleChoice,
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
        options: ['int[] arr = new int[10]', 'int arr[10]', 'array<int> arr = 10', 'int[10] arr'],
        correctAnswer: 'int[] arr = new int[10]',
        explanation: 'The correct syntax uses int[] followed by the variable name and new int[size].',
        type: QuestionType.multipleChoice,
      ),
      Question(
        question: 'What is the index of the first element in an array?',
        options: ['0', '1', '-1', 'Depends on the array'],
        correctAnswer: '0',
        explanation: 'Java arrays are zero-indexed, meaning the first element is at index 0.',
        type: QuestionType.multipleChoice,
      ),
      Question(
        question: 'Which collection allows dynamic resizing?',
        options: ['Array', 'ArrayList', 'Both', 'Neither'],
        correctAnswer: 'ArrayList',
        explanation: 'ArrayList can grow or shrink dynamically, while arrays have a fixed size.',
        type: QuestionType.multipleChoice,
      ),
      Question(
        question: 'In HashMap, what are the two components of each entry?',
        correctAnswer: 'key and value',
        explanation: 'HashMap stores data as key-value pairs, where each unique key maps to a value.',
        type: QuestionType.fillBlank,
      ),
      Question(
        question: 'Which data structure would you use for fast lookup by a unique identifier?',
        options: ['Array', 'ArrayList', 'HashMap', 'String'],
        correctAnswer: 'HashMap',
        explanation: 'HashMap provides O(1) average time complexity for lookups using unique keys.',
        type: QuestionType.multipleChoice,
      ),
    ],
    isCompleted: false,
  ),
];
