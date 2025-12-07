// ============================================
// FILE: lib/data/lesson_data.dart
// ============================================

import '../models/lesson.dart';

List<Lesson> initialLessons = const [
  // =======================================================
  // Lesson 1: Imperative Programming
  // =======================================================
  Lesson(
    id: 'java_001',
    title: 'Imperative Programming',
    description: 'Learn the basics of imperative programming in Java',
    subTopics: [
      SubTopic(
        title: 'Variables & Data Types',
        content: 'In Java, variables are fundamental containers used to store data values during program execution. Unlike dynamically typed languages, Java is statically typed, meaning every variable must be declared with a specific data type before it can be used. This strict typing helps prevent errors by ensuring that the data stored matches the container\'s expected format.\n\nThere are two main categories of data types in Java: Primitive types and Reference types. Primitive types include `int` for whole numbers, `double` for decimals, `boolean` for true/false values, and `char` for single characters. Reference types, on the other hand, point to objects, such as `String` for text or arrays for collections of data. Understanding these types is the first step to writing robust Java code.',
        runnableCode: '''
public class Main {
    public static void main(String[] args) {
        int age = 25;
        String name = "Gemini";
        boolean isLearning = true;
        
        System.out.println(name + " is " + age);
    }
}''',
        expectedOutput: 'Gemini is 25',
      ),
      SubTopic(
        title: 'Control Flow',
        content: 'Control flow statements allow developers to dictate the order in which individual statements, instructions, or function calls are executed or evaluated. Without control flow, a program would simply run from top to bottom. The most common control structures are decision-making statements like `if-else` and `switch`, which allow the program to branch into different paths based on specific conditions.\n\nFor example, an `if` statement checks a boolean condition; if it evaluates to true, the code block inside executes. If false, the program can default to an `else` block. This logic is essential for creating interactive applications that respond differently to user inputs, such as determining if a user is old enough to vote or if a password entered is correct.',
        runnableCode: '''
public class Main {
    public static void main(String[] args) {
        int score = 85;
        
        if (score >= 90) {
            System.out.println("A Grade");
        } else if (score >= 80) {
            System.out.println("B Grade");
        } else {
            System.out.println("Try again");
        }
    }
}''',
        expectedOutput: 'B Grade',
      ),
      SubTopic(
        title: 'Loops and Iteration',
        content: 'Loops are powerful structures that enable a program to repeat a block of code multiple times without rewriting the same lines over and over. This concept, known as iteration, is crucial for tasks like processing items in a list, counting numbers, or running a game loop.\n\nThe three primary loops in Java are the `for` loop, `while` loop, and `do-while` loop. A `for` loop is best used when you know exactly how many times you want to repeat an action. A `while` loop runs as long as a specified condition remains true. The `do-while` loop is unique because it guarantees that the code block runs at least once before checking the condition.',
        runnableCode: '''
public class Main {
    public static void main(String[] args) {
        for (int i = 1; i <= 3; i++) {
            System.out.println("Iteration: " + i);
        }
    }
}''',
        expectedOutput: 'Iteration: 1\nIteration: 2\nIteration: 3',
      ),
    ],
    questions: [
      Question(
        question: 'Which data type is used to store text in Java?',
        type: QuestionType.identification,
        correctAnswer: 'String',
        explanation: 'String is the reference type used for text sequences.',
      ),
      Question(
        question: 'True or False: Java variables can change their type after declaration.',
        type: QuestionType.trueFalse,
        correctAnswer: 'false',
        explanation: 'Java is statically typed; once declared, a variable\'s type cannot change.',
      ),
      Question(
        question: 'Which loop is guaranteed to execute at least one time?',
        type: QuestionType.multipleChoice,
        options: ['for loop', 'while loop', 'do-while loop', 'enhanced for loop'],
        correctAnswer: 'do-while loop',
        explanation: 'The do-while loop checks the condition at the end of the iteration.',
      ),
      Question(
        question: 'Match the operator to its function.',
        type: QuestionType.matching,
        options: ['AND', 'OR', 'NOT', 'Equals'],
        matchingPairs: {
          '&&': 'AND',
          '||': 'OR',
          '!': 'NOT',
          '==': 'Equals'
        },
        correctAnswer: '',
        explanation: 'Standard logical operators in Java.',
      ),
      Question(
        question: 'What is the output of: int x = 10; if (x > 5) print("A"); else print("B");',
        type: QuestionType.multipleChoice,
        options: ['A', 'B', 'Error', 'No Output'],
        correctAnswer: 'A',
        explanation: 'Since 10 is greater than 5, the first block executes.',
      ),
    ],
  ),

  // =======================================================
  // Lesson 2: Object-Oriented Programming
  // =======================================================
  Lesson(
    id: 'java_002',
    title: 'Object-Oriented Programming',
    description: 'Master the principles of OOP in Java',
    subTopics: [
      SubTopic(
        title: 'Classes & Objects',
        content: 'Object-Oriented Programming (OOP) revolves around the concept of "objects," which contain both data (fields) and code (methods). A **Class** serves as the blueprint or template for these objects. For example, a `Car` class might define properties like `color` and `speed`, but it doesn\'t represent a specific car until you create an instance of it.\n\nAn **Object** is a specific instance of a class. When you use the `new` keyword in Java, you are allocating memory for a new object based on that class blueprint. You can create multiple objects from a single class, each holding its own unique data values while sharing the same structure and behaviors defined by the class.',
        runnableCode: '''
class Dog {
    String name;
    void bark() {
        System.out.println(name + " says Woof!");
    }
}

public class Main {
    public static void main(String[] args) {
        Dog myDog = new Dog();
        myDog.name = "Buddy";
        myDog.bark();
    }
}''',
        expectedOutput: 'Buddy says Woof!',
      ),
      SubTopic(
        title: 'Encapsulation',
        content: 'Encapsulation is the practice of bundling data (variables) and the methods that operate on that data into a single unit, the class. More importantly, it involves restricting direct access to some of an object\'s components. This is often described as "data hiding" and is achieved using access modifiers like `private`, `protected`, and `public`.\n\nIn a well-encapsulated class, fields are typically marked as `private` so they cannot be accessed directly from outside the class. Instead, `public` methods known as getters and setters are provided to read or modify these values. This allows the class to control how its data is accessed and prevents invalid states, such as setting a person\'s age to a negative number.',
        runnableCode: '''
class Person {
    private String name;
    
    public void setName(String n) {
        this.name = n;
    }
    
    public String getName() {
        return this.name;
    }
}

public class Main {
    public static void main(String[] args) {
        Person p = new Person();
        p.setName("Alice");
        System.out.println(p.getName());
    }
}''',
        expectedOutput: 'Alice',
      ),
      SubTopic(
        title: 'Inheritance',
        content: 'Inheritance is a mechanism where a new class (subclass or child) derives properties and behaviors from an existing class (superclass or parent). This promotes code reusability and establishes a natural hierarchy between classes. In Java, inheritance is implemented using the `extends` keyword.\n\nFor instance, if you have a general class called `Animal` with a method `eat()`, you can create a specific class `Cat` that extends `Animal`. The `Cat` class automatically gains the `eat()` method without rewriting it, but it can also add its own specific methods like `meow()`. This reduces redundancy and makes the code easier to maintain and scale.',
        runnableCode: '''
class Animal {
    void eat() { System.out.println("Eating..."); }
}
class Cat extends Animal {
    void meow() { System.out.println("Meow"); }
}

public class Main {
    public static void main(String[] args) {
        Cat c = new Cat();
        c.eat();
        c.meow();
    }
}''',
        expectedOutput: 'Eating...\nMeow',
      ),
    ],
    questions: [
      Question(
        question: 'The keyword used to create an object is called _____?',
        type: QuestionType.fillBlank,
        correctAnswer: 'new',
        explanation: 'The new keyword instantiates a class.',
      ),
      Question(
        question: 'Match the OOP term to its definition.',
        type: QuestionType.matching,
        options: ['Class', 'Object', 'Encapsulation', 'Inheritance'],
        matchingPairs: {
          'Class': 'Blueprint',
          'Object': 'Instance',
          'Encapsulation': 'Data Hiding',
          'Inheritance': 'Reusability'
        },
        correctAnswer: '',
        explanation: 'Core definitions of Object-Oriented Programming.',
      ),
      Question(
        question: 'True or False: Private methods can be accessed by any class.',
        type: QuestionType.trueFalse,
        correctAnswer: 'false',
        explanation: 'Private members are restricted to the class they are defined in.',
      ),
      Question(
        question: 'Which keyword establishes an inheritance relationship?',
        type: QuestionType.multipleChoice,
        options: ['implements', 'extends', 'imports', 'inherits'],
        correctAnswer: 'extends',
        explanation: 'Java uses "extends" for class inheritance.',
      ),
      Question(
        question: 'A public method used to retrieve the value of a private variable is called a _____?',
        type: QuestionType.identification,
        correctAnswer: 'getter',
        explanation: 'Getters (accessors) retrieve data; Setters (mutators) change it.',
      ),
    ],
  ),

  // =======================================================
  // Lesson 3: Classes in Detail
  // =======================================================
  Lesson(
    id: 'java_003',
    title: 'Classes in Detail',
    description: 'Deep dive into Java classes and their components',
    subTopics: [
      SubTopic(
        title: 'Constructors',
        content: 'Constructors are special blocks of code that are called automatically when an object is created. They look like methods but have no return type and must share the exact same name as the class. Their primary purpose is to initialize the object\'s state, such as assigning default values to fields.\n\nJava allows for "Constructor Overloading," meaning you can have multiple constructors in a single class as long as they have different parameter lists. This gives you flexibility—you might have one constructor that takes no arguments (a default constructor) and another that takes specific values to set up the object immediately upon creation.',
        runnableCode: '''
class Car {
    String model;
    // Constructor
    Car(String m) {
        model = m;
    }
}

public class Main {
    public static void main(String[] args) {
        Car c = new Car("Tesla");
        System.out.println(c.model);
    }
}''',
        expectedOutput: 'Tesla',
      ),
      SubTopic(
        title: 'Static Members',
        content: 'The `static` keyword in Java indicates that a particular member (field or method) belongs to the class itself rather than to any individual instance of that class. This means there is only one copy of a static field in memory, shared by all objects of that class.\n\nStatic methods are commonly used for utility functions that don\'t require any object state to work, such as `Math.sqrt()` or `Math.abs()`. Because they belong to the class, you can call them using the class name directly (e.g., `ClassName.method()`) without needing to create an object using `new`.',
        runnableCode: '''
class Counter {
    static int count = 0;
    Counter() { count++; }
}

public class Main {
    public static void main(String[] args) {
        new Counter();
        new Counter();
        System.out.println(Counter.count);
    }
}''',
        expectedOutput: '2',
      ),
      SubTopic(
        title: 'The "this" Keyword',
        content: 'In Java, the `this` keyword is a reference variable that refers to the current object. It is most commonly used inside methods or constructors to prevent ambiguity between class fields and parameters that share the same name.\n\nFor example, if a class has a field named `age` and a constructor parameter also named `age`, writing `age = age;` would just assign the parameter to itself. By writing `this.age = age;`, you explicitly tell Java that you want to assign the parameter value to the object\'s field. It can also be used to call other constructors within the same class.',
        runnableCode: '''
class Student {
    int id;
    Student(int id) {
        this.id = id; // Disambiguation
    }
}

public class Main {
    public static void main(String[] args) {
        Student s = new Student(101);
        System.out.println(s.id);
    }
}''',
        expectedOutput: '101',
      ),
    ],
    questions: [
      Question(
        question: 'Constructors must have the same name as the _____?',
        type: QuestionType.identification,
        correctAnswer: 'class',
        explanation: 'This is a strict rule in Java syntax.',
      ),
      Question(
        question: 'True or False: Static methods can access non-static (instance) variables directly.',
        type: QuestionType.trueFalse,
        correctAnswer: 'false',
        explanation: 'Static context cannot access instance context because no instance might exist.',
      ),
      Question(
        question: 'Which keyword refers to the current object instance?',
        type: QuestionType.multipleChoice,
        options: ['self', 'this', 'super', 'me'],
        correctAnswer: 'this',
        explanation: '`this` refers to the current object; `super` refers to the parent.',
      ),
      Question(
        question: 'Match the concept to its description.',
        type: QuestionType.matching,
        options: ['Static', 'Instance', 'Constructor', 'Overloading'],
        matchingPairs: {
          'Static': 'Shared by all objects',
          'Instance': 'Unique to each object',
          'Constructor': 'Initializes object',
          'Overloading': 'Same name, different params'
        },
        correctAnswer: '',
        explanation: 'Key class mechanics.',
      ),
      Question(
        question: 'If a class has a static variable `count`, and you create 3 objects, how many copies of `count` exist in memory?',
        type: QuestionType.multipleChoice,
        options: ['1', '3', '0', 'Depends on compiler'],
        correctAnswer: '1',
        explanation: 'Static variables are shared, so only one copy exists.',
      ),
    ],
  ),

  // =======================================================
  // Lesson 4: Methods
  // =======================================================
  Lesson(
    id: 'java_004',
    title: 'Methods',
    description: 'Understanding modular code with methods',
    subTopics: [
      SubTopic(
        title: 'Method Structure',
        content: 'Methods (often called functions in other languages) are reusable blocks of code designed to perform a specific task. A method definition consists of a header and a body. The header includes access modifiers (like public/private), a return type (what data comes out), the method name, and a pair of parentheses which may contain parameters (inputs). The body, enclosed in curly braces, contains the logic.\n\nUsing methods is essential for the "Don\'t Repeat Yourself" (DRY) principle. Instead of writing the same calculation logic in ten different places, you write it once in a method and simply "call" or "invoke" that method whenever needed. This makes code easier to read, debug, and maintain because fixing a bug in the method fixes it everywhere the method is used.',
        runnableCode: '''
public class Main {
    // A simple method that returns an integer
    static int calculateArea(int width, int height) {
        return width * height;
    }

    public static void main(String[] args) {
        int area = calculateArea(5, 10);
        System.out.println("Area: " + area);
    }
}''',
        expectedOutput: 'Area: 50',
      ),
      SubTopic(
        title: 'Parameters and Return Types',
        content: 'Parameters act as variables inside the method that receive values (arguments) passed from outside when the method is called. They allow methods to be dynamic and process different data each time. A method can have multiple parameters separated by commas, or none at all.\n\nThe "Return Type" defines what kind of data the method gives back after execution. If a method performs a calculation, it might return an `int` or `double`. If it simply prints text or changes a variable without giving back a value, the return type must be `void`. If a method is not void, it must use the `return` keyword to pass the result back to the caller.',
        runnableCode: '''
public class Main {
    // Void method: performs action, returns nothing
    static void greet(String name) {
        System.out.println("Hello, " + name + "!");
    }

    // Value-returning method
    static double getPi() {
        return 3.14159;
    }

    public static void main(String[] args) {
        greet("Developer");
        double value = getPi();
        System.out.println("Pi is approx " + value);
    }
}''',
        expectedOutput: 'Hello, Developer!\nPi is approx 3.14159',
      ),
      SubTopic(
        title: 'Method Overloading',
        content: 'Method Overloading is a feature that allows a class to have more than one method having the same name, provided their parameter lists are different. This is useful when you want to perform a similar operation on different types or amounts of data. For example, a `print()` method could handle both text strings and numbers.\n\nJava distinguishes overloaded methods by their "method signature," which includes the name and the parameter types. It does not look at the return type. So, `int add(int a, int b)` and `double add(double a, double b)` can coexist peacefully. The compiler automatically chooses the correct version based on the arguments you pass when calling the method.',
        runnableCode: '''
public class Main {
    static int add(int a, int b) {
        return a + b;
    }
    
    static int add(int a, int b, int c) {
        return a + b + c;
    }

    public static void main(String[] args) {
        System.out.println(add(5, 5));
        System.out.println(add(1, 2, 3));
    }
}''',
        expectedOutput: '10\n6',
      ),
    ],
    questions: [
      Question(
        question: 'Which keyword indicates that a method does not return a value?',
        type: QuestionType.identification,
        correctAnswer: 'void',
        explanation: 'Void means the method performs an action but sends no data back.',
      ),
      Question(
        question: 'True or False: You can overload a method by changing ONLY its return type.',
        type: QuestionType.trueFalse,
        correctAnswer: 'false',
        explanation: 'Overloading requires different parameter lists (types or number of parameters).',
      ),
      Question(
        question: 'Match the method part to its role.',
        type: QuestionType.matching,
        options: ['Parameter', 'Return Type', 'Body', 'Call'],
        matchingPairs: {
          'Parameter': 'Input variable',
          'Return Type': 'Output data type',
          'Body': 'The code logic',
          'Call': 'Invoking the method'
        },
        correctAnswer: '',
        explanation: 'Anatomy of a Java method.',
      ),
      Question(
        question: 'What is the output of `add(2, 3)` if the method returns a * b?',
        type: QuestionType.multipleChoice,
        options: ['5', '6', '23', 'Error'],
        correctAnswer: '6',
        explanation: 'The logic inside the body dictates the result, even if the method name is misleading.',
      ),
      Question(
        question: 'Variables passed into a method when it is called are known as _____?',
        type: QuestionType.fillBlank,
        correctAnswer: 'arguments',
        explanation: 'Parameters are defined in the method; arguments are the actual values passed in.',
      ),
    ],
  ),

  // =======================================================
  // Lesson 5: Data Structures
  // =======================================================
  Lesson(
    id: 'java_005',
    title: 'Data Structures',
    description: 'Storing and organizing data efficiently',
    subTopics: [
      SubTopic(
        title: 'Arrays',
        content: 'An Array is the simplest data structure in Java, used to store multiple values of the same type in a single variable. Arrays have a fixed size, meaning once you declare an array of size 5, it cannot grow to size 6. They are extremely fast for accessing data if you know the index (position) of the item.\n\nArrays are zero-indexed, meaning the first element is at index 0, the second at index 1, and so on. Trying to access an index outside the declared size (e.g., index 5 in a size 5 array) results in an `ArrayIndexOutOfBoundsException`. They are best used when the number of elements is known beforehand, such as days of the week or coordinates.',
        runnableCode: '''
public class Main {
    public static void main(String[] args) {
        // Declare and initialize
        String[] fruits = {"Apple", "Banana", "Cherry"};
        
        // Modify an element
        fruits[1] = "Blueberry";
        
        System.out.println(fruits[1]);
        System.out.println("Size: " + fruits.length);
    }
}''',
        expectedOutput: 'Blueberry\nSize: 3',
      ),
      SubTopic(
        title: 'ArrayList',
        content: 'Unlike standard arrays, an `ArrayList` is a dynamic data structure found in the `java.util` package. It can resize itself automatically: if you add an element to a full ArrayList, it grows; if you remove elements, it can shrink. This flexibility makes it one of the most commonly used collections in Java programming.\n\nHowever, ArrayLists cannot store primitive types (like `int`) directly; they must use wrapper classes (like `Integer`). They provide powerful built-in methods such as `.add()`, `.remove()`, `.contains()`, and `.size()`, which saves developers from writing complex logic to manage memory manually.',
        runnableCode: '''
import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        ArrayList<String> tasks = new ArrayList<>();
        tasks.add("Code");
        tasks.add("Sleep");
        tasks.remove("Sleep"); // Removes by value
        
        System.out.println(tasks);
    }
}''',
        expectedOutput: '[Code]',
      ),
      SubTopic(
        title: 'HashMap',
        content: 'A `HashMap` is a data structure that stores items in "key/value" pairs. Think of it like a real-world dictionary: you look up a word (the Key) to find its definition (the Value). In a HashMap, keys must be unique—you cannot have two "Apple" keys, but you can have multiple keys with the same value.\n\nHashMaps are incredibly efficient for lookups. Instead of searching through a list one by one to find an item (which takes time), a HashMap uses a hashing algorithm to jump directly to the memory location of the value. This makes operations like `.get(key)` and `.put(key, value)` very fast, usually taking constant time O(1).',
        runnableCode: '''
import java.util.HashMap;

public class Main {
    public static void main(String[] args) {
        HashMap<String, Integer> scores = new HashMap<>();
        scores.put("Alice", 95);
        scores.put("Bob", 80);
        
        // Retrieve Bob's score
        System.out.println("Bob's Score: " + scores.get("Bob"));
    }
}''',
        expectedOutput: 'Bob\'s Score: 80',
      ),
    ],
    questions: [
      Question(
        question: 'Which index represents the first element in a Java array?',
        type: QuestionType.multipleChoice,
        options: ['1', '0', '-1', 'Start'],
        correctAnswer: '0',
        explanation: 'Java arrays are zero-indexed.',
      ),
      Question(
        question: 'True or False: An ArrayList typically runs faster than a standard Array.',
        type: QuestionType.trueFalse,
        correctAnswer: 'false',
        explanation: 'Standard arrays are faster due to less overhead, but ArrayLists are more flexible.',
      ),
      Question(
        question: 'In a HashMap, every value is associated with a unique _____?',
        type: QuestionType.fillBlank,
        correctAnswer: 'key',
        explanation: 'You retrieve values by using their corresponding unique key.',
      ),
      Question(
        question: 'Match the collection to its characteristic.',
        type: QuestionType.matching,
        options: ['Array', 'ArrayList', 'HashMap'],
        matchingPairs: {
          'Array': 'Fixed size',
          'ArrayList': 'Dynamic size',
          'HashMap': 'Key-Value pairs'
        },
        correctAnswer: '',
        explanation: 'The defining features of these data structures.',
      ),
      Question(
        question: 'What happens if you try to put a duplicate key into a HashMap?',
        type: QuestionType.multipleChoice,
        options: ['Error', 'Both keys stay', 'Old value is overwritten', 'New value is discarded'],
        correctAnswer: 'Old value is overwritten',
        explanation: 'Keys must be unique; reusing a key updates its value.',
      ),
    ],
  ),

  // =======================================================
  // Lesson 6: Exception Handling
  // =======================================================
  Lesson(
    id: 'java_006',
    title: 'Exception Handling',
    description: 'Managing runtime errors gracefully',
    subTopics: [
      SubTopic(
        title: 'Try and Catch',
        content: 'An Exception is an event that occurs during the execution of a program that disrupts the normal flow of instructions. Examples include trying to divide by zero or accessing a file that doesn\'t exist. If not handled, these exceptions cause the program to crash immediately.\n\nTo prevent crashes, Java provides the `try-catch` block. You put the "risky" code inside the `try` block. If an error occurs, the program jumps immediately to the `catch` block, where you can handle the error (e.g., print a friendly message) instead of crashing. This allows the program to continue running the remaining code safely.',
        runnableCode: '''
public class Main {
    public static void main(String[] args) {
        try {
            int[] numbers = {1, 2, 3};
            System.out.println(numbers[10]); // Invalid index
        } catch (Exception e) {
            System.out.println("Something went wrong!");
        }
        System.out.println("App still running...");
    }
}''',
        expectedOutput: 'Something went wrong!\nApp still running...',
      ),
      SubTopic(
        title: 'The Finally Block',
        content: 'Sometimes you have code that needs to execute regardless of whether an exception occurred or not. This is where the `finally` block comes in. It is placed after the `try` and `catch` blocks. Code inside `finally` is guaranteed to run even if the `try` block fails or if the `try` block returns early.\n\nThe `finally` block is best used for "cleanup" code. For example, if you open a file or a database connection in the `try` block, you should close it in the `finally` block to ensure you don\'t leave resources hanging open (which causes memory leaks), even if an error happened during processing.',
        runnableCode: '''
public class Main {
    public static void main(String[] args) {
        try {
            System.out.println("Opening file...");
            int x = 10 / 0; // Error!
        } catch (ArithmeticException e) {
            System.out.println("Error caught.");
        } finally {
            System.out.println("Closing file...");
        }
    }
}''',
        expectedOutput: 'Opening file...\nError caught.\nClosing file...',
      ),
      SubTopic(
        title: 'Throwing Exceptions',
        content: 'In addition to catching errors, you can also create them using the `throw` keyword. This is useful when you want to enforce specific rules in your code. For example, if someone tries to set an age to -5, you can explicitly "throw" an exception to signal that this input is invalid.\n\nJava also distinguishes between "Checked" exceptions (which the compiler forces you to handle, like file errors) and "Unchecked" exceptions (runtime errors like NullPointerException). Good exception handling involves knowing when to catch system errors and when to throw your own custom errors to maintain data integrity.',
        runnableCode: '''
public class Main {
    static void checkAge(int age) {
        if (age < 18) {
            throw new ArithmeticException("Access denied");
        } else {
            System.out.println("Access granted");
        }
    }

    public static void main(String[] args) {
        try {
            checkAge(15);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}''',
        expectedOutput: 'Access denied',
      ),
    ],
    questions: [
      Question(
        question: 'Which block is guaranteed to execute regardless of errors?',
        type: QuestionType.identification,
        correctAnswer: 'finally',
        explanation: 'Finally blocks run after try/catch, even if return is called.',
      ),
      Question(
        question: 'True or False: A try block can exist without a catch or finally block.',
        type: QuestionType.trueFalse,
        correctAnswer: 'false',
        explanation: 'A try block must be followed by at least one catch or a finally block.',
      ),
      Question(
        question: 'Which keyword is used to manually trigger an exception?',
        type: QuestionType.fillBlank,
        correctAnswer: 'throw',
        explanation: 'You use `throw new Exception()` to create an error explicitly.',
      ),
      Question(
        question: 'Match the exception term to its meaning.',
        type: QuestionType.matching,
        options: ['try', 'catch', 'throw', 'Exception'],
        matchingPairs: {
          'try': 'Contains risky code',
          'catch': 'Handles the error',
          'throw': 'Creates an error',
          'Exception': 'The error event object'
        },
        correctAnswer: '',
        explanation: 'The flow of error handling.',
      ),
      Question(
        question: 'What type of exception occurs when dividing by zero?',
        type: QuestionType.multipleChoice,
        options: ['NullPointerException', 'ArithmeticException', 'IOException', 'IndexOutOfBounds'],
        correctAnswer: 'ArithmeticException',
        explanation: 'Math errors usually trigger ArithmeticException.',
      ),
    ],
  ),

  // =======================================================
  // Lesson 7: Abstraction & Interfaces
  // =======================================================
  Lesson(
    id: 'java_007',
    title: 'Abstraction',
    description: 'Hiding complexity with Abstract Classes and Interfaces',
    subTopics: [
      SubTopic(
        title: 'Abstract Classes',
        content: 'Abstraction is the concept of hiding implementation details and showing only the functionality to the user. An `abstract` class is a restricted class that cannot be used to create objects directly (you cannot say `new AbstractClass()`). It exists solely to be extended by other classes.\n\nAbstract classes can contain both regular methods (with code bodies) and "abstract methods" (methods without bodies). An abstract method acts as a contract: any child class that extends the abstract class *must* provide the actual code for that method. This ensures a consistent interface across different subclasses while allowing them to implement specific behaviors differently.',
        runnableCode: '''
abstract class Shape {
    abstract void draw(); // No body
}

class Circle extends Shape {
    void draw() {
        System.out.println("Drawing a Circle");
    }
}

public class Main {
    public static void main(String[] args) {
        Shape s = new Circle();
        s.draw();
    }
}''',
        expectedOutput: 'Drawing a Circle',
      ),
      SubTopic(
        title: 'Interfaces',
        content: 'An Interface is similar to an abstract class but is even more restrictive. By default, all methods in an interface are abstract (empty) and public. A class does not "extend" an interface; instead, it `implements` it. This is a powerful feature because while Java classes can only extend *one* parent class, they can implement *multiple* interfaces.\n\nInterfaces are used to achieve total abstraction and to define a set of capabilities. For example, you might have a `Flyable` interface. A `Bird` class, a `Plane` class, and a `SuperHero` class could all implement `Flyable`, guaranteeing they all have a `fly()` method, even though they are completely different types of objects.',
        runnableCode: '''
interface Animal {
    void makeSound();
}

class Dog implements Animal {
    public void makeSound() {
        System.out.println("Woof");
    }
}

public class Main {
    public static void main(String[] args) {
        Dog d = new Dog();
        d.makeSound();
    }
}''',
        expectedOutput: 'Woof',
      ),
      SubTopic(
        title: 'Polymorphism',
        content: 'Polymorphism means "many forms." It allows an object to be treated as a generic version of itself (its parent class or interface). This allows you to write flexible code. For instance, you can create a `List<Animal>` that holds Cats, Dogs, and Birds. You can loop through the list and call `makeSound()` on every item without knowing specifically what kind of animal it is.\n\nThis is the heart of flexible software design. You can write code that works with a generic `Shape` class, and it will automatically work with `Circle`, `Square`, or `Triangle` objects passed to it later, without needing to change your original code.',
        runnableCode: '''
class Animal {
    void sound() { System.out.println("Generic sound"); }
}
class Pig extends Animal {
    void sound() { System.out.println("Oink"); }
}

public class Main {
    public static void main(String[] args) {
        Animal myAnimal = new Pig(); // Polymorphism
        myAnimal.sound();
    }
}''',
        expectedOutput: 'Oink',
      ),
    ],
    questions: [
      Question(
        question: 'Which keyword is used for a class to use an interface?',
        type: QuestionType.identification,
        correctAnswer: 'implements',
        explanation: 'Classes extend classes, but implement interfaces.',
      ),
      Question(
        question: 'True or False: You can create an instance of an abstract class using "new".',
        type: QuestionType.trueFalse,
        correctAnswer: 'false',
        explanation: 'Abstract classes are incomplete and cannot be instantiated.',
      ),
      Question(
        question: 'A Java class can extend _____ parent class(es).',
        type: QuestionType.multipleChoice,
        options: ['1', '2', 'Multiple', '0'],
        correctAnswer: '1',
        explanation: 'Java supports single inheritance for classes.',
      ),
      Question(
        question: 'Match the concept to the keyword.',
        type: QuestionType.matching,
        options: ['Abstract Class', 'Interface', 'Child Class'],
        matchingPairs: {
          'Abstract Class': 'extends',
          'Interface': 'implements',
          'Child Class': 'overrides'
        },
        correctAnswer: '',
        explanation: 'Keywords defining relationships in abstraction.',
      ),
      Question(
        question: 'Polymorphism allows a child object to be treated as its _____?',
        type: QuestionType.fillBlank,
        correctAnswer: 'parent',
        explanation: 'Or superclass/interface type.',
      ),
    ],
  ),

  // =======================================================
  // Lesson 8: Generics
  // =======================================================
  Lesson(
    id: 'java_008',
    title: 'Generics',
    description: 'Writing type-safe and reusable code',
    subTopics: [
      SubTopic(
        title: 'Why Generics?',
        content: 'Before Generics were introduced in Java 5, collections like ArrayLists could hold any object (`Object` type). This meant you could accidentally put a String into a list of Integers, and the compiler wouldn\'t complain until the program crashed at runtime. This was a major source of bugs.\n\nGenerics solve this by allowing you to define exactly what type of data a class or method works with. By specifying `ArrayList<String>`, you tell the compiler to strictly enforce that only Strings can be added. If you try to add an integer, the code won\'t even compile, catching the error early.',
        runnableCode: '''
import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        // Without generics (unsafe)
        ArrayList list = new ArrayList();
        list.add("Hello");
        // list.add(10); // This would crash later if we expected Strings
        
        // With generics (safe)
        ArrayList<String> safeList = new ArrayList<>();
        safeList.add("Hello");
        System.out.println(safeList.get(0));
    }
}''',
        expectedOutput: 'Hello',
      ),
      SubTopic(
        title: 'Generic Classes',
        content: 'You can create your own generic classes. A generic class uses a "type parameter," usually denoted by `<T>`, `<E>`, or `<K, V>`. This `T` acts as a placeholder for a real data type that will be specified later when the object is created.\n\nFor example, if you are building a `Box` class to hold an item, you don\'t want to create separate `StringBox` and `IntegerBox` classes. Instead, you create `class Box<T>`. When someone uses it, they can say `new Box<String>()`, and Java automatically replaces every instance of `T` with `String` for that object.',
        runnableCode: '''
class Box<T> {
    private T item;
    public void set(T t) { this.item = t; }
    public T get() { return item; }
}

public class Main {
    public static void main(String[] args) {
        Box<Integer> intBox = new Box<>();
        intBox.set(100);
        
        System.out.println(intBox.get() + 50);
    }
}''',
        expectedOutput: '150',
      ),
      SubTopic(
        title: 'Generic Methods',
        content: 'Just like classes, individual methods can be generic. This is useful when you want a single method to handle different types of arrays or lists. You define the type parameter `<T>` before the return type of the method.\n\nA classic example is a method that prints the contents of an array. Instead of writing `printIntArray` and `printStringArray`, you write one `printArray(T[] array)` method. This drastically reduces code duplication and adheres to clean coding practices.',
        runnableCode: '''
public class Main {
    public static <T> void printData(T data) {
        System.out.println("Data: " + data);
    }

    public static void main(String[] args) {
        printData(123);
        printData("Generics");
        printData(99.9);
    }
}''',
        expectedOutput: 'Data: 123\nData: Generics\nData: 99.9',
      ),
    ],
    questions: [
      Question(
        question: 'What symbols are used to denote generics in Java?',
        type: QuestionType.multipleChoice,
        options: ['[ ]', '{ }', '< >', '( )'],
        correctAnswer: '< >',
        explanation: 'Diamond brackets enclose type parameters.',
      ),
      Question(
        question: 'Generics move type checking from _____ time to Compile time.',
        type: QuestionType.fillBlank,
        correctAnswer: 'Runtime',
        explanation: 'They prevent ClassCastExceptions while the app runs.',
      ),
      Question(
        question: 'In `class Box<T>`, what does T represent?',
        type: QuestionType.multipleChoice,
        options: ['Time', 'Type', 'Transfer', 'Template'],
        correctAnswer: 'Type',
        explanation: 'It is a placeholder for the Type.',
      ),
      Question(
        question: 'True or False: You can use primitive types (int, double) directly in Generics.',
        type: QuestionType.trueFalse,
        correctAnswer: 'false',
        explanation: 'You must use wrapper classes like Integer or Double.',
      ),
      Question(
        question: 'Match the wrapper class to its primitive.',
        type: QuestionType.matching,
        options: ['Integer', 'Character', 'Double'],
        matchingPairs: {
          'int': 'Integer',
          'char': 'Character',
          'double': 'Double'
        },
        correctAnswer: '',
        explanation: 'Generics require Objects, not primitives.',
      ),
    ],
  ),

  // =======================================================
  // Lesson 9: Multithreading
  // =======================================================
  Lesson(
    id: 'java_009',
    title: 'Multithreading',
    description: 'Running multiple tasks concurrently',
    subTopics: [
      SubTopic(
        title: 'Threads Basics',
        content: 'A Thread is a lightweight sub-process, the smallest unit of processing. Multithreading is the ability of a CPU to execute multiple threads concurrently. This allows your application to perform long-running tasks (like downloading a file) in the background while keeping the main interface responsive.\n\nIn Java, every program has at least one thread: the "main" thread. You can create new threads to run tasks parallel to the main thread. If you don\'t use threads, a long calculation would "freeze" your app until it finished. With threads, the operating system rapidly switches between tasks, giving the illusion of simultaneous execution.',
        runnableCode: '''
class Loader extends Thread {
    public void run() {
        System.out.println("Loading data...");
    }
}

public class Main {
    public static void main(String[] args) {
        Loader thread = new Loader();
        thread.start(); // Starts parallel execution
        System.out.println("Main continues...");
    }
}''',
        expectedOutput: 'Main continues...\nLoading data...',
      ),
      SubTopic(
        title: 'Runnable Interface',
        content: 'While you can extend the `Thread` class, the preferred way to create a thread is by implementing the `Runnable` interface. This is better because Java only allows extending one class. If you extend `Thread`, you can\'t extend anything else. If you implement `Runnable`, your class is still free to extend another class.\n\nA Runnable is simply a task to be done. You define the work in the `run()` method, then pass the Runnable object to a `Thread` object to execute it. This separates the "task" from the "runner."',
        runnableCode: '''
public class Main {
    public static void main(String[] args) {
        // Lambda shortcut for Runnable
        Thread t = new Thread(() -> {
            System.out.println("Runnable task running!");
        });
        
        t.start();
    }
}''',
        expectedOutput: 'Runnable task running!',
      ),
      SubTopic(
        title: 'Synchronization',
        content: 'When multiple threads try to access the same variable or resource at the exact same time, "Race Conditions" can occur, leading to data corruption. For example, if two threads try to deposit money into the same bank account simultaneously, the final balance might be wrong.\n\nTo prevent this, Java provides the `synchronized` keyword. When a method is synchronized, only one thread is allowed to access it at a time. Other threads must wait their turn. This ensures "Thread Safety" but can slow down performance if used excessively.',
        runnableCode: '''
class Counter {
    int count = 0;
    // Only one thread can enter this at a time
    synchronized void increment() {
        count++;
    }
}

public class Main {
    public static void main(String[] args) {
        Counter c = new Counter();
        c.increment();
        System.out.println(c.count);
    }
}''',
        expectedOutput: '1',
      ),
    ],
    questions: [
      Question(
        question: 'Which method starts the execution of a thread?',
        type: QuestionType.multipleChoice,
        options: ['run()', 'start()', 'init()', 'execute()'],
        correctAnswer: 'start()',
        explanation: 'start() initializes the stack and calls run() internally.',
      ),
      Question(
        question: 'True or False: Extending the Thread class is generally preferred over implementing Runnable.',
        type: QuestionType.trueFalse,
        correctAnswer: 'false',
        explanation: 'Runnable is preferred to avoid the single-inheritance limitation.',
      ),
      Question(
        question: 'The keyword used to prevent threads from interfering with each other is _____?',
        type: QuestionType.identification,
        correctAnswer: 'synchronized',
        explanation: 'It locks the method or block for a single thread.',
      ),
      Question(
        question: 'Match the thread state to its description.',
        type: QuestionType.matching,
        options: ['New', 'Runnable', 'Terminated'],
        matchingPairs: {
          'New': 'Created but not started',
          'Runnable': 'Ready to run/Running',
          'Terminated': 'Execution finished'
        },
        correctAnswer: '',
        explanation: 'Lifecycle states of a Java Thread.',
      ),
      Question(
        question: 'What happens if you call run() directly instead of start()?',
        type: QuestionType.multipleChoice,
        options: ['New thread starts', 'Runs on current thread', 'Crash', 'Nothing'],
        correctAnswer: 'Runs on current thread',
        explanation: 'It behaves like a normal method call, blocking the main thread.',
      ),
    ],
  ),

  // =======================================================
  // Lesson 10: Modern Java (Streams & Lambdas)
  // =======================================================
  Lesson(
    id: 'java_010',
    title: 'Streams & Lambdas',
    description: 'Modern functional programming in Java 8+',
    subTopics: [
      SubTopic(
        title: 'Lambda Expressions',
        content: 'Introduced in Java 8, Lambda expressions allow you to write concise code for single-method interfaces (Functional Interfaces). Before lambdas, you had to write verbose "Anonymous Inner Classes." With lambdas, you focus only on the logic.\n\nThe syntax is `(parameters) -> { body }`. For example, instead of writing a full class to define a button click action, you can just write `event -> System.out.println("Clicked")`. This makes code much more readable and facilitates "Functional Programming" style in Java.',
        runnableCode: '''
import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        ArrayList<Integer> nums = new ArrayList<>();
        nums.add(1); nums.add(2); nums.add(3);
        
        // Lambda expression
        nums.forEach(n -> System.out.println(n * 2));
    }
}''',
        expectedOutput: '2\n4\n6',
      ),
      SubTopic(
        title: 'The Stream API',
        content: 'Streams provide a high-level way to process collections of objects. A Stream is not a data structure; it doesn\'t store data. Instead, it takes data from a collection (like a List), allows you to chain operations on it, and produces a result. Operations are divided into "Intermediate" (like `filter`, `map`) and "Terminal" (like `collect`, `forEach`).\n\nFor example, if you have a list of names and want to find all names starting with "J" and sort them, you can do this in one readable pipeline of commands. Streams execute lazily, meaning they don\'t actually process the data until a terminal operation is called.',
        runnableCode: '''
import java.util.Arrays;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = Arrays.asList("John", "Jane", "Adam", "Eve");
        
        names.stream()
             .filter(name -> name.startsWith("J")) // Intermediate
             .map(name -> name.toUpperCase())      // Intermediate
             .forEach(System.out::println);        // Terminal
    }
}''',
        expectedOutput: 'JOHN\nJANE',
      ),
      SubTopic(
        title: 'Method References',
        content: 'Method references are a shorthand notation of a lambda expression to call a method. If your lambda simply calls an existing method, you can refer to it by name using the `::` operator. \n\nFor example, `s -> System.out.println(s)` can be rewritten as `System.out::println`. This improves readability further. There are four types: reference to a static method, reference to an instance method of a particular object, reference to an instance method of an arbitrary object, and reference to a constructor.',
        runnableCode: '''
import java.util.Arrays;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> messages = Arrays.asList("Java", "is", "cool");
        
        // Using Method Reference ::
        messages.forEach(System.out::print); 
        // Same as: messages.forEach(s -> System.out.print(s));
    }
}''',
        expectedOutput: 'Javaiscool',
      ),
    ],
    questions: [
      Question(
        question: 'Which arrow symbol is used in Lambda expressions?',
        type: QuestionType.multipleChoice,
        options: ['=>', '->', '-->', '::'],
        correctAnswer: '->',
        explanation: 'The hyphen-arrow syntax is used in Java.',
      ),
      Question(
        question: 'The operator `::` is known as a _____?',
        type: QuestionType.identification,
        correctAnswer: 'method reference',
        explanation: 'It refers to an existing method by name.',
      ),
      Question(
        question: 'True or False: Streams store data just like ArrayLists.',
        type: QuestionType.trueFalse,
        correctAnswer: 'false',
        explanation: 'Streams are pipelines for computing data, not storing it.',
      ),
      Question(
        question: 'Match the Stream operation to its type.',
        type: QuestionType.matching,
        options: ['filter', 'map', 'forEach', 'collect'],
        matchingPairs: {
          'filter': 'Intermediate',
          'map': 'Intermediate',
          'forEach': 'Terminal',
          'collect': 'Terminal'
        },
        correctAnswer: '',
        explanation: 'Stream operations are either intermediate (chainable) or terminal (ending).',
      ),
      Question(
        question: 'Which functional interface is used for a lambda that takes one input and returns a boolean?',
        type: QuestionType.multipleChoice,
        options: ['Consumer', 'Supplier', 'Predicate', 'Function'],
        correctAnswer: 'Predicate',
        explanation: 'Predicates test a condition and return true/false (used in filter).',
      ),
    ],
  ),
];