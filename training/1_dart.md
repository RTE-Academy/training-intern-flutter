[← Back to Training Plan](../README.md)

# Dart syntax, Flutter structure & OOP basics

A practical, beginner-friendly overview so you can read, write, and structure Flutter apps confidently.

<a id="overview"></a>
## Overview

This page covers three main areas:

*   **Dart syntax** — variables, functions, async, collections.
*   **Flutter structure** — widgets, widget tree, stateful vs stateless, layout basics.
*   **OOP in Dart** — classes, constructors, inheritance, mixins, interfaces, abstract classes.

Short path to practice: `Read example → Copy code → Run with flutter run or DartPad → Modify`

<a id="dart-basics"></a>
## Dart Basics (Syntax & Core Concepts)

### 1. Types & variables

Dart is optionally typed. Use `var`, explicit types, and `final`/`const`.

```dart
// variables
void main() {
  var name = 'Alice';       // inferred String
  String country = 'VN';    // explicit type
  int age = 25;
  final now = DateTime.now(); // runtime constant
  const pi = 3.1415;         // compile-time constant
}
```

### 2. Functions & arrow syntax

```dart
int add(int a, int b) {
  return a + b;
}

// shorthand:
int mul(int a, int b) => a * b;

// optional & named params:
String greet(String name, {String title = 'Friend'}) => 'Hi $title $name';
```

### 3. Collections

```dart
// List, Set, Map
void main() {
  var list = <int>[1,2,3];
  var set = <String>{'a','b'};
  var map = <String,int>{'a':1, 'b':2};

  list.forEach((v) => print(v));
  print(map['a']); // 1
}
```

### 4. Null-safety

Dart by default prevents nulls unless you opt in with `?` or allow nullable types.

```dart
String? maybe; // can be null
String notNull = 'hi';
// if you need to call methods:
int len = maybe?.length ?? 0; // safe navigation + default
```

### 5. Asynchronous programming

Use `Future` and `async/await`. Streams for many events.

```dart
Future<String> fetchUser() async {
  await Future.delayed(Duration(seconds:1));
  return 'remote user';
}

void main() async {
  var user = await fetchUser();
  print(user); // remote user
}
```

**Exercise:** Write a function that fetches a number (simulated with a delayed Future), doubles it, and prints the result.

<a id="flutter-structure"></a>
## Flutter Structure (Widgets & Layout)

### What is Flutter?

Flutter is a UI toolkit that renders UI using widgets. Everything is a *widget* — layout, text, images, even padding.

### Basic app structure (main.dart)

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Hello Flutter')),
    );
  }
}
```

### Widget tree & composition

Widgets are arranged in a tree. Smaller widgets compose larger UI. Prefer small reusable widgets.

### Stateless vs Stateful

*   **StatelessWidget**: immutable, UI depends only on constructor parameters.
*   **StatefulWidget**: has mutable state held in a `State` object.

```dart
// Stateful example: counter
class Counter extends StatefulWidget {
  const Counter({super.key});
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;
  void _inc() => setState(() => _count++);
  @override
  Widget build(BuildContext ctx) {
    return Column(
      children: [
        Text('Count: $_count'),
        ElevatedButton(onPressed: _inc, child: Text('Increment')),
      ],
    );
  }
}
```

### Layout basics

Common layout widgets:

*   `Row`, `Column`, `Stack`
*   `Expanded`, `Flexible` for flexible space
*   `Container`, `Padding`, `Center`

### Navigation

Basic navigation uses `Navigator.push` and `Navigator.pop`:

```dart
Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage()));
```

**Exercise:** Create a page with a list of 5 items. When tapping an item, navigate to a detail page that shows item name.

<a id="oop"></a>
## OOP in Dart — Core Concepts

### Classes & constructors

```dart
class User {
  final String id;
  String name;

  // constructor
  User(this.id, this.name);

  // named constructor
  User.guest() : id = 'guest', name = 'Guest';

  // method
  void rename(String newName) => name = newName;
}
```

### Getters & setters

```dart
class Rectangle {
  double width, height;
  Rectangle(this.width, this.height);
  double get area => width * height;
  set scale(double s) { width *= s; height *= s; }
}
```

### Inheritance

```dart
class Animal {
  void speak() => print('...');
}
class Dog extends Animal {
  @override
  void speak() => print('Woof!');
}
```

### Abstract classes & interfaces

Use abstract classes for shared contracts. In Dart, every class implicitly defines an interface that others can implement.

```dart
abstract class Service {
  void start();
}

class LoggerService implements Service {
  @override
  void start() => print('Logger started');
}
```

### Mixins

Mixins let you reuse code across classes.

```dart
mixin CanDrive { void drive() => print('driving'); }
class Car with CanDrive {}
```

**Exercise:** Create a base class `Shape` with an abstract method `area()`. Implement `Circle` and `Square`.

<a id="integration"></a>
## Putting it together — Example: Simple Note App Skeleton

Below is a minimal example showing how Dart models, Flutter UI, and OOP interact.

```dart
// model.dart
class Note {
  final String id;
  String text;
  Note({required this.id, required this.text});
}

// main.dart (excerpt)
class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final List<Note> _notes = [Note(id: '1', text: 'Buy milk')];

  void _addNote() {
    setState(() {
      _notes.add(Note(id: DateTime.now().toIso8601String(), text: 'New note'));
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: ListView(
        children: _notes.map((n) => ListTile(title: Text(n.text))).toList(),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _addNote, child: Icon(Icons.add)),
    );
  }
}
```

This skeleton uses a model class (`Note`), a stateful UI, and simple method-based state changes — a common pattern for small apps.

<a id="tips"></a>
## Tips, Common Patterns & Exercises

### Best practices

*   Keep build methods small — extract widgets as methods or separate classes.
*   Prefer immutable data when possible (use `final` fields).
*   Use `const` constructors to improve performance when widgets are immutable.
*   Use `async/await` and handle exceptions with try/catch.

### Practice mini-projects (progression)

1.  Profile card (static UI)
2.  List of items + details (navigation)
3.  API list (Dio) → convert to Bloc
4.  Small CRUD notes app (local persistence)

### Cheat sheet

`Declare variable: var x = 1;`
`Immutable: final vs const`
`Function shorthand: () => expr`
`Nullable type: String?`
`Stateful widget: StatefulWidget + State`
`Navigator push: Navigator.push(...)`

### Further Exercises

*   Convert a stateless widget to stateful and manage a small piece of data.
*   Implement a simple repository class that returns hard-coded data (simulate API).
*   Write unit tests for a Dart function (e.g., add, multiply).

## Next steps & Resources

After you master these basics, move to:

*   State management with **Bloc** (flutter_bloc)
*   Networking with **Dio** and JSON serialization
*   Localization with **flutter_localizations** and **intl**
*   App architecture (Clean Architecture, Repository, UseCases)

Try to build a small project that uses:

*   Bloc for state
*   Dio for API
*   SharedPreferences/Hive for local storage
*   Two languages (localization)

Built for mentors & graduates — copy, adapt, and use in workshops. Happy coding! 🚀

[**Next Module:** Flutter UI Basics - Widgets, layout, theming, responsive design](2_flutter_ui.md)
