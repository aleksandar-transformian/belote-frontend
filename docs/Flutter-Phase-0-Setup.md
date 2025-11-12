# Flutter Phase 0: Project Setup & Architecture

## 🎯 Objectives
- Initialize Flutter project with proper structure
- Set up Clean Architecture folder organization
- Configure dependencies and code generation
- Implement dependency injection with get_it
- Set up theming system (light/dark mode)
- Configure environment variables
- Set up navigation with go_router

## ⏱️ Estimated Time: 4-6 hours

## 📋 Prerequisites
- Flutter SDK 3.16+ installed
- Dart SDK 3.2+
- Android Studio / Xcode installed
- VS Code with Flutter extension (recommended)

---

## 🚀 Step 1: Create Flutter Project

```bash
# Create new Flutter project
flutter create --org com.belote belote_mobile
cd belote_mobile

# Test that it runs
flutter run
```

---

## 📦 Step 2: Add Dependencies

Update `pubspec.yaml`:

```yaml
name: belote_mobile
description: Multiplayer Belote card game
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.2.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # State Management
  flutter_bloc: ^8.1.3
  bloc: ^8.1.2
  equatable: ^2.0.5

  # Dependency Injection
  get_it: ^7.6.4
  injectable: ^2.3.2

  # Navigation
  go_router: ^13.0.0

  # Network
  dio: ^5.4.0
  socket_io_client: ^2.0.3+1
  pretty_dio_logger: ^1.3.1

  # Local Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  flutter_secure_storage: ^9.0.0
  shared_preferences: ^2.2.2

  # JSON Serialization
  json_annotation: ^4.8.1
  freezed_annotation: ^2.4.1

  # UI/UX
  flutter_svg: ^2.0.9
  flutter_animate: ^4.3.0
  shimmer: ^3.0.0
  fluttertoast: ^8.2.4
  cached_network_image: ^3.3.1

  # Utilities
  intl: ^0.19.0
  logger: ^2.0.2+1
  connectivity_plus: ^5.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter

  # Linting
  flutter_lints: ^3.0.1

  # Code Generation
  build_runner: ^2.4.7
  json_serializable: ^6.7.1
  freezed: ^2.4.6
  injectable_generator: ^2.4.1
  hive_generator: ^2.0.1

  # Testing
  mockito: ^5.4.4
  bloc_test: ^9.1.5
  mocktail: ^1.0.2

flutter:
  uses-material-design: true

  assets:
    - assets/images/
    - assets/icons/
    - assets/sounds/
    - assets/cards/

  fonts:
    - family: Roboto
      fonts:
        - asset: assets/fonts/Roboto-Regular.ttf
        - asset: assets/fonts/Roboto-Bold.ttf
          weight: 700
```

Install dependencies:
```bash
flutter pub get
```

---

## 📁 Step 3: Create Clean Architecture Structure

```bash
# Create directory structure
mkdir -p lib/core/constants
mkdir -p lib/core/theme
mkdir -p lib/core/utils
mkdir -p lib/core/errors
mkdir -p lib/core/network
mkdir -p lib/core/di

mkdir -p lib/features/auth/data/models
mkdir -p lib/features/auth/data/datasources
mkdir -p lib/features/auth/data/repositories
mkdir -p lib/features/auth/domain/entities
mkdir -p lib/features/auth/domain/repositories
mkdir -p lib/features/auth/domain/usecases
mkdir -p lib/features/auth/presentation/bloc
mkdir -p lib/features/auth/presentation/pages
mkdir -p lib/features/auth/presentation/widgets

mkdir -p lib/features/game/data/models
mkdir -p lib/features/game/data/datasources
mkdir -p lib/features/game/data/repositories
mkdir -p lib/features/game/domain/entities
mkdir -p lib/features/game/domain/repositories
mkdir -p lib/features/game/domain/usecases
mkdir -p lib/features/game/presentation/bloc
mkdir -p lib/features/game/presentation/pages
mkdir -p lib/features/game/presentation/widgets

mkdir -p lib/features/profile/data
mkdir -p lib/features/profile/domain
mkdir -p lib/features/profile/presentation

mkdir -p lib/features/matchmaking/data
mkdir -p lib/features/matchmaking/domain
mkdir -p lib/features/matchmaking/presentation

mkdir -p lib/shared/widgets
mkdir -p lib/shared/models

mkdir -p assets/images
mkdir -p assets/icons
mkdir -p assets/sounds
mkdir -p assets/cards
mkdir -p assets/fonts
```

