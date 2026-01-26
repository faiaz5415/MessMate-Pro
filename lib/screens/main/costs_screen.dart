import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class CostsScreen extends StatelessWidget {
  const CostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// ---------------- MOCK DATA ----------------
    final bool youHaveToPay = true;
    final double balanceAmount = 350;

    final List<Map<String, dynamic>> deposits = [
      {'date': '20 Jan 2026', 'amount': 500.0},
      {'date': '10 Jan 2026', 'amount': 1000.0},
      {'date': '1 Jan 2026', 'amount': 800.0},
    ];

    final double totalDeposit = deposits.fold(
      0,
          (sum, item) => sum + (item['amount'] as double),
    );

    /// -------------------------------------------

    return Scaffold(
      appBar: AppBar(
        title: const Text('Costs & Deposits'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppStyles.spaceMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// BALANCE STATUS CARD
            Container(
              padding: const EdgeInsets.all(AppStyles.spaceLarge),
              decoration: AppStyles.coloredCardDecoration(
                youHaveToPay ? AppColors.error : AppColors.success,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppStyles.spaceMedium),
                    decoration: BoxDecoration(
                      color: (youHaveToPay
                          ? AppColors.error
                          : AppColors.success)
                          .withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      youHaveToPay
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color:
                      youHaveToPay ? AppColors.error : AppColors.success,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: AppStyles.spaceMedium),
                  Text(
                    youHaveToPay ? 'You Have To Pay' : 'You Will Receive',
                    style: AppStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppStyles.spaceSmall),
                  Text(
                    '৳${balanceAmount.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color:
                      youHaveToPay ? AppColors.error : AppColors.success,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppStyles.spaceLarge),

            /// TOTAL DEPOSIT CARD
            ModernCard(
              padding: const EdgeInsets.all(AppStyles.spaceMedium),
              color: AppColors.blue.withOpacity(0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppStyles.spaceSmall),
                        decoration: BoxDecoration(
                          color: AppColors.blue.withOpacity(0.1),
                          borderRadius:
                          BorderRadius.circular(AppStyles.radiusSmall),
                        ),
                        child: Icon(
                          Icons.account_balance_wallet_outlined,
                          color: AppColors.blue,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppStyles.spaceMedium),
                      Text(
                        'Total Deposit',
                        style: AppStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '৳${totalDeposit.toStringAsFixed(0)}',
                    style: AppStyles.heading3.copyWith(
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppStyles.spaceLarge),

            /// SECTION TITLE
            Text(
              'Deposit History',
              style: AppStyles.heading3,
            ),

            const SizedBox(height: AppStyles.spaceMedium),

            /// DEPOSIT LIST
            ...deposits.map((deposit) {
              return _DepositItem(
                date: deposit['date'],
                amount: deposit['amount'],
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add deposit
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Deposit'),
      ),
    );
  }
}

/// DEPOSIT ITEM
class _DepositItem extends StatelessWidget {
  final String date;
  final double amount;

  const _DepositItem({
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      margin: const EdgeInsets.only(bottom: AppStyles.spaceSmall),
      padding: const EdgeInsets.all(AppStyles.spaceMedium),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppStyles.spaceSmall),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
            ),
            child: Icon(
              Icons.payments_outlined,
              color: AppColors.success,
              size: 20,
            ),
          ),

          const SizedBox(width: AppStyles.spaceMedium),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '৳${amount.toStringAsFixed(0)}',
                  style: AppStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppStyles.spaceXSmall),
                Text(
                  date,
                  style: AppStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            Icons.check_circle,
            color: AppColors.success,
            size: 20,
          ),
        ],
      ),
    );
  }
}
