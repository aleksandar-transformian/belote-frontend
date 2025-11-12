import 'package:flutter/material.dart';
import '../../features/game/domain/entities/card.dart';
import '../../core/theme/app_theme.dart';

class PlayingCardWidget extends StatelessWidget {
  final CardEntity? card;
  final bool faceUp;
  final double width;
  final double height;
  final VoidCallback? onTap;
  final bool selected;
  final bool enabled;

  const PlayingCardWidget({
    super.key,
    this.card,
    this.faceUp = true,
    this.width = 70,
    this.height = 100,
    this.onTap,
    this.selected = false,
    this.enabled = true,
  });

  Color _getSuitColor(Suit suit) {
    switch (suit) {
      case Suit.clubs:
        return AppTheme.clubsColor;
      case Suit.diamonds:
        return AppTheme.diamondsColor;
      case Suit.hearts:
        return AppTheme.heartsColor;
      case Suit.spades:
        return AppTheme.spadesColor;
    }
  }

  String _getSuitSymbol(Suit suit) {
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

  String _getRankDisplay(Rank rank) {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: faceUp ? Colors.white : Colors.blue[900],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? AppTheme.accentGold : Colors.grey[300]!,
            width: selected ? 3 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: faceUp && card != null
            ? _buildCardFace(card!)
            : _buildCardBack(),
      ),
    );
  }

  Widget _buildCardFace(CardEntity card) {
    final suitColor = _getSuitColor(card.suit);
    final suitSymbol = _getSuitSymbol(card.suit);
    final rankDisplay = _getRankDisplay(card.rank);

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top rank and suit
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rankDisplay,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: suitColor,
                ),
              ),
              Text(
                suitSymbol,
                style: TextStyle(
                  fontSize: 16,
                  color: suitColor,
                ),
              ),
            ],
          ),
          // Center suit symbol
          Expanded(
            child: Center(
              child: Text(
                suitSymbol,
                style: TextStyle(
                  fontSize: 32,
                  color: suitColor,
                ),
              ),
            ),
          ),
          // Bottom rank and suit (upside down)
          Transform.rotate(
            angle: 3.14159, // 180 degrees in radians
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rankDisplay,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: suitColor,
                  ),
                ),
                Text(
                  suitSymbol,
                  style: TextStyle(
                    fontSize: 16,
                    color: suitColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack() {
    return Center(
      child: Icon(
        Icons.playing_cards,
        size: 48,
        color: Colors.white.withOpacity(0.5),
      ),
    );
  }
}
