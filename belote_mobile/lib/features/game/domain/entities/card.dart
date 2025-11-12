import 'package:freezed_annotation/freezed_annotation.dart';

part 'card.freezed.dart';
part 'card.g.dart';

enum Suit {
  @JsonValue('CLUBS')
  clubs,
  @JsonValue('DIAMONDS')
  diamonds,
  @JsonValue('HEARTS')
  hearts,
  @JsonValue('SPADES')
  spades,
}

enum Rank {
  @JsonValue('7')
  seven,
  @JsonValue('8')
  eight,
  @JsonValue('9')
  nine,
  @JsonValue('10')
  ten,
  @JsonValue('J')
  jack,
  @JsonValue('Q')
  queen,
  @JsonValue('K')
  king,
  @JsonValue('A')
  ace,
}

@freezed
class CardEntity with _$CardEntity {
  const factory CardEntity({
    required Suit suit,
    required Rank rank,
  }) = _CardEntity;

  factory CardEntity.fromJson(Map<String, dynamic> json) =>
      _$CardEntityFromJson(json);
}

extension CardEntityX on CardEntity {
  String get displayName => '${_rankName(rank)}${_suitSymbol(suit)}';

  int getTrumpValue() {
    switch (rank) {
      case Rank.jack:
        return 20;
      case Rank.nine:
        return 14;
      case Rank.ace:
        return 11;
      case Rank.ten:
        return 10;
      case Rank.king:
        return 4;
      case Rank.queen:
        return 3;
      default:
        return 0;
    }
  }

  int getNonTrumpValue() {
    switch (rank) {
      case Rank.ace:
        return 11;
      case Rank.ten:
        return 10;
      case Rank.king:
        return 4;
      case Rank.queen:
        return 3;
      case Rank.jack:
        return 2;
      default:
        return 0;
    }
  }

  int getValue(bool isTrump) => isTrump ? getTrumpValue() : getNonTrumpValue();

  String _suitSymbol(Suit suit) {
    switch (suit) {
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

  String _rankName(Rank rank) {
    switch (rank) {
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
}
