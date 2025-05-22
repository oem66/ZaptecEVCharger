# ZaptecEVCharger

This README guides new developers through our project's tools and techniques for debugging, performance monitoring, and development. For more detailed information, please refer to the specific files and folders mentioned.
This guide provides a comprehensive overview to ease the initial setup and ongoing development for new team members. Always refer to inline comments and documentation in code files for detailed explanations.

## Table of Contents
1. [Debugging and Performance Monitoring](#debugging-and-performance-monitoring)
2. [Local Data Persistence](#local-data-persistence)
3. [SwiftUI](#uikit-and-swiftui-integration)
4. [UIView Management](#uiview-management)
5. [Maintaining the README](#maintaining-the-readme)
6. [Project Management](#project-management)
7. [TestFlight Distribution](#testflight-distribution)
8. [Project Structure](#swiftui-project-structure-mvvm-with-coordinator-pattern)

## Debugging and Performance Monitoring

### Unified Logging System
We use Apple's Unified Logging System for detailed and efficient logging. For implementation details, see `Log.swift` in the `Debugging` folder.

#### OSLog
- **Creating a Log Handler:** Use `createLog(category: String)` to initiate logging.
- **Logging Messages:** Apply `log(message: StaticString, type: OSLogType, category: String, content: CVarArg)`.
- **Viewing Logs:** After running the project, open the Console app and search for your logs. Filter messages by "Subsystem" or "Bundle Identifier".

#### OSSignpostLog
- **Synchronous Tasks:**
  - Start with `osSignPost(type: .begin, ...)`, and complete with `osSignPost(type: .end, ...)`.
- **Asynchronous Tasks:**
  - Generate identifiers with `osSignPostID(log: OSLog)`.
  - Record events using `osSignPost(withSignPostID: OSSignpostID, type: OSSignpostType, ...)`.
- **Testing:** Monitor logs using Instruments by selecting `Profile` in Xcode's `Product` menu.

### Performance Monitoring Tips
- **Instruments:** Use Instruments to track performance issues and resource usage effectively.

## Local Data Persistence

### RepoCoreData.swift
Located in the `Repository Layer` folder, this class abstracts Core Data operations:
- **Basic Operations:** Methods like `get()`, `create()`, `delete()`, etc.
- **Error Handling:** Utilizes result types for cleaner error handling.

## UIKit and SwiftUI Integration

### Bridging UIKit with SwiftUI
- **Preview Setups:** Extend `UIViewController` to integrate SwiftUI previews, bridging UIKit and SwiftUI for better design and testing workflows.

## UIView Management

### Programmatic UIKit Views
- **Policy:** All new UI components must be created programmatically using UIKit. Avoid using Storyboards or XIB files.
- **Migration:** Existing views in Storyboards or SwiftUI must be migrated to programmatic UIKit views. This ensures consistency and maintainability of our codebase.

## Maintaining the README

- **Shared Responsibility:** All team members are responsible for updating this README when changes affect how the project is built or the structure of the code. This ensures the document remains useful and accurate.
- **Procedure:** When modifying features or practices described here, include a corresponding update in this README as part of your pull request.

## Project Management

### Task and Time Management with Trello
- **Story Points:** Each story point represents one day of work for a developer. Assign story points to tasks based on this scale.
- **Due Dates:** Set due dates in Trello considering the assigned story points and accounting for weekends, leave, and vacation days. This helps in estimating when tasks will be completed.
- **Workflow:**
  1. When a task is started, set the story points by estimating the work in days.
  2. Calculate the due date based on the number of story points and add it to Trello.
  3. Adjust the schedule as necessary to reflect actual working days and non-working days.

## TestFlight Distribution

### Tagging Builds for UX Review
- **Process:** When a build is ready for UX review, it should be tagged and distributed via TestFlight.
- **Steps:**
  1. Ensure the build passes all tests and adheres to the latest project standards.
  2. Tag the build in the version control system with an appropriate version number and description.
  3. Distribute the build through TestFlight by tagging the commit with "testflight".
  4. Notify the UX team through our communication channels that a new build is available for review.
  
# SwiftUI Project Structure: MVVM

This README outlines our approach to structuring SwiftUI projects using the MVVM (Model-View-ViewModel) architecture pattern in combination with the new NavigationPath for navigation.

## Table of Contents PS
[Home](#table-of-contents)
1. [Overall Structure](#overall-structure)
2. [MVVM Pattern](#mvvm-pattern)
3. [NavigationPath](#navigation)
4. [File Organization](#file-organization)
5. [Naming Conventions](#naming-conventions)
6. [Best Practices](#best-practices)

## Overall Structure

Our app is structured using the following components:

- **Views**: SwiftUI views that represent the UI
- **ViewModels**: Objects that contain the business logic and state for views
- **Models**: Data structures that represent our core data
- **Services**: Objects that handle external interactions (e.g., networking, persistence)

## Model View View-Model Pattern

### Views

- Create a separate SwiftUI view file for each screen or major UI component.
- Views should be as "dumb" as possible, primarily handling layout and user input.
- Use `@ObservedObject` or `@StateObject` to connect to ViewModels.

Example:

```swift
// Features/Login/Views/LoginView.swift
struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
            SecureField("Password", text: $viewModel.password)
            Button("Login", action: viewModel.login)
        }
    }
}
```

### ViewModels

- Create a ViewModel for each View that requires business logic or state management.
- Use `@Published` properties for data that the View needs to observe.
- Implement methods for user actions and business logic.

Example:

```swift
// Features/Login/ViewModels/LoginViewModel.swift
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false

    func login() {
        isLoading = true
        // Perform login logic...
    }
}
```

### Models

- Create plain Swift structs or classes to represent your data.
- Conform to `Codable` if the model needs to be serialized/deserialized.

Example:

```swift
// Shared/Models/User.swift
struct User: Codable, Identifiable {
    let id = UUID()
    let name: String
    let email: String
}
```

## NavigationPath

### Programmatic Navigation with NavigationStack

- Create an `NavigationPath` property to manage the overall navigation flow of the app.
- The `NavigationPath` should manage navigation destinations for different parts of the app.

Example:

```swift
// ContentView.swift
enum NavigationDestinations: String, CaseIterable, Hashable {
    case Details
    case Profiles
    case Settings
}

struct ContentView: View {
    let screens = NavigationDestinations.allCases
    @State private var navigationPath = NavigationPath()
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 40) {
                ForEach(screens, id: \.self) { screen in
                    NavigationLink(value: screen) {
                        Text(screen.rawValue)
                    }
                }
            }
            .navigationTitle("Main View")
            .navigationDestination(for: NavigationDestinations.self) { screen in
                switch screen {
                case .Details:
                    DetailsScreen()
                case .Profiles:
                    ProfileScreen()
                case .Settings:
                    SettingsScreen()
                }
            }
        }
    }
}
```

### Programatically push a new view

- Use the append(_:) method on the NavigationPath to add a new element representing the view you want to push. The new element can be any data type that conforms to Hashable.

Example:

```swift
.navigationDestination(for: NavigationDestinations.self) { screen in
    switch screen {
    case .Details:
        DetailsScreen()
    case .Profiles:
        ProfileScreen()
    case .Settings:
        SettingsScreen()
    }
    
    Button("Add view") {
        navigationPath.append(NavigationDestinations.Details)
    }
}
```

### Programatically pop a view

- Use the removeLast() method on the NavigationPath to remove the last element, effectively popping the topmost view from the stack.

Example:

```swift
.navigationDestination(for: NavigationDestinations.self) { screen in
    switch screen {
    case .Details:
        DetailsScreen()
    case .Profiles:
        ProfileScreen()
    case .Settings:
        SettingsScreen()
    }
    Button("Add view") {
        navigationPath.append(NavigationDestinations.Details)
    }
    Button("Back") {
        navigationPath.removeLast()
    }
}
```

## File Organization
### Source Organization

```
LearnNorwegian/
└── Learn Norwegian/
    ├── Application/
    │   ├── LearnNorwegianApp.swift
    │   └── Assets
    ├── Features/
    │   ├── Login/
    │   ├── Profile/
    │   ├── InterestSelector/
    │   └── ...
    ├── Shared/
    │   ├── Models/
    │   ├── Views/
    │   ├── ViewModels/
    │   └── Utilities/
    ├── Services/
    │   ├── NetworkService/
    │   ├── StorageService/
    │   └── ...
    ├── Coordinators/
    ├── Config/
    └── Managers/
```

### Key Components

1. **App:**
   - Contains the main app file and the AppCoordinator.
   - Example: `KrownApp.swift`, `AppCoordinator.swift`

2. **Features:**
   Each feature has its own dedicated folder (e.g., Login, Profile, InterestSelector). Within each feature folder, we follow an MVVM-based structure:

   ```
   Features/
   └── FeatureName/
       ├── Views/
       │   ├── FeatureNameView.swift
       │   └── SubViews/
       ├── ViewModels/
       │   └── FeatureNameViewModel.swift
       ├── Models/
       │   └── FeatureSpecificModel.swift
       ├── Coordinators/
       │   └── FeatureNameCoordinator.swift
       │
       ├── Services/ (if needed)
       │
       └── Utilities/ (if needed)
   ```

   - **Views/**: Contains SwiftUI views and any UIKit views if needed.
   - **ViewModels/**: Houses the view models for the feature.
   - **Models/**: Contains feature-specific model structs or classes.
   - **Coordinators/**: Includes the coordinator for managing the feature's flow.
   - **Utilities/**: Optional folder for feature-specific utilities.

3. **Shared:**
   - Contains elements used across multiple features.
   - Subfolders include:
     - **Models/**: For shared data models (e.g., `User.swift`, `InterestModel.swift`)
     - **Views/**: For reusable UI components (e.g., `CustomButton.swift`, `LoadingView.swift`)
     - **ViewModels/**: For shared view models (e.g., `SearchViewModel.swift`)
     - **Utilities/**: For shared utility functions and extensions (e.g., `DateFormatter+Extensions.swift`)

4. **Services:**
   - Houses service layers for external interactions.
   - Examples: `NetworkService`, `StorageService`, `LocationService`

5. **Coordinators:**
   - Contains coordinator protocols and any shared coordinator logic.
   - Example: `Coordinator.swift`, `NavigationCoordinator.swift`

6. **Config:**
   - Stores configuration-related files.
   - Examples: `AppConfig.swift`, `EnvironmentConfig.swift`

7. **Managers:**
   - Contains managers for specific app functionalities.
   - Examples: `LocationManager.swift`, `NotificationManager.swift`

## Naming Conventions

- **Views**: Suffix with `View` (e.g., `LoginView`, `ProfileView`)
- **ViewModels**: Suffix with `ViewModel` (e.g., `LoginViewModel`, `ProfileViewModel`)
- **Coordinators**: Suffix with `Coordinator` (e.g., `LoginCoordinator`, `ProfileCoordinator`)
- **Services**: Suffix with `Service` (e.g., `NetworkService`, `StorageService`)

## Best Practices

1. **Dependency Injection**: Pass dependencies to ViewModels and Coordinators rather than creating them internally. Consider using a dependency injection framework for larger projects.

2. **State Management**: Use `@Published` properties in ViewModels for state that needs to be observed by Views. For complex state management, consider using Redux-like patterns or libraries.

3. **Navigation**: Handle navigation logic in Coordinators, not in Views or ViewModels. Use SwiftUI's `NavigationView` and `NavigationLink` for simple navigation within a feature.

4. **Testing**: Write unit tests for ViewModels and Coordinators. Use protocol-based dependencies to facilitate mocking. Aim for high test coverage, especially for business logic.

5. **Reusability**: Create generic, reusable components when possible. Place these in the Shared/Views folder for app-wide use.

6. **Error Handling**: Implement consistent error handling throughout the app, possibly using a centralized error handling service. Use Swift's Result type for functions that can fail.

7. **Localization**: Use SwiftUI's built-in localization features and keep all user-facing strings in localization files. Consider using a string catalog for better organization.

8. **Accessibility**: Implement accessibility features in all Views. Use SwiftUI's built-in accessibility modifiers and test with VoiceOver.

9. **Performance**: Be mindful of performance, especially in lists and collections. Use `LazyVStack` and `LazyHStack` for large collections of views.

10. **Combine**: Leverage the Combine framework for handling asynchronous events and data streams in ViewModels.



## Guidelines for Developers

1. Place shared models, views, and utilities in the appropriate Shared subfolder. If a component is used in more than one feature, move it to Shared.

2. Keep feature-specific code within its respective feature folder. This includes views, view models, and feature-specific models.

3. Use coordinators to manage navigation and flow within features and across the app. Each feature should have its own coordinator.

4. Implement services for all external interactions (e.g., networking, storage, location). These should be protocol-based for easier testing and mocking.

5. Use the Config folder for app-wide configuration settings. This includes environment-specific configurations and feature flags.

6. Place app-wide managers in the Managers folder. These should be singletons or use dependency injection.

7. Maintain consistency in naming conventions:
   - Views: Suffix with `View` (e.g., `LoginView`, `ProfileView`)
   - ViewModels: Suffix with `ViewModel` (e.g., `LoginViewModel`, `ProfileViewModel`)
   - Coordinators: Suffix with `Coordinator` (e.g., `LoginCoordinator`, `ProfileCoordinator`)
   - Services: Suffix with `Service` (e.g., `NetworkService`, `StorageService`)

8. When adding new shared functionality, consider which folder it best fits into based on its purpose and scope. Discuss with the team if unsure.

9. For SwiftUI and UIKit integration, use `UIViewRepresentable` or `UIViewControllerRepresentable` in the feature's Views folder. Minimize use of UIKit where possible.

10. Follow SwiftUI best practices:
    - Use `@State` for simple view-local state and `@StateObject` for complex view-local state
    - Prefer small, focused views over large, complex ones
    - Use `PreviewProvider` for SwiftUI previews to speed up development

11. **Statically Typed Fonts and Colors**: Use the custom `AppFont` enum and `Color` extension for consistent typography and color schemes across the app.

    For Fonts:
    ```swift
    // In SwiftUI
    Text("Hello, World!")
        .font(.avenir(size: 16, weight: .medium))
    ```

    For Colors:
    ```swift
    // In SwiftUI
    Text("Hello, World!")
        .foregroundColor(.royalPurple)
    ```

12. Document your code, especially public interfaces and complex logic. Use clear, concise comments and consider generating documentation.

13. Regularly review and refactor code to maintain code quality and prevent technical debt.

By following these guidelines and best practices, we ensure a consistent, maintainable, and scalable codebase for our SwiftUI project. Remember that these guidelines should evolve with the project and team's needs.
