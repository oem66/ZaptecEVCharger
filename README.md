# ZaptecEVCharger

# ZaptecEVCharger ⚡🔌

A **Kotlin Multiplatform Mobile (KMM)** application with native **iOS SwiftUI** interface for monitoring and controlling **Zaptec EV chargers**. This cross-platform solution shares business logic between Android and iOS while maintaining platform-specific, native user interfaces.

## 📱 Features

### Core Functionality
- **Real-time charger monitoring** with live status updates
- **Remote charging control** (start/stop/pause charging sessions)
- **Multi-charger management** for installations with multiple charging points
- **Charging session history** and analytics
- **Smart charging scheduling** with off-peak optimization
- **Authentication management** for secure charger access
- **Energy consumption tracking** and cost calculations

### Smart Features
- **Dynamic Load Management** monitoring and controls
- **Phase balancing** status and configuration
- **Eco Mode integration** for optimal electricity rates
- **Real-time fault detection** and diagnostic reporting
- **User authentication** via RFID, app, or native methods
- **Installation-level controls** affecting multiple chargers

## 🏗️ Architecture

This project leverages **Kotlin Multiplatform Mobile** to maximize code sharing while providing native user experiences:

### Shared Module (Kotlin)
```
shared/
├── commonMain/           # Platform-agnostic business logic
│   ├── domain/
│   │   ├── models/       # Charger, Session, Installation models
│   │   ├── repositories/ # Data access abstractions
│   │   └── usecases/     # Business logic operations
│   ├── data/
│   │   ├── remote/       # Zaptec API client
│   │   ├── local/        # Local storage/caching
│   │   └── mappers/      # Data transformation
│   └── utils/            # Shared utilities
├── androidMain/          # Android-specific implementations
└── iosMain/              # iOS-specific implementations
```

### iOS Module (SwiftUI)
```
iosApp/
├── UI/
│   ├── Views/            # SwiftUI views and components
│   ├── ViewModels/       # MVVM pattern with ObservableObject
│   └── Components/       # Reusable UI components
├── Services/             # iOS-specific services
└── Utils/                # iOS utilities and extensions
```

### Android Module (Jetpack Compose)
```
androidApp/
├── ui/
│   ├── screens/          # Compose screens
│   ├── components/       # Reusable composables
│   └── theme/            # Material Design theme
├── presentation/         # ViewModels and UI state
└── di/                   # Dependency injection
```

## 🔧 Technical Stack

### Shared (Kotlin Multiplatform)
- **Kotlin Multiplatform Mobile** - Cross-platform development
- **Ktor Client** - HTTP networking for Zaptec API integration
- **Kotlinx Serialization** - JSON parsing and data serialization
- **Kotlinx Coroutines** - Asynchronous programming
- **SQLDelight** - Cross-platform database solution
- **Koin** - Dependency injection framework

### iOS Specific
- **SwiftUI** - Modern declarative UI framework
- **Combine** - Reactive programming for data binding
- **CoreLocation** - Location services for charger discovery
- **UserNotifications** - Push notifications for charger events

### Android Specific
- **Jetpack Compose** - Modern Android UI toolkit
- **Hilt** - Dependency injection
- **Room** - Local database
- **WorkManager** - Background task scheduling

## 📋 Prerequisites

### Development Environment
- **Xcode 14.0+** (for iOS development)
- **Android Studio Electric Eel** or later
- **Kotlin Multiplatform Mobile plugin**
- **JDK 11** or higher

### Platform Requirements
- **iOS 15.0+** / **Android API 24+**
- **Internet connection** for Zaptec Cloud API access
- **Zaptec Portal account** with registered charger(s)

## ⚡ Zaptec Integration

### API Access
This app integrates with the **Zaptec Cloud REST API** to provide:

- **Installation Management**: Access to charger installations
- **Charger Control**: Start/stop/pause charging operations
- **Real-time Data**: Live status, power consumption, session info
- **Authentication**: RFID, app-based, and native authentication
- **Diagnostics**: Fault detection and system health monitoring

### Supported Zaptec Models
- **Zaptec Pro** - Commercial charging stations
- **Zaptec Go** - Residential smart chargers
- **Zaptec Go 2** - Latest generation home chargers

