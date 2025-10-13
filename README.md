# Traning Flutter
Flutter version: 3.24.3
## Training
1. [Introduction to Flutter & Dart](training/1_dart.md)
    - [Overview](training/1_dart.md#overview)
    - [Dart Basics (Syntax & Core Concepts)](training/1_dart.md#dart-basics)
    - [Flutter Structure (Widgets & Layout)](training/1_dart.md#flutter-structure)
    - [OOP in Dart — Core Concepts](training/1_dart.md#oop)
    - [Putting it together — Example: Simple Note App Skeleton](training/1_dart.md#integration)
    - [Tips, Common Patterns & Exercises](training/1_dart.md#tips)
2. [Flutter UI Basics](training/2_flutter_ui.md)
    - [Widgets — The Building Blocks of Flutter](training/2_flutter_ui.md#widgets)
    - [Layout — Organizing Widgets on Screen](training/2_flutter_ui.md#layout)
    - [Theming — Consistent Styles Across Your App](training/2_flutter_ui.md#theming)
    - [Responsive Design — Adapting to Different Screens](training/2_flutter_ui.md#responsive)
    - [Putting It All Together — Themed, Responsive App](training/2_flutter_ui.md#integration)
    - [Next Steps & Resources](training/2_flutter_ui.md#resources)
3. [Navigation & Routing](training/3_flutter_navigator.md)
    - [Introduction to Navigation in Flutter](training/3_flutter_navigator.md#introduction)
    - [Basic Navigator 1.0 Methods](training/3_flutter_navigator.md#methods)
    - [Passing Data Between Screens](training/3_flutter_navigator.md#data-passing)
    - [Setting Up Named Routes](training/3_flutter_navigator.md#named-routes)
    - [Complete Example: Two-Screen Navigation](training/3_flutter_navigator.md#example)
    - [Best Practices & Tips](training/3_flutter_navigator.md#best-practices)
4. [API Integration with Dio](training/4_flutter_network.md)
    - [Introduction to Dio](training/4_flutter_network.md#introduction-to-dio)
    - [Making a GET Request](training/4_flutter_network.md#making-a-get-request)
    - [Making a POST Request](training/4_flutter_network.md#making-a-post-request)
    - [JSON Parsing in Flutter](training/4_flutter_network.md#json-parsing-in-flutter)
    - [Repository Pattern](training/4_flutter_network.md#repository-pattern)
    - [Practical Example: Fetch & Display Data](training/4_flutter_network.md#practical-example-fetch--display-data)
    - [Summary](training/4_flutter_network.md#summary)
5. [State Management (Bloc)](training/5_flutter_bloc_state_management.md)
    - [Overview](training/5_flutter_bloc_state_management.md#overview)
    - [What is Bloc?](training/5_flutter_bloc_state_management.md#what-is-bloc)
    - [Bloc Flow Diagram](training/5_flutter_bloc_state_management.md#bloc-flow-diagram)
    - [Installing `flutter_bloc`](training/5_flutter_bloc_state_management.md#installing-flutter_bloc)
    - [Bloc Components](training/5_flutter_bloc_state_management.md#bloc-components)
    - [Integrating Bloc with the UI](training/5_flutter_bloc_state_management.md#integrating-bloc-with-the-ui)
    - [BlocListener & BlocConsumer](training/5_flutter_bloc_state_management.md#bloclistener--blocconsumer)
    - [Advantages of Bloc](training/5_flutter_bloc_state_management.md#advantages-of-bloc)
    - [Example Folder Structure](training/5_flutter_bloc_state_management.md#example-folder-structure)
    - [Practice Tasks](training/5_flutter_bloc_state_management.md#practice-tasks)
6. [Form Handling](training/6_flutter_form_handling.md)
    - [Introduction](training/6_flutter_form_handling.md#introduction)
    - [Understanding `TextFormField`](training/6_flutter_form_handling.md#understanding-textformfield)
    - [Using `Form` and `GlobalKey`](training/6_flutter_form_handling.md#using-form-and-globalkey)
    - [Bloc Form Handling](training/6_flutter_form_handling.md#bloc-form-handling)
    - [Best Practices](training/6_flutter_form_handling.md#best-practices)
    - [Summary](training/6_flutter_form_handling.md#summary)
7. [App Architecture & Dependency Injection](training/7_flutter_app_architecture.md)
    - [Overview](training/7_flutter_app_architecture.md#overview)
    - [Introduction to Clean Architecture](training/7_flutter_app_architecture.md#introduction-to-clean-architecture)
    - [Repository Pattern](training/7_flutter_app_architecture.md#repository-pattern)
    - [UseCase Pattern](training/7_flutter_app_architecture.md#usecase-pattern)
    - [Dependency Injection](training/7_flutter_app_architecture.md#dependency-injection)
    - [Integration with Bloc](training/7_flutter_app_architecture.md#integration-with-bloc)
    - [Summary Checklist](training/7_flutter_app_architecture.md#summary-checklist)
    - [Practice Tasks](training/7_flutter_app_architecture.md#practice-tasks)
8. [Localization (Multi-language)](training/8_flutter_localization_training.md)
    - [Overview](training/8_flutter_localization_training.md#overview)
    - [What is Localization?](training/8_flutter_localization_training.md#what-is-localization)
    - [Required Packages](training/8_flutter_localization_training.md#required-packages)
    - [Folder Structure](training/8_flutter_localization_training.md#folder-structure)
    - [Creating JSON Files](training/8_flutter_localization_training.md#creating-json-files)
    - [Create `AppLocalizations` Helper](training/8_flutter_localization_training.md#create-applocalizations-helper)
    - [Update `main.dart`](training/8_flutter_localization_training.md#update-main-dart)
    - [Adding New Languages](training/8_flutter_localization_training.md#adding-new-languages)
    - [Summary Checklist](training/8_flutter_localization_training.md#summary-checklist)
    - [Practice Tasks](training/8_flutter_localization_training.md#practice-tasks)
9. [Persistence & Preferences](training/9_flutter_persistence_preferences.md)
    - [Overview](training/9_flutter_persistence_preferences.md#overview)
    - [Why Persistence Matters](training/9_flutter_persistence_preferences.md#why-persistence-matters)
    - [SharedPreferences – Key-Value Storage](training/9_flutter_persistence_preferences.md#sharedpreferences--key-value-storage)
    - [Hive – Local NoSQL Database](training/9_flutter_persistence_preferences.md#hive--local-nosql-database)
    - [Applying Theme & Language Preferences](training/9_flutter_persistence_preferences.md#applying-theme--language-preferences)
    - [Comparing SharedPreferences vs Hive](training/9_flutter_persistence_preferences.md#comparing-sharedpreferences-vs-hive)
    - [Best Practices](training/9_flutter_persistence_preferences.md#best-practices)
    - [Practice Tasks](training/9_flutter_persistence_preferences.md#practice-tasks)
10. **Individual Project Development: Movie App with TMDb**
    - **Objective:** To build a complete, production-ready Flutter application by applying all the concepts learned in the training program (Modules 1-9). This project will test your ability to integrate various technologies into a cohesive, well-structured app.
    - **Core Requirements:**
        - **Architecture:** Implement Clean Architecture, clearly separating the Presentation, Domain, and Data layers.
        - **State Management:** Use the Bloc pattern for all state management.
        - **API Integration:** Fetch all movie data from The Movie Database (TMDb) API using the `dio` package.
        - **Dependency Injection:** Manage all dependencies using the `get_it` service locator.
        - **Persistence:** Use `shared_preferences` or `hive` to save user preferences like theme and language.
        - **Localization:** Implement multi-language support for at least two languages (e.g., English and Vietnamese).
    - **Feature Set:**
        - **Movie Lists:**
            - A home screen displaying multiple horizontally-scrolling lists for "Now Playing," "Popular," "Top Rated," and "Upcoming" movies.
            - Implement pagination or infinite scrolling for vertical movie lists.
        - **Movie Details:**
            - A detail screen that shows comprehensive information for a selected movie, including its poster, backdrop, title, overview, user rating, release date, and cast members.
        - **Search:**
            - A search screen allowing users to find movies by title.
        - **Settings:**
            - A settings screen where users can switch between light/dark themes and change the application language. All preferences must be persisted locally.
    - **API Specification:**
        - You must use **The Movie Database (TMDb) API**.
        - Register for a free API key at [themoviedb.org](https://www.themoviedb.org/signup).
        - Key endpoints to use: `/movie/now_playing`, `/movie/popular`, `/movie/top_rated`, `/movie/upcoming`, `/movie/{movie_id}`, `/search/movie`.
    - **Bonus Features (Optional):**
        - **Favorites:** Allow users to mark movies as favorites and view them in a separate list. Store favorites locally.
        - **Animations:** Add subtle animations and transitions to improve the user experience.
        - **Offline Caching:** Cache API data using `hive` to allow for basic offline browsing.
    - **Evaluation Criteria:**
        - **Code Quality:** Readability, structure, and adherence to Clean Architecture principles.
        - **Functionality:** All core features are implemented and working correctly.
        - **State Management:** Correct and efficient use of the Bloc pattern.
        - **UI/UX:** A clean, responsive, and intuitive user interface.
        - **Version Control:** Consistent and meaningful Git commits.
11. **Presentation & Review**
    - **Objective:** To evaluate the intern's progress, code quality, and understanding of the concepts applied in the final project. This process ensures continuous feedback and high-quality output.
    - **Process:**
        - **Pull Request (PR) Reviews:** All new features must be submitted as a pull request to the `dev` branch. Each PR will be thoroughly reviewed by a mentor before being merged. This is a critical step for maintaining code quality.
        - **Regular Evaluations:** Evaluation sessions will be held once or twice a week.
    - **Evaluation Criteria:**
        - **UI/UX Assessment:** The application's user interface and user experience will be evaluated for its design, usability, and responsiveness.
        - **Technical Understanding:** Interns will be assessed on their understanding of Flutter, the project's architecture, and their ability to explain and resolve issues found in the source code.
        - **Code Quality:** Adherence to Clean Architecture, best practices, and overall code readability.
