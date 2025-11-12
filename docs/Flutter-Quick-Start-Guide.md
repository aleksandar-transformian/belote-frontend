# Flutter Quick Start Guide - Belote Mobile App

## 🚀 TL;DR

Build a production-ready Flutter mobile app for multiplayer Belote in **~65 hours** with complete UI/UX, real-time WebSockets, and deployment to App Store and Google Play.

---

## 📋 What You'll Build

A complete mobile app with:
- ✅ Beautiful, responsive UI (light/dark themes)
- ✅ User authentication (login/register)
- ✅ Real-time multiplayer gameplay
- ✅ Smooth card animations
- ✅ Matchmaking system
- ✅ Offline AI opponent
- ✅ Player statistics and history
- ✅ iOS & Android support

---

## 📚 Documentation Files

| File | Purpose | Time |
|------|---------|------|
| `Flutter-README-Master-Guide.md` | Complete overview | READ FIRST |
| `Flutter-Phase-0-Setup.md` | Project setup | 4-6h |
| `Flutter-Phase-1-Models-State.md` | Models & BLoC | 6-8h |
| **Phase 2-7** (See Master Guide) | Full implementation | 50-60h |

**Total**: 60-76 hours

---

## 🎯 Execution Plan for Claude Code

### Week 1: Foundation (Days 1-4)

**Day 1: Project Setup**
```bash
# Give Claude Code these instructions:
"Set up a Flutter project following Flutter-Phase-0-Setup.md:
1. Create Flutter project with Clean Architecture structure
2. Add all dependencies to pubspec.yaml
3. Configure dependency injection with get_it
4. Set up theme system (light/dark mode)
5. Configure navigation with go_router
6. Set up error handling
7. Create placeholder pages
8. Verify the app runs on iOS and Android"
```

**Day 2-3: Models & State Management**
```bash
# Give Claude Code these instructions:
"Implement state management following Flutter-Phase-1-Models-State.md:
1. Create all domain models (User, Game, Card) with freezed
2. Implement JSON serialization
3. Build API client with dio
4. Create repository interfaces
5. Set up BLoC pattern structure
6. Implement AuthBloc with events and states
7. Write unit tests for models and BLoCs
8. Run code generation and verify everything compiles"
```

**Day 4: Authentication UI**
```bash
# Give Claude Code these instructions:
"Implement authentication screens:
1. Create Login page with form validation
2. Create Registration page with password strength
3. Build Splash screen with auth check
4. Implement Profile page
5. Connect screens to AuthBloc
6. Add loading states and error handling
7. Test the complete auth flow end-to-end"
```

### Week 2: UI & Game Board (Days 5-10)

**Day 5-6: UI Foundation**
```bash
"Create reusable UI components:
1. Build CustomButton with variants
2. Create CustomTextField with validation
3. Implement LoadingOverlay
4. Build ErrorView and EmptyView widgets
5. Create BottomNavigation
6. Implement responsive utilities
7. Build card graphics (PlayingCard widget)
8. Test components on different screen sizes"
```

**Day 7-9: Game Board UI**
```bash
"Build the game board interface:
1. Create GameTable layout (4 player positions)
2. Implement PlayerHand widget with drag/tap
3. Build card dealing animations
4. Create BiddingPanel with all bid types
5. Implement DeclarationOverlay
6. Build ScoreBoard display
7. Add TurnIndicator
8. Create TrickAnimation
9. Test animations run at 60fps"
```

**Day 10: Polish UI**
```bash
"Add final UI touches:
1. Implement sound effects for card plays
2. Add haptic feedback
3. Create transition animations
4. Build dialogs (game over, disconnection)
5. Add tooltips for first-time users
6. Test on multiple device sizes"
```

### Week 3: Real-time & Deployment (Days 11-15)

**Day 11-12: WebSocket Integration**
```bash
"Implement real-time communication:
1. Create WebSocketService with socket_io_client
2. Build connection/reconnection logic
3. Implement all game event handlers
4. Create GameBloc for state synchronization
5. Add connection status indicator
6. Handle offline mode with event queue
7. Test multiplayer with multiple devices"
```

