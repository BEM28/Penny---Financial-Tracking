import 'package:flutter/material.dart';
import 'package:penny/utils/constants.dart';

class CardTracker extends StatelessWidget {
  const CardTracker({
    super.key,
    required this.title,
    required this.balance,
  });

  final String title;
  final String balance;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.tertiary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.secondary),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.wallet, color: AppColors.secondary),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                color: AppColors.secondary.withValues(alpha: .6),
                fontSize: 14,
              ),
            ),
            Text(
              balance,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.secondary,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