## 🚀 Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/oem66/ZaptecEVCharger.git
cd ZaptecEVCharger
```

### 2. Configure Zaptec API Access

#### Create API Configuration
1. Log in to [Zaptec Portal](https://portal.zaptec.com)
2. Navigate to **Integrations** → **API Access**
3. Generate API credentials (Client ID, Client Secret)
4. Note your installation IDs and charger serial numbers

#### Add Credentials
Create `local.properties` in the project root:
```properties
ZAPTEC_CLIENT_ID=your_client_id_here
ZAPTEC_CLIENT_SECRET=your_client_secret_here
ZAPTEC_BASE_URL=https://api.zaptec.com/
```

### 3. Build and Run

#### iOS App
1. Open the project in Android Studio
2. Sync the project and build the shared module
3. Open `iosApp/iosApp.xcworkspace` in Xcode
4. Select your target device/simulator
5. Build and run (`⌘ + R`)

#### Android App
1. Open the project in Android Studio
2. Sync project with Gradle files
3. Select your target device/emulator
4. Build and run (`Shift + F10`)

## 📊 Project Structure

```
ZaptecEVCharger/
├── shared/                    # Kotlin Multiplatform shared module
│   ├── src/
│   │   ├── commonMain/kotlin/
│   │   │   ├── domain/
│   │   │   │   ├── models/
│   │   │   │   │   ├── Charger.kt
│   │   │   │   │   ├── ChargingSession.kt
│   │   │   │   │   ├── Installation.kt
│   │   │   │   │   └── AuthState.kt
│   │   │   │   ├── repositories/
│   │   │   │   │   ├── ChargerRepository.kt
│   │   │   │   │   └── AuthRepository.kt
│   │   │   │   └── usecases/
│   │   │   │       ├── GetChargersUseCase.kt
│   │   │   │       ├── StartChargingUseCase.kt
│   │   │   │       └── StopChargingUseCase.kt
│   │   │   ├── data/
│   │   │   │   ├── remote/
│   │   │   │   │   ├── ZaptecApiClient.kt
│   │   │   │   │   ├── dto/
│   │   │   │   │   └── endpoints/
│   │   │   │   ├── local/
│   │   │   │   │   └── DatabaseHelper.kt
│   │   │   │   └── repositories/
│   │   │   │       ├── ChargerRepositoryImpl.kt
│   │   │   │       └── AuthRepositoryImpl.kt
│   │   │   └── utils/
│   │   │       ├── Constants.kt
│   │   │       └── DateTimeUtils.kt
│   │   ├── androidMain/kotlin/
│   │   │   └── platform/
│   │   │       └── DatabaseDriver.kt
│   │   └── iosMain/kotlin/
│   │       └── platform/
│   │           └── DatabaseDriver.kt
│   └── build.gradle.kts
├── androidApp/               # Android Jetpack Compose app
│   ├── src/main/kotlin/
│   │   ├── ui/
│   │   │   ├── screens/
│   │   │   ├── components/
│   │   │   └── theme/
│   │   ├── presentation/
│   │   └── di/
│   └── build.gradle.kts
├── iosApp/                   # iOS SwiftUI app
│   ├── iosApp/
│   │   ├── UI/
│   │   │   ├── Views/
│   │   │   │   ├── ChargerListView.swift
│   │   │   │   ├── ChargerDetailView.swift
│   │   │   │   ├── ChargingControlView.swift
│   │   │   │   └── SettingsView.swift
│   │   │   ├── ViewModels/
│   │   │   │   ├── ChargerListViewModel.swift
│   │   │   │   └── ChargerDetailViewModel.swift
│   │   │   └── Components/
│   │   │       ├── ChargerStatusCard.swift
│   │   │       └── ChargingProgressView.swift
│   │   ├── Services/
│   │   └── Utils/
│   ├── iosApp.xcodeproj
│   └── iosApp.xcworkspace
├── gradle/
├── build.gradle.kts
└── settings.gradle.kts
```

## 🔌 API Integration Details

### Zaptec Cloud API Endpoints
The app integrates with key Zaptec API endpoints:

#### Authentication
- `POST /oauth/token` - Obtain access tokens
- `POST /oauth/refresh` - Refresh expired tokens

#### Installations & Chargers
- `GET /api/installations` - List user's installations
- `GET /api/chargers` - Get chargers for installation
- `GET /api/chargers/{id}/state` - Real-time charger state

#### Charging Control
- `POST /api/chargers/{id}/start` - Start charging session
- `POST /api/chargers/{id}/stop` - Stop charging session
- `PUT /api/chargers/{id}/settings` - Update charger settings

#### Session Management
- `GET /api/chargingsessions` - Historical charging sessions
- `GET /api/chargingsessions/{id}` - Detailed session data

### Real-time Updates
The app implements **WebSocket connections** for real-time charger state updates:
- Live power consumption monitoring
- Charging status changes
- Fault detection and alerts
- Authentication state changes

## 🎨 User Interface

### iOS (SwiftUI) Features
- **Native iOS design** following Apple Human Interface Guidelines
- **Dynamic Island** integration for charging status (iOS 16+)
- **Widgets** for quick charger status on home screen
- **Haptic feedback** for user interactions
- **Dark/Light mode** support with system theme detection

### Android (Jetpack Compose) Features
- **Material Design 3** components and theming
- **Adaptive layouts** for tablets and foldables
- **Quick Settings tiles** for rapid charger control
- **Notification actions** for charging management
- **Dynamic color** support (Android 12+)

## ⚙️ Configuration

### Environment Variables
```properties
# Zaptec API Configuration
ZAPTEC_CLIENT_ID=your_client_id
ZAPTEC_CLIENT_SECRET=your_client_secret
ZAPTEC_BASE_URL=https://api.zaptec.com/

