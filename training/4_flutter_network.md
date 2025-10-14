[← Back to Training Plan](../README.md)

# API Integration with Dio - GET/POST Requests, JSON Parsing & Repository Pattern

## Introduction to Dio

**Dio** is a powerful HTTP client for Dart and Flutter that supports
interceptors, global configuration, FormData, request cancellation, and more. It’s
widely used for handling network requests efficiently.

```yaml
dependencies:
  dio: ^5.0.0
```

Install dependencies by running:

```shell
flutter pub get
```

## Making a GET Request

Use Dio to fetch data from a REST API endpoint:

```dart
import 'package:dio/dio.dart';

final dio = Dio();

Future<void> fetchUsers() async {
  try {
    final response = await dio.get('https://jsonplaceholder.typicode.com/users');
    print(response.data);
  } catch (e) {
    print('Error: $e');
  }
}
```

**Explanation:**

*   `dio.get()` sends a GET request to the specified URL.
*   Response data can be directly accessed using `response.data`.
*   Use `try-catch` for error handling.

## Making a POST Request

Send data to a server using POST requests:

```dart
Future<void> createUser() async {
  try {
    final response = await dio.post(
      'https://jsonplaceholder.typicode.com/users',
      data: {
        'name': 'John Doe',
        'email': 'john@example.com',
      },
    );
    print(response.data);
  } catch (e) {
    print('Error: $e');
  }
}
```

**Notes:**

*   Use `data` parameter to pass the request body.
*   Ensure your API endpoint supports POST operations.

## JSON Parsing in Flutter

Convert JSON data from the API into Dart model objects for better structure and
readability.

```dart
class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
```

Parsing API response:

```dart
Future<List<User>> fetchUsers() async {
  final response = await dio.get('https://jsonplaceholder.typicode.com/users');
  final List usersJson = response.data;
  return usersJson.map((json) => User.fromJson(json)).toList();
}
```

## Repository Pattern

The Repository pattern helps separate the data layer from the UI and business logic
layers, improving maintainability and testability.

```dart
// user_repository.dart
import 'package:dio/dio.dart';
import 'user_model.dart';

class UserRepository {
  final Dio _dio = Dio();

  Future<List<User>> getUsers() async {
    final response = await _dio.get('https://jsonplaceholder.typicode.com/users');
    final List data = response.data;
    return data.map((json) => User.fromJson(json)).toList();
  }

  Future<User> createUser(User user) async {
    final response = await _dio.post(
      'https://jsonplaceholder.typicode.com/users',
      data: {
        'name': user.name,
        'email': user.email,
      },
    );
    return User.fromJson(response.data);
  }
}
```

**Advantages:**

*   Separates concerns – UI doesn’t handle networking directly.
*   Improves testability by mocking the repository.
*   Makes future refactors easier (e.g., switching APIs).

## Practical Example: Fetch & Display Data

```dart
class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserRepository _repository = UserRepository();
  late Future<List<User>> usersFuture;

  @override
  void initState() {
    super.initState();
    usersFuture = _repository.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: FutureBuilder<List<User>>(
        future: usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          }
          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
              );
            },
          );
        },
      ),
    );
  }
}
```

This example demonstrates a full cycle: fetching API data, parsing JSON, and displaying
it using Flutter widgets.

## Summary

*   Used **Dio** for GET/POST requests.
*   Learned **JSON parsing** into model classes.
*   Implemented **Repository pattern** for clean architecture.
*   Displayed API data in Flutter UI.

With these concepts, you can now confidently connect your Flutter apps to RESTful APIs in
a structured and maintainable way.

[**Next Module:** State Management (Bloc) - Event–Bloc–State cycle, flutter_bloc usage](5_flutter_bloc_state_management.md)
