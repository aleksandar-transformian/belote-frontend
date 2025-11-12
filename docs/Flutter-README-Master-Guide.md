# Belote Mobile App - Complete Implementation Guide

## 📖 Overview

This is the master guide for implementing a production-ready Flutter mobile app for the Belote multiplayer card game. The app connects to the backend via REST APIs and WebSockets for real-time gameplay.

---

## 🎯 Project Goals

Build a beautiful, performant mobile app that supports:
- User authentication and profiles
- Real-time multiplayer gameplay
- Smooth card animations
- Intuitive game UI/UX
- Offline mode with AI
- Push notifications
- Both iOS and Android platforms

---

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│                  Clean Architecture                      │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │     Data     │  │   Domain     │  │Presentation  │  │
│  │    Layer     │→ │    Layer     │→ │    Layer     │  │
│  │              │  │              │  │              │  │
│  │ API Client   │  │  Entities    │  │   Screens    │  │
│  │ WebSocket    │  │  Use Cases   │  │   Widgets    │  │
│  │ Local DB     │  │ Repositories │  │  State Mgmt  │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

**State Management**: BLoC Pattern (flutter_bloc)  
**Dependency Injection**: get_it + injectable  
**Navigation**: go_router  
**API Client**: dio  
**WebSocket**: socket_io_client  
**Local Storage**: hive  
**Animations**: flutter_animate  

---

## 📚 Technology Stack

### Core
- **Framework**: Flutter 3.16+
- **Language**: Dart 3.2+
- **Platforms**: iOS 12+, Android 5.0+ (API 21)

### State Management
- **Pattern**: BLoC (Business Logic Component)
- **Package**: flutter_bloc 8.x
- **Reason**: Predictable, testable, separates business logic

### Networking
- **REST API**: dio 5.x
- **WebSocket**: socket_io_client 2.x
- **JSON Serialization**: json_serializable

### Local Storage
- **Primary**: hive 2.x (NoSQL, fast)
- **Secure**: flutter_secure_storage (tokens)
- **Shared Prefs**: shared_preferences (settings)

### UI/UX
- **Animations**: flutter_animate, AnimatedBuilder
- **Icons**: flutter_svg
- **Loading**: shimmer
- **Toasts**: fluttertoast
- **Dialogs**: adaptive_dialog

### Development
- **Linting**: flutter_lints
- **Code Generation**: build_runner
- **Testing**: flutter_test, mockito, bloc_test
- **Analytics**: firebase_analytics (optional)

---

## 📋 Implementation Phases

### **Phase 0: Flutter Project Setup & Architecture** ⏱️ 4-6 hours
**File**: `Flutter-Phase-0-Setup.md`

**Objectives**:
- Initialize Flutter project with proper structure
- Set up Clean Architecture folders
- Configure dependencies and code generation
- Implement dependency injection
- Set up theming and constants

**Key Deliverables**:
- ✅ Flutter project with Clean Architecture
- ✅ Dependency injection configured
- ✅ Theme system (light/dark mode)
- ✅ Environment configuration
- ✅ Navigation setup

**Acceptance Criteria**:
- [ ] App runs on both iOS and Android
- [ ] Dependency injection works
- [ ] Theme switching works
- [ ] Navigation between screens works

---

### **Phase 1: State Management & Core Models** ⏱️ 6-8 hours
**File**: `Flutter-Phase-1-Models-State.md`

**Objectives**:
- Define all domain models (User, Game, Card, etc.)
- Create JSON serialization
- Implement BLoC pattern structure
- Set up repository interfaces
- Create base API client

**Key Deliverables**:
- ✅ Domain models with freezed
- ✅ API models with json_serializable
- ✅ Repository interfaces
- ✅ Base BLoC structure
- ✅ API client with dio
- ✅ Error handling

**Acceptance Criteria**:
- [ ] All models serialize correctly
- [ ] API client can make requests
- [ ] BLoCs follow consistent pattern
- [ ] Error handling covers all cases

---

### **Phase 2: Authentication & User Management** ⏱️ 6-8 hours
**File**: `Flutter-Phase-2-Authentication.md`

**Objectives**:
- Implement authentication flow
- Create login/register screens
- Build auth BLoC with token management
- Implement secure token storage
- Create user profile screen

**Key Deliverables**:
- ✅ Login screen with validation
- ✅ Registration screen
- ✅ Auth BLoC with state management
- ✅ Token storage and refresh
- ✅ Profile screen
- ✅ Logout functionality