**Day 13: Game Flow**
```bash
"Complete game implementation:
1. Build Matchmaking screen
2. Implement complete game flow in GameBloc
3. Add AI opponent for offline mode
4. Create GameHistory screen
5. Build Statistics screen
6. Test full game scenarios"
```

**Day 14-15: Testing & Deployment**
```bash
"Prepare for release:
1. Write comprehensive tests (unit, widget, integration)
2. Configure iOS build (Info.plist, signing)
3. Configure Android build (gradle, permissions)
4. Create app icons and splash screens
5. Build release APK and IPA
6. Test on physical devices
7. Prepare store listings"
```

---

## 🛠️ Development Commands

### Initial Setup
```bash
# 1. Check Flutter installation
flutter doctor

# 2. Create project
flutter create --org com.belote belote_mobile
cd belote_mobile

# 3. Add dependencies (update pubspec.yaml)
flutter pub get

# 4. Run code generation
flutter pub run build_runner build --delete-conflicting-outputs

# 5. Run app
flutter run
```

### Development Workflow
```bash
# Run with hot reload
flutter run

# Run tests
flutter test

# Check for issues
flutter analyze

# Format code
dart format lib/

# Generate code
flutter pub run build_runner watch
```

### Building
```bash
# Android debug
flutter build apk --debug

# Android release
flutter build appbundle --release

# iOS debug
flutter build ios --debug

# iOS release
flutter build ipa --release
```

---

## 📝 Claude Code Prompts

### Phase 0: Setup
```
I need to set up a Flutter project for a multiplayer Belote card game. 
Follow Flutter-Phase-0-Setup.md exactly:

1. Create Flutter project with Clean Architecture structure
2. Add all dependencies from the provided pubspec.yaml
3. Set up dependency injection with get_it + injectable
4. Configure theme system (light and dark themes)
5. Set up navigation with go_router
6. Create error handling classes
7. Build placeholder pages for all routes
8. Verify the app runs on both iOS and Android simulators

After setup, run 'flutter run' and confirm it starts without errors.
```

### Phase 1: Models & State
```
Implement models and state management following Flutter-Phase-1-Models-State.md:

1. Create all domain entities with freezed:
   - CardEntity (with Suit and Rank enums)
   - UserEntity with winRate calculation
   - GameEntity with all game states
   - Bid, Declaration, Trick models

2. Implement JSON serialization for all models

3. Build ApiClient with dio:
   - Token management with interceptors
   - Automatic token refresh on 401
   - Error handling for all HTTP errors

4. Create repository interfaces (don't implement yet)

5. Set up BLoC structure:
   - AuthBloc with all events and states
   - Base BLoC classes for reuse

6. Write unit tests for:
   - User winRate calculation
   - Card value methods
   - AuthBloc state transitions

Run 'flutter pub run build_runner build' and verify all code generates correctly.
```

### Phases 2-7 (Summary)
Use similar detailed prompts referencing each phase document. Claude Code will implement:
- Authentication screens with validation
- Reusable UI components library
- Game board with animations
- WebSocket real-time communication
- Complete game flow
- Testing and deployment configuration

---

## ✅ Verification Checklist

### After Phase 0
- [ ] `flutter run` starts app successfully
- [ ] Can navigate between placeholder pages
- [ ] Theme switching works (light/dark)
- [ ] Dependencies installed without errors

### After Phase 1
- [ ] All models serialize to/from JSON
- [ ] Code generation succeeds
- [ ] Unit tests pass
- [ ] API client can make requests

### After Phase 2 (Auth)
- [ ] Can register new user
- [ ] Can login with credentials
- [ ] Token persists across app restarts
- [ ] Can view profile

### After Phase 3-4 (UI)
- [ ] Components render correctly
- [ ] Cards display with proper graphics
- [ ] Animations run smoothly
- [ ] Responsive on all screen sizes

### After Phase 5-6 (Multiplayer)
- [ ] WebSocket connects successfully
- [ ] Can join/create games
- [ ] Real-time updates work
- [ ] AI opponent makes valid moves

### After Phase 7 (Deploy)
- [ ] Tests pass with >70% coverage
- [ ] iOS build succeeds
- [ ] Android build succeeds
- [ ] App performs well on devices

---

## 🎨 Design Specifications

