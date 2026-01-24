import 'package:flutter/material.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Up Profile'),
        centerTitle: true,
        automaticallyImplyLeading: false, // You might want to control back navigation if needed
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),

            Center(
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.grey.shade300,
                child: const Icon(Icons.camera_alt, size: 30),
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number (optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                // mock complete profile
                // Navigate to the next screen, e.g., dining selection or main shell
                // Example: Navigator.pushReplacementNamed(context, '/dining-select');
                print('Continue button pressed (mock action)');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}