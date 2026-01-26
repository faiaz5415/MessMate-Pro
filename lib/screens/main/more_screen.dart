import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppStyles.spaceMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// USER PROFILE CARD
            ModernCard(
              margin: const EdgeInsets.only(bottom: AppStyles.spaceLarge),
              padding: const EdgeInsets.all(AppStyles.spaceMedium),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Text(
                      'FM',
                      style: AppStyles.heading3.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppStyles.spaceMedium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Faiaz Hasan',
                          style: AppStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppStyles.spaceXSmall),
                        Text(
                          'Member',
                          style: AppStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    color: AppColors.primary,
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            /// SETTINGS SECTION
            Text(
              'Settings',
              style: AppStyles.heading3,
            ),
            const SizedBox(height: AppStyles.spaceMedium),

            _MoreTile(
              icon: Icons.person_outline,
              title: 'Profile',
              onTap: () {},
            ),
            _MoreTile(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              onTap: () {},
            ),
            _MoreTile(
              icon: Icons.people_outline,
              title: 'Members',
              onTap: () {},
            ),
            _MoreTile(
              icon: Icons.settings_outlined,
              title: 'App Settings',
              onTap: () {},
            ),

            const SizedBox(height: AppStyles.spaceLarge),

            /// SUPPORT SECTION
            Text(
              'Support',
              style: AppStyles.heading3,
            ),
            const SizedBox(height: AppStyles.spaceMedium),

            _MoreTile(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {},
            ),
            _MoreTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              onTap: () {},
            ),
            _MoreTile(
              icon: Icons.info_outline,
              title: 'About',
              onTap: () {},
            ),

            const SizedBox(height: AppStyles.spaceLarge),

            /// LOGOUT BUTTON
            ModernCard(
              padding: const EdgeInsets.all(AppStyles.spaceMedium),
              onTap: () {
                _showLogoutDialog(context);
              },
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppStyles.spaceSmall),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                    ),
                    child: Icon(
                      Icons.logout,
                      color: AppColors.error,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppStyles.spaceMedium),
                  Expanded(
                    child: Text(
                      'Logout',
                      style: AppStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.error,
                    size: 20,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppStyles.spaceLarge),

            /// APP VERSION
            Center(
              child: Text(
                'MessMate Pro v1.0.0',
                style: AppStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
        ),
        title: Text(
          'Logout',
          style: AppStyles.heading3,
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: AppStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to sign in (later with provider logic)
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

/// MORE TILE WIDGET
class _MoreTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MoreTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      margin: const EdgeInsets.only(bottom: AppStyles.spaceSmall),
      padding: const EdgeInsets.all(AppStyles.spaceMedium),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppStyles.spaceSmall),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: AppStyles.spaceMedium),
          Expanded(
            child: Text(
              title,
              style: AppStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 20),
        ],
      ),
    );
  }
}
