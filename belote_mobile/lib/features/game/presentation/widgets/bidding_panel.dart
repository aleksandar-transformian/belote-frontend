import 'package:flutter/material.dart';
import '../../domain/entities/game.dart';
import '../../../../shared/widgets/custom_button.dart';

class BiddingPanel extends StatelessWidget {
  final Function(BidType, ContractType?) onBid;
  final bool enabled;

  const BiddingPanel({
    super.key,
    required this.onBid,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Place Your Bid',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Contract bids
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _buildBidButton(
                  context,
                  '♣ Clubs',
                  () => onBid(BidType.contract, ContractType.clubs),
                  Colors.black,
                ),
                _buildBidButton(
                  context,
                  '♦ Diamonds',
                  () => onBid(BidType.contract, ContractType.diamonds),
                  Colors.red,
                ),
                _buildBidButton(
                  context,
                  '♥ Hearts',
                  () => onBid(BidType.contract, ContractType.hearts),
                  Colors.red,
                ),
                _buildBidButton(
                  context,
                  '♠ Spades',
                  () => onBid(BidType.contract, ContractType.spades),
                  Colors.black,
                ),
                _buildBidButton(
                  context,
                  'No Trumps',
                  () => onBid(BidType.contract, ContractType.noTrumps),
                  Colors.blue,
                ),
                _buildBidButton(
                  context,
                  'All Trumps',
                  () => onBid(BidType.contract, ContractType.allTrumps),
                  Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Pass button
            CustomButton(
              text: 'Pass',
              onPressed: enabled ? () => onBid(BidType.pass, null) : () {},
              isDisabled: !enabled,
              backgroundColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBidButton(
    BuildContext context,
    String label,
    VoidCallback onPressed,
    Color color,
  ) {
    return SizedBox(
      width: 110,
      height: 48,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
