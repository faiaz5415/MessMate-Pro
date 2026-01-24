import 'package:flutter/material.dart';

class BazarScreen extends StatelessWidget {
  const BazarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bazar Log'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 8, // mock entries
        itemBuilder: (context, index) {
          return const _BazarItemCard(
            title: 'Chicken & Rice',
            date: '12 Jan 2026',
            amount: 450,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // add bazar (manager only later)
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _BazarItemCard extends StatelessWidget {
  final String title;
  final String date;
  final double amount;

  const _BazarItemCard({
    required this.title,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.shopping_bag, size: 32),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            Text(
              '৳ ${amount.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
