import 'package:flutter/material.dart';

import '../../widgets/summary_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            SummaryCard(
              title: 'Meal Rate',
              value: '৳ 65',
              icon: Icons.calculate,
            ),
            SizedBox(height: 12),
            SummaryCard(
              title: 'Your Cost',
              value: '৳ 1,950',
              icon: Icons.person,
            ),
            SizedBox(height: 12),
            SummaryCard(
              title: 'Total Mess Cost',
              value: '৳ 12,300',
              icon: Icons.group,
            ),
          ],
        ),
      ),
    );
  }
}
