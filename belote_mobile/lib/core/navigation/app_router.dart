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
