# Flutter Phase 3: UI Foundation & Reusable Components

## 🎯 Objectives
- Create reusable widget library
- Build playing card widgets with graphics
- Implement responsive design utilities
- Create loading and error states
- Build dialog components
- Design app-wide UI patterns

## ⏱️ Estimated Time: 8-10 hours

## 📋 Prerequisites
- Phase 0, 1, and 2 completed
- Authentication working
- Theme system configured

---

## 🎨 Step 1: Playing Card Widget

Create `lib/shared/widgets/playing_card.dart`:

```dart
import 'package:flutter/material.dart';
import '../../features/game/domain/entities/card.dart';
import '../../core/theme/app_theme.dart';

class PlayingCard extends StatelessWidget {
  final CardEntity card;
  final bool faceUp;
  final double width;
  final double height;
  final VoidCallback? onTap;
  final bool selected;
  final bool enabled;

  const PlayingCard({
    super.key,
    required this.card,
    this.faceUp = true,
    this.width = 70,
    this.height = 100,
    this.onTap,
    this.selected = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: height,
        transform: Matrix4.identity()
          ..translate(0.0, selected ? -10.0 : 0.0),
        child: Card(
          elevation: selected ? 8 : 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[300]!,
              width: selected ? 2 : 1,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: faceUp ? Colors.white : AppTheme.primaryGreen,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: faceUp ? _buildFrontFace() : _buildBackFace(),
          ),
        ),
      ),
    );
  }

  Widget _buildFrontFace() {
    final color = _getSuitColor();
    
    return Stack(
      children: [
        // Top-left corner
        Positioned(
          top: 4,
          left: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getRankSymbol(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                _getSuitSymbol(),
                style: TextStyle(
                  fontSize: 14,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        
        // Center symbol
        Center(
          child: Text(
            _getSuitSymbol(),
            style: TextStyle(
              fontSize: 40,
              color: color,
            ),
          ),
        ),
        
        // Bottom-right corner (rotated)
        Positioned(
          bottom: 4,
          right: 4,
          child: Transform.rotate(
            angle: 3.14159, // 180 degrees
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getRankSymbol(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  _getSuitSymbol(),
                  style: TextStyle(
                    fontSize: 14,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackFace() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryGreen,
            AppTheme.primaryGreen.withOpacity(0.7),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.casino,
          size: 40,
          color: Colors.white.withOpacity(0.3),
        ),
      ),
    );
  }

  String _getRankSymbol() {
    switch (card.rank) {
      case Rank.seven:
        return '7';
      case Rank.eight:
        return '8';
      case Rank.nine:
        return '9';
      case Rank.ten:
        return '10';
      case Rank.jack:
        return 'J';
      case Rank.queen:
        return 'Q';
      case Rank.king:
        return 'K';
      case Rank.ace:
        return 'A';
    }
  }

  String _getSuitSymbol() {
    switch (card.suit) {
      case Suit.clubs:
        return '♣';
      case Suit.diamonds:
        return '♦';
      case Suit.hearts:
        return '♥';
      case Suit.spades:
        return '♠';
    }
  }

  Color _getSuitColor() {
    switch (card.suit) {
      case Suit.clubs:
        return AppTheme.clubsColor;
      case Suit.diamonds:
        return AppTheme.diamondsColor;
      case Suit.hearts:
        return AppTheme.heartsColor;
      case Suit.spades:
        return AppTheme.spadesColor;
    }
  }
}
```

---

## 📐 Step 2: Responsive Utilities

Create `lib/core/utils/responsive_utils.dart`:

```dart
import 'package:flutter/material.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static double getCardWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return 50;
    if (width < 600) return 60;
    if (width < 800) return 70;
    return 80;
  }

  static double getCardHeight(BuildContext context) {
    return getCardWidth(context) * 1.4;
  }

  static EdgeInsets getScreenPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(16);
    } else if (isTablet(context)) {
      return const EdgeInsets.all(24);
    } else {
      return const EdgeInsets.all(32);
    }
  }

  static double getFontSize(BuildContext context, {required double base}) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return base * 0.9;
    if (width < 600) return base;
    if (width < 800) return base * 1.1;
    return base * 1.2;
  }
}
```

---

## 🔘 Step 3: Custom Button

Create `lib/shared/widgets/custom_button.dart`:

```dart
import 'package:flutter/material.dart';

enum ButtonVariant {
  primary,
  secondary,
  outlined,
  text,
  danger,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool fullWidth;
  final double? width;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
    this.width,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20),
                const SizedBox(width: 8),
              ],
              Text(text),
            ],
          );

    Widget button;
    
    switch (variant) {
      case ButtonVariant.primary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(width ?? (fullWidth ? double.infinity : 0), height),
          ),
          child: child,
        );
        break;
        
      case ButtonVariant.secondary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            minimumSize: Size(width ?? (fullWidth ? double.infinity : 0), height),
          ),
          child: child,
        );
        break;
        
      case ButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: Size(width ?? (fullWidth ? double.infinity : 0), height),
          ),
          child: child,
        );
        break;
        
      case ButtonVariant.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            minimumSize: Size(width ?? (fullWidth ? double.infinity : 0), height),
          ),
          child: child,
        );
        break;
        
      case ButtonVariant.danger:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: Size(width ?? (fullWidth ? double.infinity : 0), height),
          ),
          child: child,
        );
        break;
    }

    return fullWidth
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}
```

---

## 📦 Step 4: Card Container

Create `lib/shared/widgets/card_container.dart`:

```dart
import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  const CardContainer({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.width,
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Card(
      color: color,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: width,
        height: height,
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: card,
      );
    }

    return card;
  }
}
```

---

## ⏳ Step 5: Loading Overlay

Create `lib/shared/widgets/loading_overlay.dart`:

