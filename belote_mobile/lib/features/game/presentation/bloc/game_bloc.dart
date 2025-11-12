import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/websocket_service.dart';
import 'game_event.dart';
import 'game_state.dart';

@injectable
class GameBloc extends Bloc<GameEvent, GameState> {
  final WebSocketService _webSocketService;

  GameBloc(this._webSocketService) : super(GameInitial()) {
    on<JoinQueue>(_onJoinQueue);
    on<JoinGame>(_onJoinGame);
    on<PlaceBid>(_onPlaceBid);
    on<PlayCard>(_onPlayCard);
    on<UpdateGameState>(_onUpdateGameState);
    on<LeaveGame>(_onLeaveGame);

    // Set up WebSocket listeners
    _setupWebSocketListeners();
  }

  void _setupWebSocketListeners() {
    _webSocketService.onMatchFound((data) {
      add(UpdateGameState(data));
    });

    _webSocketService.onGameStarted((data) {
      add(UpdateGameState(data));
    });

    _webSocketService.onBidPlaced((data) {
      add(UpdateGameState(data));
    });

    _webSocketService.onCardPlayed((data) {
      add(UpdateGameState(data));
    });

    _webSocketService.onTrickComplete((data) {
      add(UpdateGameState(data));
    });

    _webSocketService.onGameComplete((data) {
      add(UpdateGameState(data));
    });
  }

  Future<void> _onJoinQueue(
    JoinQueue event,
    Emitter<GameState> emit,
  ) async {
    emit(GameLoading());
    try {
      _webSocketService.joinQueue(event.eloRating);
      emit(const InQueue(0));
    } catch (e) {
      emit(GameError('Failed to join queue: ${e.toString()}'));
    }
  }

  Future<void> _onJoinGame(
    JoinGame event,
    Emitter<GameState> emit,
  ) async {
    emit(GameLoading());
    try {
      _webSocketService.joinGame(event.gameId);
    } catch (e) {
      emit(GameError('Failed to join game: ${e.toString()}'));
    }
  }

  Future<void> _onPlaceBid(
    PlaceBid event,
    Emitter<GameState> emit,
  ) async {
    try {
      _webSocketService.placeBid(
        event.gameId,
        event.bidType.toString(),
        event.contract?.toString(),
      );
    } catch (e) {
      emit(GameError('Failed to place bid: ${e.toString()}'));
    }
  }

  Future<void> _onPlayCard(
    PlayCard event,
    Emitter<GameState> emit,
  ) async {
    try {
      _webSocketService.playCard(
        event.gameId,
        {
          'suit': event.card.suit.toString(),
          'rank': event.card.rank.toString(),
        },
      );
    } catch (e) {
      emit(GameError('Failed to play card: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateGameState(
    UpdateGameState event,
    Emitter<GameState> emit,
  ) async {
    try {
      // Parse the game state from WebSocket data
      // This is a simplified implementation
      // In a real app, you'd parse the full game state
      final gameData = event.gameState;

      // Emit appropriate state based on game phase
      // This would need full implementation based on your backend structure
      emit(GameLoading());
    } catch (e) {
      emit(GameError('Failed to update game state: ${e.toString()}'));
    }
  }

  Future<void> _onLeaveGame(
    LeaveGame event,
    Emitter<GameState> emit,
  ) async {
    try {
      _webSocketService.disconnect();
      emit(GameInitial());
    } catch (e) {
      emit(GameError('Failed to leave game: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() {
    _webSocketService.disconnect();
    return super.close();
  }
}
