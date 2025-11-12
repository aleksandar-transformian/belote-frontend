import 'package:flutter/material.dart';
import '../../../../shared/widgets/playing_card_widget.dart';
import '../../domain/entities/card.dart';

class GameTable extends StatelessWidget {
  final List<CardEntity> playerHand;
  final List<CardEntity> playedCards;
  final String currentPlayerName;
  final Function(CardEntity) onCardPlayed;
  final bool isPlayerTurn;

  const GameTable({
    super.key,
    required this.playerHand,
    required this.playedCards,
    required this.currentPlayerName,
    required this.onCardPlayed,
    required this.isPlayerTurn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top section - Opponents
        Expanded(
          flex: 2,
          child: _buildOpponentsArea(),
        ),
        // Middle section - Table center (played cards)
        Expanded(
          flex: 3,
          child: _buildTableCenter(),
        ),
        // Bottom section - Player's hand
        Expanded(
          flex: 2,
          child: _buildPlayerHand(),
        ),
      ],
    );
  }

  Widget _buildOpponentsArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildOpponentPosition('Player 2', PlayerPosition.left),
          _buildOpponentPosition('Player 3', PlayerPosition.top),
          _buildOpponentPosition('Player 4', PlayerPosition.right),
        ],
      ),
    );
  }

  Widget _buildOpponentPosition(String name, PlayerPosition position) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        // Show back of cards for opponents
        Row(
          children: List.generate(
            3, // Show 3 cards as preview
            (index) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: PlayingCardWidget(
                faceUp: false,
                width: 40,
                height: 60,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTableCenter() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[700],
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.all(16),
      child: Stack(
        children: [
          // Table felt texture
          Center(
            child: Text(
              currentPlayerName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          // Played cards
          if (playedCards.isNotEmpty)
            Center(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: playedCards.map((card) {
                  return PlayingCardWidget(
                    card: card,
                    faceUp: true,
                    width: 60,
                    height: 85,
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlayerHand() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: playerHand.map((card) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: PlayingCardWidget(
                card: card,
                faceUp: true,
                width: 70,
                height: 100,
                onTap: isPlayerTurn ? () => onCardPlayed(card) : null,
                enabled: isPlayerTurn,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

enum PlayerPosition {
  bottom, // Current player
  left,
  top,
  right,
}