---

## 🎨 Step 4: Theme System

Create `lib/core/theme/app_theme.dart`:

```dart
import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryGreen = Color(0xFF1B5E20);
  static const Color primaryRed = Color(0xFFC62828);
  static const Color accentGold = Color(0xFFFFB300);
  
  static const Color clubsColor = Color(0xFF000000);
  static const Color diamondsColor = Color(0xFFE53935);
  static const Color heartsColor = Color(0xFFE53935);
  static const Color spadesColor = Color(0xFF000000);

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: primaryGreen,
      secondary: accentGold,
      error: primaryRed,
      background: const Color(0xFFFAFAFA),
      surface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: primaryGreen,
      foregroundColor: Colors.white,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.grey[100],
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
      bodySmall: TextStyle(fontSize: 12),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: primaryGreen,
      secondary: accentGold,
      error: primaryRed,
      background: const Color(0xFF121212),
      surface: const Color(0xFF1E1E1E),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Color(0xFF1E1E1E),
    ),
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: const Color(0xFF2C2C2C),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: const Color(0xFF2C2C2C),
    ),
  );
}
```

---

## 🔧 Step 5: Constants

Create `lib/core/constants/app_constants.dart`:

```dart
class AppConstants {
  // API
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://localhost:3000',
  );
  static const String apiVersion = 'v1';
  static const String apiPrefix = '/api/$apiVersion';
  
  // WebSocket
  static const String socketUrl = String.fromEnvironment(
    'SOCKET_URL',
    defaultValue: 'http://localhost:3000',
  );
  
  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String themeKey = 'theme_mode';
  
  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Game
  static const int maxPlayers = 4;
  static const int cardsPerPlayer = 8;
  static const int matchPointsToWin = 151;
  
  // Pagination
  static const int defaultPageSize = 20;
  
  // Animation
  static const Duration cardAnimationDuration = Duration(milliseconds: 300);
  static const Duration trickAnimationDuration = Duration(milliseconds: 500);
}

class AppStrings {
  static const String appName = 'Belote';
  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNetwork = 'No internet connection.';
  static const String errorAuth = 'Authentication failed.';
  static const String errorServer = 'Server error. Please try again later.';
}

class AppAssets {
  static const String _imagesPath = 'assets/images';
  static const String _iconsPath = 'assets/icons';
  static const String _cardsPath = 'assets/cards';
  
  // Images
  static const String logo = '$_imagesPath/logo.png';
  static const String gameBoardBackground = '$_imagesPath/game_board_bg.png';
  
  // Icons
  static const String clubsIcon = '$_iconsPath/clubs.svg';
  static const String diamondsIcon = '$_iconsPath/diamonds.svg';
  static const String heartsIcon = '$_iconsPath/hearts.svg';
  static const String spadesIcon = '$_iconsPath/spades.svg';
  
  // Card back
  static const String cardBack = '$_cardsPath/card_back.png';
}
```

---

## 🛠️ Step 6: Dependency Injection Setup

Create `lib/core/di/injection_container.dart`:

```dart
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

import 'injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.connectTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
```

Create `build.yaml` in project root:

```yaml
targets:
  $default:
    builders:
      injectable_generator:injectable_builder:
        options:
          auto_register: true
          # if you want to use relative imports
          class_name_pattern: "Impl$|Service$"
```

---

## 🚏 Step 7: Navigation Setup

Create `lib/core/navigation/app_router.dart`:

```dart
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String game = '/game';
  static const String matchmaking = '/matchmaking';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: profile,
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: game,
        builder: (context, state) {
          final gameId = state.uri.queryParameters['id'];
          return GamePage(gameId: gameId ?? '');
        },
      ),
      GoRoute(
        path: matchmaking,
        builder: (context, state) => const MatchmakingPage(),
      ),
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );
}

// Placeholder pages (will be implemented in later phases)
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Login')),
    body: const Center(child: Text('Login Page')),
  );
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Register')),
    body: const Center(child: Text('Register Page')),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Home')),
    body: const Center(child: Text('Home Page')),
  );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Profile')),
    body: const Center(child: Text('Profile Page')),
  );
}

class GamePage extends StatelessWidget {
  final String gameId;
  const GamePage({super.key, required this.gameId});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Game')),
    body: Center(child: Text('Game: $gameId')),
  );
}

class MatchmakingPage extends StatelessWidget {
  const MatchmakingPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Matchmaking')),
    body: const Center(child: Text('Finding match...')),
  );
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(child: Text('Page not found')),
  );
}
```

