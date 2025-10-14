[← Back to Training Plan](../README.md)

# State Management (Bloc)

## Overview<a id="overview"></a>
This training module explains **state management using the Bloc pattern**, focusing on the **Event–Bloc–State cycle** and practical usage of the **flutter_bloc** package. The Bloc architecture helps maintain a clean separation between the UI and business logic, leading to predictable and testable applications.

---

## What is Bloc?<a id="what-is-bloc"></a>

**Bloc (Business Logic Component)** is a design pattern that manages how data flows within an application. It converts **events** (user interactions) into **states** (UI updates) using **Streams**.

### Key Concepts:
- **Event** → Represents an action (e.g., button press, data load)
- **State** → Represents the current UI state
- **Bloc** → Receives events, processes logic, and emits new states

---

## Bloc Flow Diagram<a id="bloc-flow-diagram"></a>
```
UI → Event → Bloc → New State → UI
```

### Example:
1. User taps a button → Event is sent to Bloc
2. Bloc processes logic → Emits new State
3. UI listens → Updates based on new State

---

## Installing `flutter_bloc`<a id="installing-flutter_bloc"></a>

Add the following dependency in your **pubspec.yaml** file:

```yaml
dependencies:
  flutter_bloc: ^9.0.0
```

Import the package:

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
```

---

## Bloc Components<a id="bloc-components"></a>

### Event Example
```dart
// counter_event.dart
abstract class CounterEvent {}

class Increment extends CounterEvent {}
class Decrement extends CounterEvent {}
```

### State Example
```dart
// counter_state.dart
class CounterState {
  final int count;

  CounterState(this.count);
}
```

### Bloc Example
```dart
// counter_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<Increment>((event, emit) => emit(CounterState(state.count + 1)));
    on<Decrement>((event, emit) => emit(CounterState(state.count - 1)));
  }
}
```

---

## Integrating Bloc with the UI<a id="integrating-bloc-with-the-ui"></a>

Use `BlocProvider` to inject the Bloc into the widget tree.

```dart
void main() {
  runApp(
    BlocProvider(
      create: (context) => CounterBloc(),
      child: const MyApp(),
    ),
  );
}
```

### Using BlocBuilder
```dart
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter with Bloc')),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Text(
              'Count: ${state.count}',
              style: const TextStyle(fontSize: 32),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<CounterBloc>().add(Decrement()),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () => context.read<CounterBloc>().add(Increment()),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
```

---

## BlocListener & BlocConsumer<a id="bloclistener--blocconsumer"></a>

Use these widgets when you need to react to **state changes** beyond just UI rebuilding.

```dart
BlocListener<CounterBloc, CounterState>(
  listener: (context, state) {
    if (state.count == 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Count reached 10!')),
      );
    }
  },
  child: BlocBuilder<CounterBloc, CounterState>(
    builder: (context, state) => Text('Count: ${state.count}'),
  ),
)
```

---

## Advantages of Bloc<a id="advantages-of-bloc"></a>
✅ Predictable state changes  
✅ Improved testability  
✅ Centralized business logic  
✅ Works well with Clean Architecture

---

## Example Folder Structure<a id="example-folder-structure"></a>
```
lib/
├── blocs/
│   └── counter_bloc.dart
├── models/
│   └── counter_state.dart
├── ui/
│   └── counter_page.dart
└── main.dart
```

---

## Practice Tasks<a id="practice-tasks"></a>
1. Create a `LoginBloc` with events: `LoginSubmitted` and states: `LoginLoading`, `LoginSuccess`, `LoginFailure`.
2. Implement BlocBuilder to show loading and success states in the UI.
3. Add form validation using Bloc events and states.

[**Next Module:** Form Handling - TextFormField, validation, Bloc form handling](6_flutter_form_handling.md)
