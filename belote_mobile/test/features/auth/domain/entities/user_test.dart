import 'package:flutter_test/flutter_test.dart';
import 'package:belote_mobile/features/auth/domain/entities/user.dart';

void main() {
  group('UserEntity', () {
    test('should calculate win rate correctly', () {
      final user = UserEntity(
        id: '1',
        username: 'testuser',
        email: 'test@example.com',
        eloRating: 1000,
        totalGames: 10,
        wins: 7,
        losses: 3,
        createdAt: DateTime.now(),
      );

      expect(user.winRate, 0.7);
      expect(user.winRatePercentage, '70.0%');
    });

    test('should handle zero games', () {
      final user = UserEntity(
        id: '1',
        username: 'newuser',
        email: 'new@example.com',
        eloRating: 1000,
        totalGames: 0,
        wins: 0,
        losses: 0,
        createdAt: DateTime.now(),
      );

      expect(user.winRate, 0.0);
    });
  });
}
