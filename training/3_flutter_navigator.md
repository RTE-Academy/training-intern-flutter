# Flutter Navigation 1.0, Data Passing & Routing Setup

Step-by-step learning guide for beginners

## Introduction

Navigation in Flutter allows you to move between different screens (called **routes**).
The `Navigator` widget manages a stack of routes — each time you navigate, a new route is pushed onto the stack, and when you go back, it’s popped off.

- **Navigator 1.0** uses an imperative approach (push and pop).
- **Navigator 2.0** is declarative and more advanced (used for large apps).

## Methods

The most common methods used for navigation are:

- `Navigator.push()` – Navigate to a new screen.
- `Navigator.pop()` – Go back to the previous screen.
- `Navigator.pushReplacement()` – Replace the current route with a new one.
- `Navigator.pushNamed()` – Navigate using route names (configured in `MaterialApp`).

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SecondScreen()),
);

// Go back
Navigator.pop(context);
```

## Data Passing

You can pass data when navigating to a new screen by using constructor parameters. The receiving screen should have a property to accept the data.

```dart
// Passing data
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailScreen(data: 'Hello from Home!'),
  ),
);

// Receiving data in DetailScreen
class DetailScreen extends StatelessWidget {
  final String data;

  const DetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Screen')),
      body: Center(
        child: Text(data, style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
```

You can also return data when popping back to the previous screen using `Navigator.pop(context, result)`.

## Named Routes

Named routes make navigation more organized and scalable. You define route names in `MaterialApp` and call them using `Navigator.pushNamed()`.

```dart
void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(),
      '/detail': (context) => DetailScreen(data: 'Data from named route'),
    },
  ));
}

// Navigate using route name
Navigator.pushNamed(context, '/detail');
```

You can also pass arguments through named routes using `Navigator.pushNamed()` and retrieve them via `ModalRoute.of(context)!.settings.arguments`.

```dart
// Passing arguments
Navigator.pushNamed(
  context,
  '/detail',
  arguments: 'Data from Home',
);

// Receiving arguments
final args = ModalRoute.of(context)!.settings.arguments as String;
```

## Example

Complete Example: Two-Screen Navigation

```dart
// main.dart
void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(
        child: ElevatedButton(
          child: Text('Go to Details'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailScreen(data: 'From Home!')),
            );
          },
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String data;
  const DetailScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data, style: TextStyle(fontSize: 20)),
            ElevatedButton(
              child: Text('Go Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

## Best Practices

- Keep routes organized in a separate file if your app grows large.
- Use named routes for better maintainability.
- Always handle null-safety when receiving data via `ModalRoute`.
- Prefer **Navigator 2.0** for apps requiring deep linking or complex navigation flows.