### Screen Sizes
- **Phone**: 375x667 (iPhone SE) to 428x926 (iPhone 13 Pro Max)
- **Tablet**: 768x1024 (iPad) to 1024x1366 (iPad Pro)

### Performance
- **60 FPS** animations
- **< 100ms** tap response
- **< 2s** initial load time
- **< 500ms** screen transitions

### Colors
```dart
Primary Green: #1B5E20
Primary Red: #C62828
Accent Gold: #FFB300

Clubs: #000000
Diamonds: #E53935
Hearts: #E53935
Spades: #000000
```

---

## 📊 Progress Tracking

```markdown
## Flutter Development Progress

### Week 1: Foundation
- [ ] Phase 0: Project Setup (4-6h)
- [ ] Phase 1: Models & State (6-8h)
- [ ] Phase 2: Authentication (6-8h)

### Week 2: UI Implementation
- [ ] Phase 3: UI Foundation (8-10h)
- [ ] Phase 4: Game Board (10-12h)

### Week 3: Multiplayer & Release
- [ ] Phase 5: WebSockets (8-10h)
- [ ] Phase 6: Game Flow (10-12h)
- [ ] Phase 7: Testing & Deploy (8-10h)

### Launch Checklist
- [ ] All features implemented
- [ ] Tests passing (70%+ coverage)
- [ ] iOS build successful
- [ ] Android build successful
- [ ] Performance optimized
- [ ] Store assets prepared
```

---

## 🐛 Common Issues

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
flutter build ios
```

### Android Build Issues
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter build apk
```

### Hot Reload Not Working
```bash
# Stop app
flutter run --no-hot
```

---

## 💡 Best Practices

### For Claude Code
- Upload one phase document at a time
- Ask for tests with every feature
- Request code comments for complex UI
- Verify animations before moving forward

### For Development
- Test on both iOS and Android regularly
- Use `flutter analyze` before commits
- Run tests after each feature
- Profile performance with DevTools
- Test on physical devices frequently

### For State Management
- Keep BLoCs focused and small
- Use separate BLoCs per feature
- Test state transitions thoroughly
- Handle loading and error states

---

## 🚀 Deployment Checklist

### Pre-Release
- [ ] All features working
- [ ] No console warnings
- [ ] Tested on multiple devices
- [ ] Performance optimized
- [ ] Memory leaks checked

### iOS App Store
- [ ] Apple Developer account ($99/year)
- [ ] App icons (all sizes)
- [ ] Screenshots (required sizes)
- [ ] Privacy policy URL
- [ ] App description
- [ ] TestFlight beta testing

### Google Play Store
- [ ] Google Play Console account ($25)
- [ ] Feature graphic
- [ ] Screenshots
- [ ] Content rating
- [ ] Privacy policy
- [ ] Closed testing

---

## 📈 Performance Targets

- **App Size**: < 50MB
- **Memory**: < 150MB typical usage
- **Battery**: < 5% per hour of gameplay
- **Network**: < 100KB per game
- **Startup Time**: < 2 seconds

---

## 🎓 Learning Path

If you're new to Flutter:
1. Complete [Flutter Codelabs](https://docs.flutter.dev/codelabs)
2. Read [Flutter Widget Catalog](https://docs.flutter.dev/development/ui/widgets)
3. Learn [BLoC Pattern](https://bloclibrary.dev/)
4. Study [Clean Architecture](https://resocoder.com/flutter-clean-architecture-tdd/)

Then start with Phase 0!

---

## 🆘 Getting Help

**Stuck on Setup?**
- Check Flutter Doctor: `flutter doctor -v`
- Verify dependencies: `flutter pub get`
- Clear cache: `flutter clean`

**Stuck on Code Generation?**
- Check build.yaml configuration
- Verify freezed/json_serializable versions
- Run with `--delete-conflicting-outputs`

**Stuck on UI?**
- Use Flutter DevTools for debugging
- Check widget tree with inspector
- Profile animations with performance overlay

---

**Ready to Build? 🎴**

1. Read `Flutter-README-Master-Guide.md` for complete context
2. Start with `Flutter-Phase-0-Setup.md`
3. Work through phases 1-7 sequentially
4. Deploy to app stores!

Total time: **60-76 hours** of focused development.

Good luck! 📱✨
