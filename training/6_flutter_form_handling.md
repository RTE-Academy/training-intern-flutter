[← Back to Training Plan](../README.md)

# Flutter Form Handling – TextFormField, Validation, and Bloc Integration

## Introduction<a id="introduction"></a>
Form handling is an essential part of Flutter development when working with user inputs such as login, registration, and feedback forms. Flutter provides powerful widgets and packages to handle input fields, validation, and state management effectively.

This lesson covers:
- **TextFormField** widget basics
- **Form** widget and validation
- **Bloc-based form handling** for clean architecture

---

## Understanding `TextFormField`<a id="understanding-textformfield"></a>
`TextFormField` is a widget used to collect and validate user input. It provides built-in support for form validation and input decoration.

### Example:
```dart
TextFormField(
  decoration: const InputDecoration(
    labelText: 'Email',
    border: OutlineInputBorder(),
  ),
  keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!value.contains('@')) {
      return 'Enter a valid email';
    }
    return null;
  },
)
```

**Key points:**
- `decoration`: Defines label, hint, and border style.
- `validator`: Provides a function to validate input.
- Returns a string message when invalid, or `null` when valid.

---

## Using `Form` and `GlobalKey`<a id="using-form-and-globalkey"></a>
A `Form` groups multiple input fields and helps manage their validation state.

### Example:
```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        decoration: const InputDecoration(labelText: 'Username'),
        validator: (value) => value!.isEmpty ? 'Enter a username' : null,
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Form is valid!')),
            );
          }
        },
        child: const Text('Submit'),
      ),
    ],
  ),
)
```

**Explanation:**
- `GlobalKey<FormState>` is used to access form state and trigger validation.
- `FormState.validate()` runs all validators in the form.
- `SnackBar` gives user feedback upon success.

---

## Bloc Form Handling<a id="bloc-form-handling"></a>
For larger applications, handling form validation using **Bloc** improves scalability and separation of concerns.

### Folder structure example:
```
lib/
 ├── bloc/
 │    ├── form_bloc.dart
 │    ├── form_event.dart
 │    └── form_state.dart
 ├── ui/
 │    └── form_page.dart
```

### Bloc Implementation
**form_event.dart:**
```dart
abstract class FormEvent {}
class EmailChanged extends FormEvent {
  final String email;
  EmailChanged(this.email);
}
class PasswordChanged extends FormEvent {
  final String password;
  PasswordChanged(this.password);
}
class FormSubmitted extends FormEvent {}
```

**form_state.dart:**
```dart
class FormState {
  final String email;
  final String password;
  final bool isValid;
  final bool isSubmitting;

  FormState({
    this.email = '',
    this.password = '',
    this.isValid = false,
    this.isSubmitting = false,
  });

  FormState copyWith({
    String? email,
    String? password,
    bool? isValid,
    bool? isSubmitting,
  }) => FormState(
        email: email ?? this.email,
        password: password ?? this.password,
        isValid: isValid ?? this.isValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
      );
}
```

**form_bloc.dart:**
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'form_event.dart';
import 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc() : super(FormState()) {
    on<EmailChanged>((event, emit) {
      final isValid = event.email.contains('@') && state.password.length > 5;
      emit(state.copyWith(email: event.email, isValid: isValid));
    });

    on<PasswordChanged>((event, emit) {
      final isValid = state.email.contains('@') && event.password.length > 5;
      emit(state.copyWith(password: event.password, isValid: isValid));
    });

    on<FormSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(isSubmitting: false));
    });
  }
}
```

### UI Integration
```dart
class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FormBloc(),
      child: BlocBuilder<FormBloc, FormState>(
        builder: (context, state) {
          final bloc = context.read<FormBloc>();
          return Scaffold(
            appBar: AppBar(title: const Text('Bloc Form Example')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    onChanged: (value) => bloc.add(EmailChanged(value)),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onChanged: (value) => bloc.add(PasswordChanged(value)),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: state.isValid
                        ? () => bloc.add(FormSubmitted())
                        : null,
                    child: state.isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Submit'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
```

---

## Best Practices<a id="best-practices"></a>
- Always separate validation and business logic using Bloc or a controller.
- Avoid inline validation logic in the UI when scaling.
- Use `FormState` to track form submission and loading.
- Display feedback using SnackBars or Toasts.

---

## Summary<a id="summary"></a>
By the end of this lesson, you should be able to:
- Use `TextFormField` with custom validators.
- Group input fields using `Form` and validate them.
- Implement Bloc-based form handling for maintainable and scalable apps.

With this knowledge, you can now handle any type of user form in Flutter efficiently and cleanly!

[**Next Module:** App Architecture & Dependency Injection - Clean Architecture, Repository & UseCase, get_it.](7_flutter_app_architecture.md)
