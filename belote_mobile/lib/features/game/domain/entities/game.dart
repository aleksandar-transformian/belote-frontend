import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';
part 'game.g.dart';

enum GameStatus {
  @JsonValue('WAITING')
  waiting,
  @JsonValue('ACTIVE')
  active,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('CANCELLED')
  cancelled,
}

enum GamePhase {
  @JsonValue('DEALING')
  dealing,
  @JsonValue('BIDDING')
  bidding,
  @JsonValue('DECLARING')
  declaring,
  @JsonValue('PLAYING')
  playing,
  @JsonValue('SCORING')
  scoring,
  @JsonValue('FINISHED')
  finished,
}

enum ContractType {
  @JsonValue('CLUBS')
  clubs,
  @JsonValue('DIAMONDS')
  diamonds,
  @JsonValue('HEARTS')
  hearts,
  @JsonValue('SPADES')
  spades,
  @JsonValue('NO_TRUMPS')
  noTrumps,
  @JsonValue('ALL_TRUMPS')
  allTrumps,
}

enum BidType {
  @JsonValue('PASS')
  pass,
  @JsonValue('CONTRACT')
  contract,
  @JsonValue('DOUBLE')
  double,
  @JsonValue('REDOUBLE')
  redouble,
}

@freezed
class GameEntity with _$GameEntity {
  const factory GameEntity({
    required String id,
    required List<String> team1PlayerIds,
    required List<String> team2PlayerIds,
    required GameStatus status,
    required GamePhase phase,
    required int currentDealerIndex,
    required int currentPlayerIndex,
    required int team1MatchPoints,
    required int team2MatchPoints,
    required DateTime createdAt,
    DateTime? finishedAt,
  }) = _GameEntity;

  factory GameEntity.fromJson(Map<String, dynamic> json) =>
      _$GameEntityFromJson(json);
}

@freezed
class Bid with _$Bid {
  const factory Bid({
    required String playerId,
    required BidType type,
    ContractType? contract,
    required DateTime timestamp,
  }) = _Bid;

  factory Bid.fromJson(Map<String, dynamic> json) => _$BidFromJson(json);
}

@freezed
class Declaration with _$Declaration {
  const factory Declaration({
    required String type,
    required List<String> cards,
    required int points,
    required String playerId,
  }) = _Declaration;

  factory Declaration.fromJson(Map<String, dynamic> json) =>
      _$DeclarationFromJson(json);
}

@freezed
class Trick with _$Trick {
  const factory Trick({
    required List<PlayedCard> cards,
    required String winnerId,
    required int points,
  }) = _Trick;

  factory Trick.fromJson(Map<String, dynamic> json) => _$TrickFromJson(json);
}

@freezed
class PlayedCard with _$PlayedCard {
  const factory PlayedCard({
    required String playerId,
    required Map<String, dynamic> card,
  }) = _PlayedCard;

  factory PlayedCard.fromJson(Map<String, dynamic> json) =>
      _$PlayedCardFromJson(json);
}