**Screens**:
- Splash screen
- Login screen
- Registration screen
- Profile screen

**Acceptance Criteria**:
- [ ] Users can register and login
- [ ] Tokens persist across app restarts
- [ ] Token refresh works automatically
- [ ] Validation shows proper errors
- [ ] Profile data loads correctly

---

### **Phase 3: UI/UX Foundation** ⏱️ 8-10 hours
**File**: `Flutter-Phase-3-UI-Foundation.md`

**Objectives**:
- Create reusable widget library
- Build common UI components
- Implement responsive design
- Create custom card widgets
- Build navigation structure

**Key Deliverables**:
- ✅ Custom buttons, inputs, cards
- ✅ Loading indicators
- ✅ Error widgets
- ✅ Dialog components
- ✅ Bottom navigation
- ✅ Responsive utilities
- ✅ Card graphics and animations

**Components**:
- CustomButton
- CustomTextField
- LoadingOverlay
- ErrorView
- PlayingCard widget
- CardDeck widget

**Acceptance Criteria**:
- [ ] Components are reusable
- [ ] Responsive on all screen sizes
- [ ] Animations are smooth (60fps)
- [ ] Cards render beautifully
- [ ] Theme is consistent

---

### **Phase 4: Game Board UI & Animations** ⏱️ 10-12 hours
**File**: `Flutter-Phase-4-Game-Board.md`

**Objectives**:
- Build game table layout
- Implement card dealing animations
- Create trick-taking animations
- Build bidding UI
- Implement declaration UI
- Create score display

**Key Deliverables**:
- ✅ Game table widget
- ✅ Player position layout (4 players)
- ✅ Card hand widget with drag/tap
- ✅ Trick animation system
- ✅ Bidding panel
- ✅ Declaration overlay
- ✅ Score board
- ✅ Turn indicator

**Screens**:
- Game lobby
- Game table
- Game history

**Acceptance Criteria**:
- [ ] Cards animate smoothly
- [ ] Layout works on all screen sizes
- [ ] Drag and drop feels natural
- [ ] Animations don't lag
- [ ] UI is intuitive

---

### **Phase 5: Real-time Communication** ⏱️ 8-10 hours
**File**: `Flutter-Phase-5-WebSockets.md`

**Objectives**:
- Implement Socket.io client
- Create WebSocket service
- Build game state synchronization
- Handle connection/reconnection
- Implement event handling

**Key Deliverables**:
- ✅ WebSocket service with reconnection
- ✅ Game events handler
- ✅ State synchronization
- ✅ Connection status indicator
- ✅ Offline detection
- ✅ Event queue for offline mode

**Events Handled**:
- Authentication
- Game joining
- Card plays
- Bidding
- Declarations
- Player disconnections

**Acceptance Criteria**:
- [ ] Socket connects on app start
- [ ] Events sync in real-time
- [ ] Reconnection works automatically
- [ ] Offline mode queues actions
- [ ] No memory leaks from connections

---

### **Phase 6: Game Flow Implementation** ⏱️ 10-12 hours
**File**: `Flutter-Phase-6-Game-Flow.md`

**Objectives**:
- Implement complete game flow
- Build matchmaking screen
- Create game BLoC with full logic
- Implement AI opponent (offline)
- Add sound effects and haptics
- Create game history

**Key Deliverables**:
- ✅ Matchmaking screen with queue
- ✅ Game BLoC with all states
- ✅ Bidding flow
- ✅ Card playing flow
- ✅ Declaration flow
- ✅ Scoring and round completion
- ✅ Local AI opponent
- ✅ Sound effects
- ✅ Haptic feedback

**Screens**:
- Home screen
- Matchmaking screen
- Active game screen
- Game results screen
- Statistics screen

**Acceptance Criteria**:
- [ ] Can find and join games
- [ ] Full game flow works
- [ ] AI opponent makes valid moves
- [ ] Sounds enhance experience
- [ ] Game history persists

---

### **Phase 7: Testing & Deployment** ⏱️ 8-10 hours
**File**: `Flutter-Phase-7-Testing-Deployment.md`

**Objectives**:
- Write comprehensive tests
- Build for production
- Configure iOS and Android
- Set up CI/CD
- Prepare for app stores

**Key Deliverables**:
- ✅ Unit tests for models and BLoCs
- ✅ Widget tests for components
- ✅ Integration tests for flows
- ✅ iOS build configuration
- ✅ Android build configuration
- ✅ App icons and splash screens
- ✅ Store listings

