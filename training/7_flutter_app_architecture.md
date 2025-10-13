# App Architecture & Dependency Injection

## Overview<a id="overview"></a>
In this section, learners will explore **Clean Architecture**, understand the purpose of **Repository** and **UseCase** layers, and learn to manage **Dependency Injection** using the `get_it` package. This ensures a scalable, maintainable, and testable Flutter application structure.

---

## Introduction to Clean Architecture<a id="introduction-to-clean-architecture"></a>

### What is Clean Architecture?
Clean Architecture is a software design pattern that promotes **separation of concerns** by dividing the app into distinct layers. It ensures that business logic is independent from UI and external frameworks.

### Benefits:
- Easy to maintain and test
- High scalability
- Reusable and decoupled components

### Layer Overview:
```
Presentation Layer  →  UI (Widgets, ViewModels, Bloc)
Domain Layer         →  Business Logic (Entities, UseCases)
Data Layer           →  Data Management (Repositories, APIs, Database)
```

### Visual Representation:
```
+----------------------------+
|        Presentation        |
|  (UI + Bloc/ViewModel)     |
+----------------------------+
            ↓
+----------------------------+
|          Domain            |
|     (UseCases + Entities)  |
+----------------------------+
            ↓
+----------------------------+
|           Data             |
| (Repository + DataSource)  |
+----------------------------+
```

---

## Repository Pattern<a id="repository-pattern"></a>

### Purpose:
The Repository Pattern abstracts data sources (e.g., REST APIs, databases) and provides a clean API for the rest of the app to use.

### Example:
```dart
// data/repositories/user_repository_impl.dart
class UserRepositoryImpl implements UserRepository {
  final UserApi api;

  UserRepositoryImpl(this.api);

  @override
  Future<User> getUserProfile() async {
    final response = await api.fetchUserProfile();
    return User.fromJson(response);
  }
}

// domain/repositories/user_repository.dart
abstract class UserRepository {
  Future<User> getUserProfile();
}
```

---

## UseCase Pattern<a id="usecase-pattern"></a>

### Purpose:
The UseCase layer contains **application-specific business rules**. Each UseCase represents one user action or operation.

### Example:
```dart
// domain/usecases/get_user_profile.dart
class GetUserProfileUseCase {
  final UserRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<User> execute() {
    return repository.getUserProfile();
  }
}
```

UseCases are called from the **Bloc or ViewModel**, keeping logic separate from the UI.

---

## Dependency Injection (DI)<a id="dependency-injection"></a>

### Why DI?
Dependency Injection allows us to manage dependencies (e.g., Repositories, UseCases, APIs) centrally, improving modularity and testing.

### Using `get_it`
`get_it` is a simple service locator for Flutter that makes dependency management easy.

### Setup Example:
```dart
// core/di/injection.dart
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/get_user_profile.dart';

final getIt = GetIt.instance;

void setup() {
  // External dependencies
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Repository
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(UserApi(getIt())),
  );

  // UseCase
  getIt.registerFactory(() => GetUserProfileUseCase(getIt()));
}
```

### Usage:
```dart
void main() {
  setup();
  runApp(MyApp());
}

final useCase = getIt<GetUserProfileUseCase>();
useCase.execute();
```

---

## Integration with Bloc<a id="integration-with-bloc"></a>

You can now inject and use UseCases inside your Bloc easily.

```dart
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserProfileUseCase _getUserProfileUseCase;

  UserBloc(this._getUserProfileUseCase) : super(UserInitial()) {
    on<LoadUserProfile>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await _getUser_profile_use_case.execute();
        emit(UserLoaded(user));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
```

---

## Summary Checklist<a id="summary-checklist"></a>
✅ Understand the **3 layers** of Clean Architecture  
✅ Create **Repository** to abstract data  
✅ Implement **UseCases** for specific business logic  
✅ Use **get_it** for dependency management  
✅ Integrate dependencies into **Bloc** or **ViewModel**

---

## Practice Tasks<a id="practice-tasks"></a>
1. Create a `TodoRepository` and `GetTodoListUseCase`.
2. Set up dependency injection for them using `get_it`.
3. Connect them in a `TodoBloc` that loads todos on app startup.
4. Print todos in the console or display them in a simple UI.
