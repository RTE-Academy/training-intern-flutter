# Flutter Training: Localization (Multi-language)

## Overview<a id="overview"></a>
This module covers **localization (multi-language support)** in Flutter applications using the **intl** package and **JSON-based translations**. Learners will understand how to set up multi-language support, switch languages dynamically, and manage localized content efficiently.

---

## What is Localization?<a id="what-is-localization"></a>
Localization (L10n) is the process of adapting your app to different **languages** and **cultures**. It involves translating text and formatting numbers, dates, and currencies according to local conventions.

### Benefits
- Reach a wider audience globally
- Enhance user experience
- Comply with regional preferences and standards

---

## Required Packages<a id="required-packages"></a>
Add the following dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0
```

---

## Folder Structure<a id="folder-structure"></a>
```
lib/
├── l10n/
│   ├── en.json
│   ├── vi.json
│   └── es.json
├── main.dart
└── localization/
    └── app_localizations.dart
```

---

## Creating JSON Files<a id="creating-json-files"></a>
Define key-value pairs for each supported language.

### Example: `l10n/en.json`
```json
{
  "title": "Welcome",
  "greeting": "Hello, {name}!",
  "language": "English"
}
```

### Example: `l10n/vi.json`
```json
{
  "title": "Chào mừng",
  "greeting": "Xin chào, {name}!",
  "language": "Tiếng Việt"
}
```

---

## Create `AppLocalizations` Helper<a id="create-applocalizations-helper"></a>
```dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  Future<void> load() async {
    String jsonString = await rootBundle.loadString('l10n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key, {Map<String, String>? params}) {
    var value = _localizedStrings[key] ?? key;
    if (params != null) {
      params.forEach((paramKey, paramValue) {
        value = value.replaceAll('{$paramKey}', paramValue);
      });
    }
    return value;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
```

---

## Update `main.dart`<a id="update-main-dart"></a>
```dart
import 'package:flutter/material.dart';
import 'localization/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void _switchLanguage(String languageCode) {
    setState(() {
      _locale = Locale(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('vi', ''),
        Locale('es', ''),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      home: HomePage(onLanguageSwitch: _switchLanguage),
    );
  }
}

class HomePage extends StatelessWidget {
  final Function(String) onLanguageSwitch;

  const HomePage({super.key, required this.onLanguageSwitch});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('title'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(loc.translate('greeting', params: {'name': 'Alex'})),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => onLanguageSwitch('vi'),
              child: const Text('Tiếng Việt'),
            ),
            ElevatedButton(
              onPressed: () => onLanguageSwitch('en'),
              child: const Text('English'),
            ),
            ElevatedButton(
              onPressed: () => onLanguageSwitch('es'),
              child: const Text('Español'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Adding New Languages<a id="adding-new-languages"></a>
To support a new language:
1. Create a new JSON file (e.g., `fr.json`)
2. Add translated text inside
3. Add `Locale('fr', '')` to the supportedLocales list
4. Rebuild the app

---

## Summary Checklist<a id="summary-checklist"></a>
✅ Add `intl` and `flutter_localizations` dependencies  
✅ Create language JSON files  
✅ Implement custom localization class  
✅ Integrate with MaterialApp and LocalizationsDelegates  
✅ Implement language switch dynamically

---

## Practice Tasks<a id="practice-tasks"></a>
1. Add a new language (e.g., Japanese) and create a corresponding JSON file.  
2. Add dynamic string parameters such as `greeting` → “Hello, {name}!”  
3. Display localized date/time using `intl`:

```dart
import 'package:intl/intl.dart';

final formattedDate = DateFormat.yMMMMd('vi').format(DateTime.now());
print(formattedDate); // 6 tháng 10, 2025
```

---

**Next Module:** Theming and Responsive Design – Understanding color schemes, typography, and layout adaptation.