**Acceptance Criteria**:
- [ ] 70%+ code coverage
- [ ] All tests pass
- [ ] iOS build succeeds
- [ ] Android build succeeds
- [ ] Performance is optimal
- [ ] No memory leaks

---

## 📊 Development Timeline

| Phase | Duration | Can Start After | Parallel With |
|-------|----------|-----------------|---------------|
| Phase 0 | 4-6 hours | - | - |
| Phase 1 | 6-8 hours | Phase 0 | - |
| Phase 2 | 6-8 hours | Phase 1 | - |
| Phase 3 | 8-10 hours | Phase 0 | Phase 1-2 (partial) |
| Phase 4 | 10-12 hours | Phase 3 | - |
| Phase 5 | 8-10 hours | Phase 1 | Phase 3-4 (partial) |
| Phase 6 | 10-12 hours | Phase 2, 4, 5 | - |
| Phase 7 | 8-10 hours | All phases | Throughout |
| **Total** | **60-76 hours** | | |

**Realistic Timeline**:
- **Full-time**: 1.5-2 weeks
- **Part-time (20h/week)**: 3-4 weeks
- **Casual (10h/week)**: 6-8 weeks

---

## 🎨 Design System

### Color Palette
```dart
// Primary: Belote traditional colors
primaryGreen: #1B5E20
primaryRed: #C62828
accentGold: #FFB300

// Card Suits
clubsColor: #000000
diamondsColor: #E53935
heartsColor: #E53935
spadesColor: #000000

// UI
background: #FAFAFA (light) / #121212 (dark)
surface: #FFFFFF (light) / #1E1E1E (dark)
```

### Typography
```dart
// Headers
headline1: 32px, Bold
headline2: 24px, SemiBold
headline3: 20px, Medium

// Body
body1: 16px, Regular
body2: 14px, Regular

// Caption
caption: 12px, Regular
```

### Components
- Cards: 3D effect with shadows
- Buttons: Rounded, material design
- Inputs: Outlined with labels
- Dialogs: Bottom sheet on mobile

---

## 🧪 Testing Strategy

### Unit Tests
```bash
flutter test test/unit
```
- Domain models
- BLoC logic
- Repositories
- Services
- Utilities

### Widget Tests
```bash
flutter test test/widget
```
- Individual widgets
- Screens
- Custom components
- Animations

### Integration Tests
```bash
flutter test integration_test
```
- Complete flows
- API integration
- WebSocket connection
- Game scenarios

**Coverage Target**: 70%+

---

## 📱 Platform-Specific Considerations

### iOS
- Swift 5.0+
- CocoaPods for dependencies
- Push notifications via APNs
- App Store review guidelines
- In-app purchases (future)

### Android
- Kotlin 1.9+
- Gradle build system
- Push notifications via FCM
- ProGuard/R8 for minification
- Google Play requirements

---

## 🔄 Development Workflow

### 1. Setup Development Environment
```bash
# Check Flutter installation
flutter doctor

# Create project
flutter create belote_mobile
cd belote_mobile

# Get dependencies
flutter pub get

# Run on emulator/device
flutter run
```

### 2. Development Pattern
```bash
# Create feature branch
git checkout -b feature/game-board

# Make changes, hot reload automatically works

# Run tests
flutter test

# Format code
dart format lib/

# Analyze code
flutter analyze
```

### 3. Build for Testing
```bash
# iOS
flutter build ios --debug

# Android
flutter build apk --debug
```

### 4. Deploy
```bash
# Production iOS
flutter build ipa --release

# Production Android
flutter build appbundle --release
```

---

## 🎯 Key Features

### MVP Features
✅ User registration and login  
✅ Real-time multiplayer (4 players)  
✅ Complete Belote rules  
✅ Matchmaking  
✅ Player statistics  
✅ Game history  
✅ Offline AI opponent  

### V2 Features (Future)
- Friends system
- Private rooms with invites
- In-game chat with emotes
- Tournaments
- Achievements and badges
- Daily challenges
- Spectator mode
- Replays with playback

### V3 Features (Future)
- Voice chat
- Video avatars
- Customizable themes
- Premium card decks
- In-app purchases
- Social media sharing
- Cross-platform play

---

## 📐 Screen Specifications

### Screen Sizes Support
- **Phone**: 4.7" - 6.7" (most common)
- **Tablet**: 7" - 12.9"
- **Orientation**: Portrait and Landscape

