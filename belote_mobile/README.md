# Belote Mobile App

Flutter-based multiplayer Belote card game implementing Clean Architecture with BLoC pattern for state management.

## 📱 Project Status

**Phase 0 ✅ COMPLETED**: Project Setup & Architecture
- Clean Architecture folder structure
- Dependency injection with get_it + injectable
- Theme system (light/dark mode)
- Navigation with go_router
- Error handling
- Core constants and utilities

**Phase 1 ✅ COMPLETED**: State Management & Core Models
- Domain models (User, Game, Card) with freezed
- JSON serialization
- API client with dio
- Repository interfaces
- Auth BLoC with events and states
- Unit tests

## 🚀 Next Steps - IMPORTANT!

Since Flutter is not available in the build environment, you need to run the following commands **locally on your machine**:

### 1. Install Dependencies

```bash
cd belote_mobile
flutter pub get
```

### 2. Run Code Generation

This is **CRITICAL** - the project uses freezed and injectable which require code generation:

```bash
# Run code generation for all models and dependency injection
flutter pub run build_runner build --delete-conflicting-outputs

# Alternative: Watch mode (auto-generates on file changes)
flutter pub run build_runner watch --delete-conflicting-outputs
```

This will generate:
- `.freezed.dart` files for all freezed models
- `.g.dart` files for JSON serialization
- `injection_container.config.dart` for dependency injection

### 3. Verify the Build

```bash
# Check for any issues
flutter analyze

# Run tests
flutter test

# Try running the app
flutter run
```

### 4. Build for Production

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Android App Bundle (for Play Store)
flutter build appbundle --release
```

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/         # App constants (API URLs, timeouts, etc.)
│   ├── theme/             # App theme (light/dark mode)
│   ├── utils/             # Utility functions
│   ├── errors/            # Error handling (failures, exceptions)
│   ├── network/           # API client with dio
│   ├── di/                # Dependency injection setup
│   ├── presentation/      # Base BLoC classes
│   └── navigation/        # App routing with go_router
├── features/
│   ├── auth/
│   │   ├── data/          # Auth data models, datasources, repositories
│   │   ├── domain/        # Auth entities, repositories, use cases
│   │   └── presentation/  # Auth BLoC, pages, widgets
│   ├── game/
│   │   ├── data/
│   │   ├── domain/        # Game entities (Card, Game, Bid, etc.)
│   │   └── presentation/
│   ├── profile/
│   └── matchmaking/
├── shared/
│   ├── widgets/           # Reusable widgets
│   └── models/            # Shared models
└── main.dart              # Application entry point
```

## 🎯 Architecture

This project follows **Clean Architecture** principles:

- **Presentation Layer**: UI (Pages, Widgets) + BLoC for state management
- **Domain Layer**: Business logic (Entities, Use Cases, Repository Interfaces)
- **Data Layer**: Data sources (API, Local DB) + Repository Implementations

### State Management

Using **BLoC Pattern** (flutter_bloc):
- Separation of business logic from UI
- Predictable state changes
- Easy to test
- Reactive programming with streams

## 🔧 Technologies

### Core
- **Flutter**: 3.16+
- **Dart**: 3.2+

### State Management
- `flutter_bloc`: BLoC pattern
- `equatable`: Value equality

### Dependency Injection
- `get_it`: Service locator
- `injectable`: Code generation for DI

### Navigation
- `go_router`: Declarative routing

### Networking
- `dio`: HTTP client
- `socket_io_client`: Real-time WebSocket
- `pretty_dio_logger`: API logging

### Local Storage
- `hive`: NoSQL database
- `flutter_secure_storage`: Secure token storage
- `shared_preferences`: User preferences

### JSON Serialization
- `freezed`: Immutable models
- `json_serializable`: JSON conversion

### UI/UX
- `flutter_svg`: SVG support
- `flutter_animate`: Animations
- `shimmer`: Loading placeholders
- `cached_network_image`: Image caching

