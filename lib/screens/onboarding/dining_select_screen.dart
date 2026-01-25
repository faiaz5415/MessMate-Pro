import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main/main_shell.dart';

class DiningSelectScreen extends StatelessWidget {
  final bool isManager;

  const DiningSelectScreen({
    super.key,
    required this.isManager,
  });

  String _generateDiningKey() {
    final rand = Random();
    return (100000 + rand.nextInt(900000)).toString();
  }

  void _showCreateDiningDialog(BuildContext context) {
    final nameController = TextEditingController();
    final monthController = TextEditingController();
    final diningKey = _generateDiningKey();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text('Create Dining'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Dining Name
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Dining Name',
                  ),
                ),

                const SizedBox(height: 12),

                /// Month
                TextField(
                  controller: monthController,
                  decoration: const InputDecoration(
                    labelText: 'Month (e.g. January 2026)',
                  ),
                ),

                const SizedBox(height: 16),

                /// Dining Key + Copy
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Dining Key: $diningKey',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: diningKey),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Dining key copied'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Later: save dining to Firebase

                Navigator.pop(context); // close dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MainShell(),
                  ),
                );
              },
              child: const Text('Explore Your Dining'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dining Setup'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),

            if (isManager)
              ElevatedButton.icon(
                onPressed: () {
                  _showCreateDiningDialog(context);
                },
                icon: const Icon(Icons.add),
                label: const Text('Create New Dining'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