---

## 🏗️ Step 8: Main Application

Update `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'core/navigation/app_router.dart';
import 'core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Initialize dependency injection
  await configureDependencies();
  
  runApp(const BeloteApp());
}

class BeloteApp extends StatelessWidget {
  const BeloteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
```

---

## 🔍 Step 9: Error Handling

Create `lib/core/errors/failures.dart`:

```dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  
  const Failure(this.message);
  
  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
```

Create `lib/core/errors/exceptions.dart`:

```dart
class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
}

class AuthenticationException implements Exception {
  final String message;
  const AuthenticationException(this.message);
}

class CacheException implements Exception {
  final String message;
  const CacheException(this.message);
}
```

---

## 🧪 Step 10: Testing Setup

Create `test/helpers/test_helper.dart`:

```dart
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([
  Dio,
  FlutterSecureStorage,
  SharedPreferences,
])
void main() {}
```

Run code generation:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Create `test/core/theme/app_theme_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:belote_mobile/core/theme/app_theme.dart';

void main() {
  group('AppTheme', () {
    test('light theme should have correct primary color', () {
      expect(
        AppTheme.lightTheme.colorScheme.primary,
        AppTheme.primaryGreen,
      );
    });

    test('dark theme should have dark background', () {
      expect(
        AppTheme.darkTheme.brightness,
        Brightness.dark,
      );
    });
  });
}
```

---

## 🔧 Step 11: Build Configuration

### iOS Configuration

Update `ios/Runner/Info.plist`:

```xml
<key>CFBundleDisplayName</key>
<string>Belote</string>
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

### Android Configuration

Update `android/app/build.gradle`:

```gradle
android {
    compileSdkVersion 34
    
    defaultConfig {
        applicationId "com.belote.mobile"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.debug
            minifyEnabled true
            shrinkResources true
        }
    }
}
```

Update `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest>
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    
    <application
        android:label="Belote"
        android:icon="@mipmap/ic_launcher"
        android:usesCleartextTraffic="true">
        <!-- Activities -->
    </application>
</manifest>
```

---

## 📝 Step 12: Documentation

Create `README.md`:

```markdown
# Belote Mobile App

Flutter-based multiplayer Belote card game.

## Getting Started

### Prerequisites
- Flutter 3.16+
- Dart 3.2+

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run code generation:
   ```bash
   flutter pub run build_runner build
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Architecture

This project follows Clean Architecture principles with BLoC pattern for state management.

### Project Structure
```
lib/
├── core/           # Core utilities, theme, constants
├── features/       # Feature modules
├── shared/         # Shared widgets and models
└── main.dart       # Application entry point
```

## Testing

```bash
flutter test
```

## Building

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```
```

---

## ✅ Verification Steps

Run these commands to verify setup:

```bash
# 1. Check dependencies
flutter pub get

# 2. Run code generation
flutter pub run build_runner build --delete-conflicting-outputs

# 3. Analyze code
flutter analyze

# 4. Run tests
flutter test

# 5. Run app
flutter run
```

---

## ✅ Acceptance Criteria

- [ ] Flutter project created and runs successfully
- [ ] Clean Architecture folder structure created
- [ ] All dependencies installed without errors
- [ ] Theme system works (light and dark)
- [ ] Navigation works between placeholder pages
- [ ] Dependency injection configured
- [ ] Code generation works
- [ ] Tests run successfully
- [ ] App builds for both iOS and Android

---

## 🔄 Next Phase

Proceed to **Flutter Phase 1: State Management & Core Models** once all acceptance criteria are met.

---

## 🐛 Troubleshooting

### Issue: Build runner fails
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue: iOS build fails
```bash
cd ios
pod install --repo-update
cd ..
flutter clean
flutter run
```

### Issue: Android build fails
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter run
```

---

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [BLoC Pattern](https://bloclibrary.dev/)
- [Clean Architecture](https://resocoder.com/flutter-clean-architecture-tdd/)
