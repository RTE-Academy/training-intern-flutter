[← Back to Training Plan](../README.md)

# Flutter Training: Persistence & Preferences

## Overview<a id="overview"></a>
In this module, learners will explore **data persistence** and **user preferences** in Flutter applications. We'll cover two main approaches:
- **SharedPreferences** – for lightweight key-value storage
- **Hive** – for structured, fast, and offline data storage

Additionally, learners will implement **theme and language storage** using these tools.

---

## Why Persistence Matters<a id="why-persistence-matters"></a>
Persistence allows data to be saved locally on a user’s device, even after the app is closed. This helps maintain user preferences (e.g., theme, language) or cache data for offline access.

**Common use cases:**
- Storing authentication tokens
- Remembering app settings (dark/light mode)
- Caching API responses
- Saving onboarding status

---

## SharedPreferences – Key-Value Storage<a id="sharedpreferences--key-value-storage"></a>

### Installation
```yaml
dependencies:
  shared_preferences: ^2.3.2
```

### Basic Usage
```dart
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  Future<void> saveTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkMode') ?? false;
  }

  Future<void> saveLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', langCode);
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('languageCode') ?? 'en';
  }
}
```

---

## Hive – Local NoSQL Database<a id="hive--local-nosql-database"></a>

### Installation
```yaml
dependencies:
  hive: ^2.2.3
  hive_flutter: ^1.1.0
```

### Setup
```dart
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('settings');
  runApp(MyApp());
}
```

### Usage Example
```dart
class SettingsRepository {
  final Box box = Hive.box('settings');

  void saveTheme(bool isDarkMode) {
    box.put('isDarkMode', isDarkMode);
  }

  bool getTheme() {
    return box.get('isDarkMode', defaultValue: false);
  }

  void saveLanguage(String langCode) {
    box.put('languageCode', langCode);
  }

  String getLanguage() {
    return box.get('languageCode', defaultValue: 'en');
  }
}
```

---

## Applying Theme & Language Preferences<a id="applying-theme--language-preferences"></a>

### Example: Loading Preferences on Startup
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenceService();
  final isDark = await prefs.getTheme();
  final languageCode = await prefs.getLanguage();

  runApp(MyApp(isDark: isDark, languageCode: languageCode));
}
```

### Using Saved Preferences
```dart
class MyApp extends StatefulWidget {
  final bool isDark;
  final String languageCode;

  const MyApp({super.key, required this.isDark, required this.languageCode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDarkMode;
  late Locale _locale;

  @override
  void initState() {
    _isDarkMode = widget.isDark;
    _locale = Locale(widget.languageCode);
    super.initState();
  }

  void _toggleTheme(bool value) async {
    final prefs = PreferenceService();
    await prefs.saveTheme(value);
    setState(() => _isDarkMode = value);
  }

  void _switchLanguage(String code) async {
    final prefs = PreferenceService();
    await prefs.saveLanguage(code);
    setState(() => _locale = Locale(code));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: _locale,
      supportedLocales: const [Locale('en'), Locale('vi')],
      home: SettingsPage(
        onThemeChanged: _toggleTheme,
        onLanguageChanged: _switchLanguage,
      ),
    );
  }
}
```

---

## Comparing SharedPreferences vs Hive<a id="comparing-sharedpreferences-vs-hive"></a>

| Feature | SharedPreferences | Hive |
|----------|--------------------|------|
| Type | Key-Value | NoSQL Database |
| Performance | Good | Excellent |
| Data Structure | Simple | Complex/Nested |
| Encryption | No | Optional with Hive EncryptedBox |
| Ideal For | Settings, Tokens | Offline Data, Structured Cache |

---

## Best Practices<a id="best-practices"></a>
✅ Use SharedPreferences for lightweight preferences (theme, language)  
✅ Use Hive for structured or cached data  
✅ Always initialize Hive before using it  
✅ Keep a single source of truth (e.g., Repository pattern)  
✅ Don’t store sensitive info unencrypted  

---

## Practice Tasks<a id="practice-tasks"></a>
1. Save user theme selection (dark/light) using SharedPreferences.  
2. Implement language preference persistence using Hive.  
3. Add a toggle in the settings screen to change theme and language dynamically.  
4. Create a repository that abstracts preference storage logic.  

---

[← Back to Training Plan](../README.md)