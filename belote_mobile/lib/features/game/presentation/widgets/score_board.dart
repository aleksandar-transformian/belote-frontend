import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final int team1Score;
  final int team2Score;
  final int team1MatchPoints;
  final int team2MatchPoints;
  final String team1Name;
  final String team2Name;

  const ScoreBoard({
    super.key,
    required this.team1Score,
    required this.team2Score,
    required this.team1MatchPoints,
    required this.team2MatchPoints,
    this.team1Name = 'Team 1',
    this.team2Name = 'Team 2',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Score',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTeamScore(
                    context,
                    team1Name,
                    team1Score,
                    team1MatchPoints,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'VS',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTeamScore(
                    context,
                    team2Name,
                    team2Score,
                    team2MatchPoints,
                    Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamScore(
    BuildContext context,
    String teamName,
    int roundScore,
    int matchPoints,
    Color color,
  ) {
    return Column(
      children: [
        Text(
          teamName,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          matchPoints.toString(),
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Round: $roundScore',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