# Optional: Custom timeouts
NETWORK_TIMEOUT_MS=30000
WEBSOCKET_TIMEOUT_MS=60000

# Feature Flags
ENABLE_REAL_TIME_UPDATES=true
ENABLE_OFFLINE_MODE=true
```

### Build Variants
- **Debug**: Development builds with extensive logging
- **Staging**: Pre-production testing environment
- **Release**: Production builds with optimizations

## 🔒 Security & Privacy

### Data Protection
- **OAuth 2.0** authentication with Zaptec Cloud
- **Token refresh** handling for secure session management
- **Local encryption** for cached authentication data
- **Certificate pinning** for API communications

### Privacy Considerations
- **Minimal data collection** - only necessary charger operational data
- **Local data storage** with iOS Keychain and Android Keystore
- **No tracking** or analytics without explicit consent
- **GDPR compliance** for European users

## 🧪 Testing

### Shared Module Tests
```bash
# Run shared module tests
./gradlew :shared:testDebugUnitTest

# Run iOS-specific tests
./gradlew :shared:iosSimulatorArm64Test
```

### iOS Tests
```bash
# Run from Xcode or command line
xcodebuild test -workspace iosApp.xcworkspace -scheme iosApp -destination 'platform=iOS Simulator,name=iPhone 14'
```

### Android Tests
```bash
# Unit tests
./gradlew :androidApp:testDebugUnitTest

# UI tests
./gradlew :androidApp:connectedDebugAndroidTest
```

## 📚 Key Dependencies

### Shared Dependencies
```kotlin
// build.gradle.kts (shared)
kotlin {
    sourceSets {
        commonMain.dependencies {
            implementation("io.ktor:ktor-client-core:2.3.5")
            implementation("io.ktor:ktor-client-content-negotiation:2.3.5")
            implementation("io.ktor:ktor-serialization-kotlinx-json:2.3.5")
            implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.7.3")
            implementation("app.cash.sqldelight:runtime:2.0.0")
            implementation("io.insert-koin:koin-core:3.5.0")
        }
    }
}
```

## 🤝 Contributing

### Development Workflow
1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/smart-scheduling`)
3. **Implement** changes following coding standards
4. **Test** across both platforms
5. **Submit** a pull request with detailed description

### Code Style
- **Kotlin**: Follow [Kotlin Coding Conventions](https://kotlinlang.org/docs/coding-conventions.html)
- **Swift**: Adhere to [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- **Formatting**: Use respective IDE formatters (ktlint for Kotlin, SwiftFormat for Swift)

## 📄 License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **[Zaptec](https://zaptec.com)** for providing robust EV charging solutions and API access
- **[JetBrains](https://jetbrains.com)** for Kotlin Multiplatform technology
- **[Apple](https://apple.com)** for SwiftUI framework and development tools
- **[Google](https://google.com)** for Android development platform and Jetpack Compose

## 📞 Support

### Getting Help
- **Issues**: Report bugs and feature requests via [GitHub Issues](https://github.com/oem66/ZaptecEVCharger/issues)
- **Discussions**: Join community discussions in [GitHub Discussions](https://github.com/oem66/ZaptecEVCharger/discussions)
- **Zaptec API**: Official documentation at [docs.zaptec.com](https://docs.zaptec.com)

### FAQ

**Q: Do I need a Zaptec charger to use this app?**
A: Yes, this app is specifically designed for Zaptec EV chargers and requires a registered Zaptec Portal account.

**Q: Does the app work offline?**
A: Limited functionality is available offline (cached data, local settings), but real-time control requires internet connectivity.

**Q: Can I control multiple chargers?**
A: Yes, the app supports installations with multiple chargers and provides unified management.

---

**⚡ Power your EV charging experience with modern cross-platform technology!**
