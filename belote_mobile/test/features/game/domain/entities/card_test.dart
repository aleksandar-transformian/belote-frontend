import 'package:flutter_test/flutter_test.dart';
import 'package:belote_mobile/features/game/domain/entities/card.dart';

void main() {
  group('CardEntity', () {
    test('should calculate trump value correctly for jack', () {
      final card = const CardEntity(suit: Suit.clubs, rank: Rank.jack);
      expect(card.getTrumpValue(), 20);
    });

    test('should calculate trump value correctly for nine', () {
      final card = const CardEntity(suit: Suit.hearts, rank: Rank.nine);
      expect(card.getTrumpValue(), 14);
    });

    test('should calculate non-trump value correctly for ace', () {
      final card = const CardEntity(suit: Suit.spades, rank: Rank.ace);
      expect(card.getNonTrumpValue(), 11);
    });

    test('should calculate non-trump value correctly for ten', () {
      final card = const CardEntity(suit: Suit.diamonds, rank: Rank.ten);
      expect(card.getNonTrumpValue(), 10);
    });

    test('should return correct value based on trump status', () {
      final card = const CardEntity(suit: Suit.clubs, rank: Rank.jack);
      expect(card.getValue(true), 20); // Trump
      expect(card.getValue(false), 2); // Non-trump
    });

    test('should generate correct display name', () {
      final card = const CardEntity(suit: Suit.hearts, rank: Rank.ace);
      expect(card.displayName, 'A♥');
    });

    test('should generate correct display name for clubs', () {
      final card = const CardEntity(suit: Suit.clubs, rank: Rank.king);
      expect(card.displayName, 'K♣');
    });

    test('should generate correct display name for diamonds', () {
      final card = const CardEntity(suit: Suit.diamonds, rank: Rank.queen);
      expect(card.displayName, 'Q♦');
    });
  });
}
