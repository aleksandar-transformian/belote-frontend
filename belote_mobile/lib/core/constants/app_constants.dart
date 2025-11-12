class AppConstants {
  // API
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://localhost:3000',
  );
  static const String apiVersion = 'v1';
  static const String apiPrefix = '/api/$apiVersion';

  // WebSocket
  static const String socketUrl = String.fromEnvironment(
    'SOCKET_URL',
    defaultValue: 'http://localhost:3000',
  );

  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String themeKey = 'theme_mode';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Game
  static const int maxPlayers = 4;
  static const int cardsPerPlayer = 8;
  static const int matchPointsToWin = 151;

  // Pagination
  static const int defaultPageSize = 20;

  // Animation
  static const Duration cardAnimationDuration = Duration(milliseconds: 300);
  static const Duration trickAnimationDuration = Duration(milliseconds: 500);
}

class AppStrings {
  static const String appName = 'Belote';
  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNetwork = 'No internet connection.';
  static const String errorAuth = 'Authentication failed.';
  static const String errorServer = 'Server error. Please try again later.';
}

class AppAssets {
  static const String _imagesPath = 'assets/images';
  static const String _iconsPath = 'assets/icons';
  static const String _cardsPath = 'assets/cards';

  // Images
  static const String logo = '$_imagesPath/logo.png';
  static const String gameBoardBackground = '$_imagesPath/game_board_bg.png';

  // Icons
  static const String clubsIcon = '$_iconsPath/clubs.svg';
  static const String diamondsIcon = '$_iconsPath/diamonds.svg';
  static const String heartsIcon = '$_iconsPath/hearts.svg';
  static const String spadesIcon = '$_iconsPath/spades.svg';

  // Card back
  static const String cardBack = '$_cardsPath/card_back.png';
}
