[← Back to Training Plan](../README.md)

# Widgets, Layout, Theming & Responsive Design

Learn how Flutter builds UIs using widgets, layouts, themes, and how to adapt your app for all screen sizes.

<a id="widgets"></a>
## 1. Widgets — The Building Blocks of Flutter

Everything in Flutter is a widget — from a simple `Text` to a complete `Scaffold`. Widgets are categorized into:

*   **Structural Widgets** — e.g., `Scaffold`, `AppBar`, `Container`.
*   **Styling Widgets** — e.g., `Padding`, `Align`, `Center`.
*   **Functional Widgets** — e.g., `TextField`, `Button`, `Image`.

### Example

```dart
class HelloWidget extends StatelessWidget {
  const HelloWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Hello, Flutter!',
        style: TextStyle(fontSize: 24, color: Colors.blueAccent),
      ),
    );
  }
}
```

**Exercise:** Create a custom widget called `ProfileCard` that displays a user’s avatar, name, and role.

<a id="layout"></a>
## 2. Layout — Organizing Widgets on Screen

Layout widgets define how child widgets are arranged in your app. The most common ones are:

*   **Row** — horizontal alignment
*   **Column** — vertical alignment
*   **Stack** — overlaying elements
*   **Expanded** & **Flexible** — distribute space proportionally
*   **ListView** — scrollable list

### Column Example

```dart
class MyLayout extends StatelessWidget {
  const MyLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Welcome'),
        SizedBox(height: 10),
        Text('This is a column layout'),
      ],
    );
  }
}
```

### Row + Expanded Example

```dart
Row(
  children: [
    Expanded(child: Container(color: Colors.red, height: 50)),
    Expanded(child: Container(color: Colors.green, height: 50)),
    Expanded(child: Container(color: Colors.blue, height: 50)),
  ],
)
```

**Exercise:** Build a simple dashboard using `Row` and `Column` to show 3 statistic boxes horizontally.

<a id="theming"></a>
## 3. Theming — Consistent Styles Across Your App

Flutter uses `ThemeData` to define your app’s visual style: colors, typography, button styles, and more.

### Light/Dark Theme Setup

```dart
MaterialApp(
  title: 'Themed App',
  theme: ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
  ),
  darkTheme: ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(primary: Colors.indigo),
  ),
  themeMode: ThemeMode.system,
  home: const HomePage(),
);
```

### Using Theme in Widgets

```dart
Text(
  'Hello Theme!',
  style: Theme.of(context).textTheme.headlineSmall,
);
```

> **Tip:** Use `Theme.of(context)` to access theme colors and styles anywhere in your widget tree.

### Custom Theme Extension

You can extend `ThemeData` for your brand styles.

```dart
extension AppColors on ThemeData {
  Color get success => Colors.greenAccent;
  Color get danger => Colors.redAccent;
}
```

**Exercise:** Create a custom theme with your own color palette and apply it to all buttons in the app.

<a id="responsive"></a>
## 4. Responsive Design — Adapting to Different Screens

Flutter runs on mobile, tablet, desktop, and web. A good UI must adapt to screen size, orientation, and device type.

### Using `MediaQuery`

```dart
Widget build(BuildContext context) {
  var size = MediaQuery.of(context).size;
  var isTablet = size.width > 600;
  return Center(
    child: Text(isTablet ? 'Tablet view' : 'Mobile view'),
  );
}
```

### LayoutBuilder

`LayoutBuilder` helps you render different widgets depending on available space.

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      return const TabletLayout();
    } else {
      return const MobileLayout();
    }
  },
);
```

### ResponsiveRowColumn (from `flutter_layout_grid`)

Use community packages like `flutter_layout_grid` or `responsive_framework` for advanced layouts.

### OrientationBuilder

```dart
OrientationBuilder(
  builder: (context, orientation) {
    return orientation == Orientation.portrait
        ? const PortraitLayout()
        : const LandscapeLayout();
  },
);
```

**Exercise:** Build a profile screen that switches between a vertical layout (mobile) and a horizontal layout (tablet).

<a id="integration"></a>
## 5. Putting It All Together — Themed, Responsive App

This example combines widgets, layout, theming, and responsiveness.

```dart
class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {
    var isWide = MediaQuery.of(context).size.width > 600;
    final color = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Themed App')),
      body: isWide
        ? Row(
            children: [
              Expanded(child: Container(color: color.withOpacity(0.1))),
              Expanded(child: _content()),
            ],
          )
        : _content(),
    );
  }

  Widget _content() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Hello Flutter UI!'),
          SizedBox(height: 8),
          Text('This adapts to your screen.'),
        ],
      ),
    );
  }
}
```

> **Tip:** Combine layout widgets with theme-aware colors to create beautiful, consistent, and adaptive UIs.

<a id="resources"></a>
## 6. Next Steps & Resources

*   🧱 Learn advanced layout: `GridView`, `CustomScrollView`, `SliverList`
*   🎨 Deep dive into **Material 3 (M3)** and **ColorScheme**
*   📱 Explore **responsive_framework** and **flutter_screenutil**
*   💡 Experiment with adaptive UI using `AdaptiveLayout` (Material 3)

---
© Flutter Mentor Training — Widgets, Layout & Theming. Built for new Flutter developers 🚀
