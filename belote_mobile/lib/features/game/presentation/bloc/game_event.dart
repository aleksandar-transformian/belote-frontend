import 'package:equatable/equatable.dart';
import '../../domain/entities/card.dart';
import '../../domain/entities/game.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

class JoinQueue extends GameEvent {
  final int eloRating;

  const JoinQueue(this.eloRating);

  @override
  List<Object?> get props => [eloRating];
}

class JoinGame extends GameEvent {
  final String gameId;

  const JoinGame(this.gameId);

  @override
  List<Object?> get props => [gameId];
}

class PlaceBid extends GameEvent {
  final String gameId;
  final BidType bidType;
  final ContractType? contract;

  const PlaceBid({
    required this.gameId,
    required this.bidType,
    this.contract,
  });

  @override
  List<Object?> get props => [gameId, bidType, contract];
}

class PlayCard extends GameEvent {
  final String gameId;
  final CardEntity card;

  const PlayCard({
    required this.gameId,
    required this.card,
  });

  @override
  List<Object?> get props => [gameId, card];
}

class UpdateGameState extends GameEvent {
  final Map<String, dynamic> gameState;

  const UpdateGameState(this.gameState);

  @override
  List<Object?> get props => [gameState];
}

class LeaveGame extends GameEvent {
  final String gameId;

  const LeaveGame(this.gameId);

  @override
  List<Object?> get props => [gameId];
}
