import 'package:flutter/material.dart';

import '../main/main_shell.dart';
import 'join_status_screen.dart';

class DiningSelectScreen extends StatelessWidget {
  final bool isManager;

  const DiningSelectScreen({
    super.key,
    required this.isManager,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isManager ? 'Create Dining' : 'Join Dining'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),

            /// MANAGER VIEW
            if (isManager) ...[
              ElevatedButton.icon(
                onPressed: () {
                  // Later: Firebase create dining + generate key

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MainShell(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Create New Dining'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],

            /// MEMBER VIEW
            if (!isManager) ...[
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
                  // Later: validate key + send join request

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const JoinStatusScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Join Dining'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