## 🧪 Testing

### Run All Tests

```bash
flutter test
```

### Run Specific Tests

```bash
# Unit tests
flutter test test/features/auth/domain/entities/user_test.dart

# Theme tests
flutter test test/core/theme/app_theme_test.dart
```

### Generate Test Mocks

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 🎨 Theming

The app supports both light and dark themes. Theme can be switched based on system settings.

**Color Palette:**
- Primary Green: `#1B5E20`
- Primary Red: `#C62828`
- Accent Gold: `#FFB300`

**Card Suits:**
- Clubs/Spades: Black `#000000`
- Diamonds/Hearts: Red `#E53935`

## 🔌 API Configuration

Update API URLs in `lib/core/constants/app_constants.dart`:

```dart
static const String baseUrl = String.fromEnvironment(
  'BASE_URL',
  defaultValue: 'http://localhost:3000',
);
```

Or pass environment variables when building:

```bash
flutter run --dart-define=BASE_URL=https://api.yourdomain.com
```

## 🐛 Troubleshooting

### Code Generation Fails

```bash
flutter clean
flutter pub get
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### iOS Build Issues

```bash
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
cd ..
flutter clean
flutter run
```

### Android Build Issues

```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter run
```

### Hot Reload Not Working

```bash
flutter run --no-hot
```

## 📱 Platform Requirements

### iOS
- iOS 12.0+
- Xcode 14+
- CocoaPods

### Android
- Android 5.0+ (API level 21)
- Android Studio with Flutter plugin
- Kotlin 1.9+

## 🚦 Development Workflow

1. **Create a feature branch**
   ```bash
   git checkout -b feature/new-feature
   ```

2. **Make changes with hot reload**
   - Flutter's hot reload works automatically
   - Press `r` to hot reload, `R` to hot restart

3. **Run tests**
   ```bash
   flutter test
   ```

4. **Format code**
   ```bash
   dart format lib/
   ```

5. **Analyze code**
   ```bash
   flutter analyze
   ```

6. **Commit changes**
   ```bash
   git add .
   git commit -m "feat: add new feature"
   ```

## 📦 Dependencies Summary

**State Management**: flutter_bloc, bloc, equatable
**DI**: get_it, injectable
**Navigation**: go_router
**Network**: dio, socket_io_client
**Storage**: hive, flutter_secure_storage
**Serialization**: freezed, json_serializable
**UI/UX**: flutter_svg, flutter_animate, shimmer
**Testing**: mockito, bloc_test

## 📖 Next Implementation Phases

According to the documentation in `/docs`:

- **Phase 2**: Authentication & User Management (6-8 hours)
- **Phase 3**: UI/UX Foundation (8-10 hours)
- **Phase 4**: Game Board UI & Animations (10-12 hours)
- **Phase 5**: Real-time Communication (8-10 hours)
- **Phase 6**: Game Flow Implementation (10-12 hours)
- **Phase 7**: Testing & Deployment (8-10 hours)

See the documentation files in `/docs` for detailed implementation guides.

## ✅ Checklist Before Moving to Phase 2

- [ ] Dependencies installed (`flutter pub get`)
- [ ] Code generation completed successfully
- [ ] No compilation errors (`flutter analyze`)
- [ ] Tests pass (`flutter test`)
- [ ] App runs on emulator/device (`flutter run`)

## 🎉 Getting Started

1. ✅ Read this README
2. ✅ Run `flutter pub get`
3. ✅ Run code generation: `flutter pub run build_runner build --delete-conflicting-outputs`
4. ✅ Run `flutter analyze` to check for issues
5. ✅ Run `flutter test` to verify tests
6. ✅ Run `flutter run` to start the app
7. ✅ Start implementing Phase 2!

## 📝 License

MIT License - See LICENSE file for details.

## 🤝 Contributing

Contributions are welcome! Please follow the established architecture patterns and write tests for new features.

---

**Built with Flutter 🐦 and Clean Architecture 🏗️**