```dart
import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black54,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  if (message != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      message!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}
```

---

## ❌ Step 6: Error View

Create `lib/shared/widgets/error_view.dart`:

```dart
import 'package:flutter/material.dart';
import 'custom_button.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData icon;

  const ErrorView({
    super.key,
    required this.message,
    this.onRetry,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              CustomButton(
                text: 'Retry',
                onPressed: onRetry,
                icon: Icons.refresh,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

---

## 📭 Step 7: Empty State

Create `lib/shared/widgets/empty_view.dart`:

```dart
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String message;
  final IconData icon;
  final String? actionText;
  final VoidCallback? onAction;

  const EmptyView({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onAction,
                child: Text(actionText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

---

## 💬 Step 8: Custom Dialog

Create `lib/shared/widgets/custom_dialog.dart`:

```dart
import 'package:flutter/material.dart';
import 'custom_button.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isDanger;

  const CustomDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.isDanger = false,
  });

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    bool isDanger = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => CustomDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        isDanger: isDanger,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      actions: [
        if (cancelText != null)
          CustomButton(
            text: cancelText!,
            onPressed: onCancel ?? () => Navigator.of(context).pop(),
            variant: ButtonVariant.text,
          ),
        if (confirmText != null)
          CustomButton(
            text: confirmText!,
            onPressed: onConfirm ?? () => Navigator.of(context).pop(),
            variant: isDanger ? ButtonVariant.danger : ButtonVariant.primary,
          ),
      ],
    );
  }
}
```

---

## 🎯 Step 9: Player Avatar

Create `lib/shared/widgets/player_avatar.dart`:

```dart
import 'package:flutter/material.dart';

class PlayerAvatar extends StatelessWidget {
  final String username;
  final double size;
  final bool isActive;
  final VoidCallback? onTap;

  const PlayerAvatar({
    super.key,
    required this.username,
    this.size = 50,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
              border: isActive
                  ? Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 3,
                    )
                  : null,
            ),
            child: Center(
              child: Text(
                username.isNotEmpty ? username[0].toUpperCase() : '?',
                style: TextStyle(
                  fontSize: size * 0.4,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (isActive)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: size * 0.3,
                height: size * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
```

---

## 🎴 Step 10: Card Hand Widget

Create `lib/shared/widgets/card_hand.dart`:

```dart
import 'package:flutter/material.dart';
import '../../features/game/domain/entities/card.dart';
import 'playing_card.dart';
import '../../core/utils/responsive_utils.dart';

class CardHand extends StatelessWidget {
  final List<CardEntity> cards;
  final CardEntity? selectedCard;
  final Function(CardEntity)? onCardTap;
  final bool enabled;

  const CardHand({
    super.key,
    required this.cards,
    this.selectedCard,
    this.onCardTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return const SizedBox.shrink();
    }

    final cardWidth = ResponsiveUtils.getCardWidth(context);
    final cardHeight = ResponsiveUtils.getCardHeight(context);
    final overlap = cardWidth * 0.7;

    return SizedBox(
      height: cardHeight + 20, // Extra space for selection elevation
      child: Stack(
        children: List.generate(cards.length, (index) {
          final card = cards[index];
          final isSelected = selectedCard != null && 
                           selectedCard!.suit == card.suit &&
                           selectedCard!.rank == card.rank;

          return Positioned(
            left: index * overlap,
            child: PlayingCard(
              card: card,
              width: cardWidth,
              height: cardHeight,
              selected: isSelected,
              enabled: enabled,
              onTap: () => onCardTap?.call(card),
            ),
          );
        }),
      ),
    );
  }
}
```

---

## 🧪 Step 11: Widget Tests

Create `test/shared/widgets/playing_card_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:belote_mobile/shared/widgets/playing_card.dart';
import 'package:belote_mobile/features/game/domain/entities/card.dart';

void main() {
  testWidgets('PlayingCard displays correctly face up', (tester) async {
    const card = CardEntity(suit: Suit.hearts, rank: Rank.ace);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PlayingCard(card: card, faceUp: true),
        ),
      ),
    );

    expect(find.text('A'), findsWidgets);
    expect(find.text('♥'), findsWidgets);
  });

  testWidgets('PlayingCard shows back when face down', (tester) async {
    const card = CardEntity(suit: Suit.clubs, rank: Rank.king);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PlayingCard(card: card, faceUp: false),
        ),
      ),
    );

    expect(find.byIcon(Icons.casino), findsOneWidget);
    expect(find.text('K'), findsNothing);
  });

  testWidgets('PlayingCard calls onTap when tapped', (tester) async {
    const card = CardEntity(suit: Suit.diamonds, rank: Rank.queen);
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlayingCard(
            card: card,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(PlayingCard));
    await tester.pump();

    expect(tapped, true);
  });
}
```

---

## ✅ Acceptance Criteria

- [ ] Playing card widget displays correctly
- [ ] Cards show correct suit colors
- [ ] Card back design looks professional
- [ ] Selected cards elevate visually
- [ ] Card hand widget displays cards with overlap
- [ ] Responsive utilities work on all screen sizes
- [ ] Loading overlay blocks interaction
- [ ] Error view shows retry button
- [ ] Empty view displays proper message
- [ ] Dialogs are reusable and customizable
- [ ] All widgets are responsive
- [ ] Widget tests pass
- [ ] No performance issues (60fps)

---

## 🔄 Next Phase

Proceed to **Flutter Phase 4: Game Board UI & Animations** to build the complete game table layout.

---

## 📚 Resources

- [Flutter Custom Widgets](https://docs.flutter.dev/development/ui/widgets)
- [Material Design](https://m3.material.io/)
- [Responsive Design](https://docs.flutter.dev/development/ui/layout/responsive)
