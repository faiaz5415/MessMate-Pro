import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppStyles.spaceMedium),
        children: [
          /// ACCOUNT SECTION
          Text(
            'Account',
            style: AppStyles.heading3,
          ),
          const SizedBox(height: AppStyles.spaceMedium),

          _SettingsTile(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            subtitle: 'Update your name and phone',
            onTap: () {},
          ),

          _SettingsTile(
            icon: Icons.lock_outline,
            title: 'Change Password',
            subtitle: 'Update your password',
            onTap: () {},
          ),

          const SizedBox(height: AppStyles.spaceLarge),

          /// DINING SECTION
          Text(
            'Dining',
            style: AppStyles.heading3,
          ),
          const SizedBox(height: AppStyles.spaceMedium),

          _SettingsTile(
            icon: Icons.restaurant_menu,
            title: 'Dining Info',
            subtitle: 'View dining key and details',
            onTap: () {},
          ),

          _SettingsTile(
            icon: Icons.calendar_month,
            title: 'Meal Preferences',
            subtitle: 'Set default meal options',
            onTap: () {},
          ),

          const SizedBox(height: AppStyles.spaceLarge),

          /// APP SECTION
          Text(
            'App Settings',
            style: AppStyles.heading3,
          ),
          const SizedBox(height: AppStyles.spaceMedium),

          _SettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: 'Manage push notifications',
            trailing: Switch(
              value: true,
              onChanged: (value) {},
              activeColor: AppColors.primary,
            ),
          ),

          _SettingsTile(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            subtitle: 'Coming soon',
            trailing: Switch(
              value: false,
              onChanged: null,
            ),
          ),

          const SizedBox(height: AppStyles.spaceLarge),

          /// ABOUT SECTION
          Text(
            'About',
            style: AppStyles.heading3,
          ),
          const SizedBox(height: AppStyles.spaceMedium),

          _SettingsTile(
            icon: Icons.info_outline,
            title: 'About App',
            subtitle: 'Version 1.0.0',
            onTap: () {},
          ),

          _SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            subtitle: 'View our privacy policy',
            onTap: () {},
          ),

          const SizedBox(height: AppStyles.spaceLarge),

          /// LOGOUT BUTTON
          ModernCard(
            padding: const EdgeInsets.all(AppStyles.spaceMedium),
            color: AppColors.error.withOpacity(0.05),
            onTap: () {
              // Logout
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout,
                  color: AppColors.error,
                  size: 20,
                ),
                const SizedBox(width: AppStyles.spaceSmall),
                Text(
                  'Logout',
                  style: AppStyles.bodyMedium.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// SETTINGS TILE
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.trailing,
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
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
          ),

          const SizedBox(width: AppStyles.spaceMedium),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppStyles.spaceXSmall),
                Text(
                  subtitle,
                  style: AppStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          if (trailing != null)
            trailing!
          else if (onTap != null)
            Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
            ),
        ],
      ),
    );
  }
}
