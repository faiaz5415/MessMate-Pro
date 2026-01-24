import 'package:flutter/material.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 15, // mock days
        itemBuilder: (context, index) {
          return _MealDayCard(
            date: 'Day ${index + 1}',
            mealCount: 1.0,
          );
        },
      ),
    );
  }
}

class _MealDayCard extends StatelessWidget {
  final String date;
  final double mealCount;

  const _MealDayCard({
    required this.date,
    required this.mealCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Meal Count',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () {
                // decrease meal
              },
            ),

            Text(
              mealCount.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {
                // increase meal
              },
            ),
          ],
        ),
      ),
    );
  }
}

