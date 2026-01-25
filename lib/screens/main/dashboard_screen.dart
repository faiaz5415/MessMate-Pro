import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// ---------------- MOCK DATA ----------------
    /// Later these will come from Provider / Firebase

    final bool youHaveToPay = true; // false হলে receive
    final double balanceAmount = 350;

    final int totalMeals = 189;
    final double mealRate = 65;
    final double yourCost = 1950;
    final double totalMessCost = 12300;

    /// -------------------------------------------

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// PAY / RECEIVE CARD
            _BalanceStatusCard(
              isPay: youHaveToPay,
              amount: balanceAmount,
            ),

            const SizedBox(height: 16),

            /// SUMMARY GRID
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _ModernInfoCard(
                  title: 'Total Meals',
                  value: totalMeals.toString(),
                  icon: Icons.restaurant,
                  color: Colors.orange,
                ),
                _ModernInfoCard(
                  title: 'Meal Rate',
                  value: '৳ $mealRate',
                  icon: Icons.calculate,
                  color: Colors.blue,
                ),
                _ModernInfoCard(
                  title: 'Your Cost',
                  value: '৳ $yourCost',
                  icon: Icons.person,
                  color: Colors.purple,
                ),
                _ModernInfoCard(
                  title: 'Total Mess Cost',
                  value: '৳ $totalMessCost',
                  icon: Icons.groups,
                  color: Colors.teal,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// PAY / RECEIVE CARD
/// ------------------------------------------------------------
class _BalanceStatusCard extends StatelessWidget {
  final bool isPay;
  final double amount;

  const _BalanceStatusCard({
    required this.isPay,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isPay ? Colors.red : Colors.green;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Text(
            isPay ? 'You Have To Pay' : 'You Will Receive',
            style: TextStyle(
              fontSize: 16,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '৳ ${amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// MODERN INFO CARD
/// ------------------------------------------------------------
class _ModernInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _ModernInfoCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color.withOpacity(0.08),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
