import 'package:flutter/material.dart';

class DiningSelectScreen extends StatelessWidget {
  const DiningSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dining Setup'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: () {
                // manager creates dining
              },
              icon: const Icon(Icons.add),
              label: const Text('Create New Dining'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),

            const SizedBox(height: 24),

            const Center(child: Text('OR')),

            const SizedBox(height: 24),

            TextField(
              decoration: InputDecoration(
                labelText: 'Enter Dining Key',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                // join dining
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Join Dining'),
            ),
          ],
        ),
      ),
    );
  }
}
