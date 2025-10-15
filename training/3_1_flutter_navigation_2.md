# Flutter Navigation 2.0 – Router, RouteInformationParser, RouterDelegate

<a id="overview"></a>
## Overview
Flutter Navigation 2.0 introduces a declarative way to handle app navigation.  
Instead of relying on `Navigator.push()` and `pop()`, you now define your navigation state directly in your app.  
This approach gives more control, especially for **deep linking**, **web URL routing**, and **state-based navigation** (e.g., for authentication).

---

<a id="key-concepts"></a>
## Key Concepts

<a id="route-information"></a>
### 1. RouteInformation
- Represents the current navigation state (like a URL).
- Used mainly on web and desktop platforms.

```dart
class RouteInformation {
  final String location;
  final Object? state;
}
```

Example:
```dart
RouteInformation(location: '/home');
```

---

<a id="route-information-parser"></a>
### 2. RouteInformationParser
- Converts `RouteInformation` into a **custom app state** (like `AppRoutePath`).
- Think of it as parsing the URL into something the app can understand.

```dart
class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');
    if (uri.pathSegments.isEmpty) {
      return AppRoutePath.home();
    } else if (uri.pathSegments.length == 1 && uri.pathSegments.first == 'details') {
      return AppRoutePath.details();
    }
    return AppRoutePath.unknown();
  }
}
```

---

<a id="router-delegate"></a>
### 3. RouterDelegate
- Responsible for **building the Navigator** based on the parsed route state.
- Handles navigation logic declaratively (no `push()` or `pop()` calls directly).

```dart
class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  AppRoutePath _path = AppRoutePath.home();

  @override
  AppRoutePath? get currentConfiguration => _path;

  void _handleDetails() {
    _path = AppRoutePath.details();
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(child: HomeScreen(onDetailsPressed: _handleDetails)),
        if (_path.isDetailsPage)
          MaterialPage(child: DetailsScreen(onBack: () {
            _path = AppRoutePath.home();
            notifyListeners();
          })),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        _path = AppRoutePath.home();
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    _path = configuration;
  }
}
```

---

<a id="route-path-model"></a>
### 4. Route Path Model

```dart
class AppRoutePath {
  final bool isHomePage;
  final bool isDetailsPage;

  AppRoutePath.home()
      : isHomePage = true,
        isDetailsPage = false;

  AppRoutePath.details()
      : isHomePage = false,
        isDetailsPage = true;

  AppRoutePath.unknown()
      : isHomePage = false,
        isDetailsPage = false;
}
```

---

<a id="putting-it-all-together"></a>
## Putting It All Together

In your `MaterialApp`, replace `home:` with the `Router` widget:

```dart
class MyApp extends StatelessWidget {
  final AppRouterDelegate _routerDelegate = AppRouterDelegate();
  final AppRouteInformationParser _routeParser = AppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeParser,
    );
  }
}
```

---

<a id="handling-deep-links"></a>
## Handling Deep Links
With Navigation 2.0, Flutter automatically syncs your app routes with browser URLs.  
For example:
```
https://myapp.com/details
```
Will automatically navigate to your details page through `RouteInformationParser`.

---

<a id="common-use-cases"></a>
## Common Use Cases

| Use Case | Implementation |
|-----------|----------------|
| Web deep links | `RouteInformationParser` |
| Auth flow control | RouterDelegate updates based on `isLoggedIn` |
| Nested navigation | Multiple Routers or `Navigator` within pages |
| State restoration | Use `currentConfiguration` to restore route |

---

<a id="best-practices"></a>
## Best Practices

1. **Use Navigation 2.0 for large or web-enabled apps.**
2. For mobile-only apps, Navigator 1.0 is often simpler.
3. Use `go_router` or `auto_route` to simplify Navigation 2.0 setup.
4. Keep route state inside a `ChangeNotifier` or `Cubit` for maintainability.

---

<a id="challenge-for-students"></a>
## Challenge for Students
- Convert an existing Navigator 1.0 project to Navigation 2.0.
- Implement a `login → home → detail` flow with proper back navigation.
- Add deep link support for `/details/:id`.

---

<a id="bonus-go-router"></a>
## Bonus: Simplifying with go_router
Instead of writing RouterDelegate/Parser manually:

```dart
final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/details', builder: (context, state) => DetailsScreen()),
  ],
);
```

Then in `MaterialApp.router`:
```dart
MaterialApp.router(
  routerConfig: router,
);
```

---

<a id="references"></a>
## References
- [Flutter Docs – Declarative Navigation](https://docs.flutter.dev/development/ui/navigation)
- [go_router package](https://pub.dev/packages/go_router)
- [auto_route package](https://pub.dev/packages/auto_route)

[**Next Module:** API Integration with Dio - GET/POST requests, JSON parsing, repository pattern](4_flutter_network.md)
