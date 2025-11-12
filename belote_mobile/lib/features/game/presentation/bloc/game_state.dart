import 'package:equatable/equatable.dart';
import '../../domain/entities/game.dart';
import '../../domain/entities/card.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object?> get props => [];
}

class GameInitial extends GameState {}

class GameLoading extends GameState {}

class InQueue extends GameState {
  final int playersWaiting;

  const InQueue(this.playersWaiting);

  @override
  List<Object?> get props => [playersWaiting];
}

class MatchFound extends GameState {
  final String gameId;
  final List<String> players;

  const MatchFound({
    required this.gameId,
    required this.players,
  });

  @override
  List<Object?> get props => [gameId, players];
}

class GameInProgress extends GameState {
  final GameEntity game;
  final List<CardEntity> playerHand;
  final List<CardEntity> playedCards;
  final String currentPlayerId;
  final bool isPlayerTurn;

  const GameInProgress({
    required this.game,
    required this.playerHand,
    required this.playedCards,
    required this.currentPlayerId,
    required this.isPlayerTurn,
  });

  @override
  List<Object?> get props => [
        game,
        playerHand,
        playedCards,
        currentPlayerId,
        isPlayerTurn,
      ];
}

class BiddingPhase extends GameState {
  final GameEntity game;
  final List<Bid> bids;
  final bool isPlayerTurn;

  const BiddingPhase({
    required this.game,
    required this.bids,
    required this.isPlayerTurn,
  });

  @override
  List<Object?> get props => [game, bids, isPlayerTurn];
}

class GameCompleted extends GameState {
  final GameEntity game;
  final String winningTeam;
  final int team1Score;
  final int team2Score;

  const GameCompleted({
    required this.game,
    required this.winningTeam,
    required this.team1Score,
    required this.team2Score,
  });

  @override
  List<Object?> get props => [game, winningTeam, team1Score, team2Score];
}

class GameError extends GameState {
  final String message;

  const GameError(this.message);

  @override
  List<Object?> get props => [message];
}
