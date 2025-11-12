import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/profile_page.dart';

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

// Home Page - Main menu after login
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belote'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push('/profile'),
            tooltip: 'Profile',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.playing_cards,
                size: 120,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 32),
              Text(
                'Belote',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 48),
              _MenuButton(
                icon: Icons.play_arrow,
                label: 'Quick Play',
                onTap: () => context.push('/matchmaking'),
              ),
              const SizedBox(height: 16),
              _MenuButton(
                icon: Icons.people,
                label: 'Play with Friends',
                onTap: () {
                  // To be implemented in Phase 6
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Coming soon!')),
                  );
                },
              ),
              const SizedBox(height: 16),
              _MenuButton(
                icon: Icons.history,
                label: 'Game History',
                onTap: () {
                  // To be implemented in Phase 6
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Coming soon!')),
                  );
                },
              ),
              const SizedBox(height: 16),
              _MenuButton(
                icon: Icons.settings,
                label: 'Settings',
                onTap: () {
                  // To be implemented in Phase 7
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Coming soon!')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder pages (will be implemented in later phases)
class GamePage extends StatelessWidget {
  final String gameId;
  const GamePage({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Game')),
        body: Center(child: Text('Game: $gameId\n\nTo be implemented in Phase 4-6')),
      );
}

class MatchmakingPage extends StatelessWidget {
  const MatchmakingPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Matchmaking')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 24),
              Text(
                'Finding match...',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'To be implemented in Phase 5-6',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found')),
      );
}
