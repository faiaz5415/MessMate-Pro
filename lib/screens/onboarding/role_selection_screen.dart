import 'package:flutter/material.dart';

import 'dining_select_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Role'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 24),

            /// Mess Manager
            _RoleCard(
              icon: Icons.admin_panel_settings,
              title: 'Mess Manager',
              subtitle: 'Manages meals, bazar and costs',
              onTap: () {
                // Later: save role = manager in Provider

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DiningSelectScreen(
                      isManager: true,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            /// Mess Member
            _RoleCard(
              icon: Icons.people,
              title: 'Mess Member',
              subtitle: 'Logs meals and views costs',
              onTap: () {
                // Later: save role = member in Provider

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DiningSelectScreen(
                      isManager: false,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 36),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
