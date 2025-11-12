import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:injectable/injectable.dart';
import '../constants/app_constants.dart';
import 'package:logger/logger.dart';

@lazySingleton
class WebSocketService {
  IO.Socket? _socket;
  final Logger _logger = Logger();
  bool _isConnected = false;

  bool get isConnected => _isConnected;

  void connect(String token) {
    try {
      _socket = IO.io(
        AppConstants.socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .setAuth({'token': token})
            .build(),
      );

      _socket!.onConnect((_) {
        _isConnected = true;
        _logger.i('WebSocket connected');
      });

      _socket!.onDisconnect((_) {
        _isConnected = false;
        _logger.w('WebSocket disconnected');
      });

      _socket!.onError((error) {
        _logger.e('WebSocket error: $error');
      });

      _socket!.connect();
    } catch (e) {
      _logger.e('Failed to connect WebSocket: $e');
    }
  }

  void disconnect() {
    if (_socket != null) {
      _socket!.disconnect();
      _socket!.dispose();
      _socket = null;
      _isConnected = false;
      _logger.i('WebSocket manually disconnected');
    }
  }

  void emit(String event, dynamic data) {
    if (_isConnected && _socket != null) {
      _socket!.emit(event, data);
      _logger.d('Emitted event: $event with data: $data');
    } else {
      _logger.w('Cannot emit event $event: WebSocket not connected');
    }
  }

  void on(String event, Function(dynamic) callback) {
    _socket?.on(event, callback);
  }

  void off(String event) {
    _socket?.off(event);
  }

  // Game-specific methods
  void joinQueue(int eloRating) {
    emit('join_queue', {'eloRating': eloRating});
  }

  void joinGame(String gameId) {
    emit('join_game', {'gameId': gameId});
  }

  void placeBid(String gameId, String bidType, String? contract) {
    emit('place_bid', {
      'gameId': gameId,
      'bidType': bidType,
      'contract': contract,
    });
  }

  void playCard(String gameId, Map<String, dynamic> card) {
    emit('play_card', {
      'gameId': gameId,
      'card': card,
    });
  }

  void declare(String gameId, String type, List<String> cards) {
    emit('declare', {
      'gameId': gameId,
      'type': type,
      'cards': cards,
    });
  }

  // Event listeners
  void onMatchFound(Function(dynamic) callback) {
    on('match_found', callback);
  }

  void onGameStarted(Function(dynamic) callback) {
    on('game_started', callback);
  }

  void onBidPlaced(Function(dynamic) callback) {
    on('bid_placed', callback);
  }

  void onCardPlayed(Function(dynamic) callback) {
    on('card_played', callback);
  }

  void onTrickComplete(Function(dynamic) callback) {
    on('trick_complete', callback);
  }

  void onGameComplete(Function(dynamic) callback) {
    on('game_complete', callback);
  }

  void onPlayerDisconnected(Function(dynamic) callback) {
    on('player_disconnected', callback);
  }

  void onPlayerReconnected(Function(dynamic) callback) {
    on('player_reconnected', callback);
  }
}