### Minimum Requirements
- **iOS**: iOS 12.0+, iPhone 6S+
- **Android**: API 21+ (Android 5.0+)
- **RAM**: 2GB minimum, 4GB recommended
- **Storage**: 100MB for app

---

## 🔐 Security Considerations

### Data Protection
- Secure token storage (Keychain/Keystore)
- No sensitive data in logs
- SSL pinning for API calls
- Input validation on all forms
- XSS prevention in WebView

### Best Practices
- ProGuard/R8 for code obfuscation
- Root/jailbreak detection
- Biometric authentication (future)
- Encrypted local storage
- Secure WebSocket connections

---

## 🚀 Performance Optimization

### Flutter Performance
- Use const constructors
- Implement lazy loading
- Optimize widget rebuilds
- Use RepaintBoundary for animations
- Profile with DevTools

### Network
- Cache API responses
- Implement pagination
- Compress images
- Retry failed requests
- Connection status handling

### Memory
- Dispose controllers
- Cancel subscriptions
- Clear image cache
- Limit simultaneous connections

---

## 📦 Project Structure

```
lib/
├── core/
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   ├── errors/
│   └── network/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── game/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── profile/
│   └── matchmaking/
├── shared/
│   ├── widgets/
│   └── models/
└── main.dart
```

---

## 🐛 Known Issues & Limitations

### Current Limitations
1. No offline mode for multiplayer
2. Basic AI opponent
3. Single language (English)
4. No replay system
5. No spectator mode

### Technical Debt
1. Some state management could be simplified
2. Card animations could be more polished
3. Network error handling could be more granular
4. Need more comprehensive integration tests

---

## 📱 App Store Preparation

### Requirements

**App Store (iOS)**
- Developer account ($99/year)
- App icons (all sizes)
- Screenshots (6.5", 5.5")
- App description and keywords
- Privacy policy URL
- Support URL

**Google Play (Android)**
- Developer account ($25 one-time)
- Feature graphic (1024x500)
- Screenshots (phone, tablet)
- App description
- Content rating
- Privacy policy

---

## ✅ Pre-Launch Checklist

### Development
- [ ] All phases completed
- [ ] Unit test coverage >70%
- [ ] Widget tests passing
- [ ] Integration tests passing
- [ ] No memory leaks
- [ ] Performance profiled

### UI/UX
- [ ] Responsive on all screen sizes
- [ ] Animations smooth (60fps)
- [ ] Loading states implemented
- [ ] Error states handled
- [ ] Empty states designed
- [ ] Accessibility labels added

### Integration
- [ ] API integration complete
- [ ] WebSocket connection stable
- [ ] Offline mode works
- [ ] Push notifications work
- [ ] Deep linking configured

### Polish
- [ ] App icons created
- [ ] Splash screens added
- [ ] Sounds and haptics
- [ ] Onboarding flow
- [ ] Tutorial for first game
- [ ] Privacy policy agreed

### Store
- [ ] iOS build succeeds
- [ ] Android build succeeds
- [ ] Screenshots prepared
- [ ] Store listings written
- [ ] Beta testing completed

---

## 🎓 Learning Resources

### Flutter
- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)

### State Management
- [BLoC Library](https://bloclibrary.dev/)
- [BLoC Pattern Guide](https://www.didierboelens.com/2018/08/reactive-programming-streams-bloc/)

### Clean Architecture
- [Flutter Clean Architecture](https://resocoder.com/flutter-clean-architecture-tdd/)
- [Clean Code Dart](https://github.com/Dart-Code/Dart-Code)

---

## 🤝 Contributing

Follow these guidelines:

### Code Style
- Use dart format for formatting
- Follow effective Dart guidelines
- Write meaningful commit messages
- Add comments for complex logic

### Testing
- Write unit tests for BLoCs
- Add widget tests for components
- Create integration tests for flows

### Pull Requests
1. Create feature branch
2. Implement with tests
3. Ensure tests pass
4. Update documentation
5. Submit PR

---

## 🎉 Getting Started

Ready to build? Start with:

1. **Read** this master guide
2. **Complete** Phase 0 - Setup
3. **Work through** Phase 1-6 sequentially
4. **Test** thoroughly in Phase 7
5. **Deploy** to app stores!

Each phase includes:
- ✅ Clear objectives
- ✅ Complete code examples
- ✅ Step-by-step instructions
- ✅ Testing guidelines
- ✅ Acceptance criteria

**Total time**: 60-76 hours of focused development

Good luck building your Belote mobile app! 🎴📱

---

## 📝 License

This project uses MIT License. See LICENSE file for details.
