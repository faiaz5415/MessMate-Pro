import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';
import '../sub/members_screen.dart';
import '../sub/notices_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.03),
              AppColors.background,
            ],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Padding(
                  padding: const EdgeInsets.all(AppStyles.spaceLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'More Options',
                        style: AppStyles.heading2.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Settings & additional features',
                        style: AppStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppStyles.spaceSmall),

                /// DINING SECTION
                _SectionHeader(title: 'Dining Management'),
                const SizedBox(height: AppStyles.spaceSmall),

                _MenuTile(
                  icon: Icons.group_outlined,
                  title: 'Members',
                  subtitle: 'View all dining members',
                  color: AppColors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MembersScreen(),
                      ),
                    );
                  },
                ),

                _MenuTile(
                  icon: Icons.campaign_outlined,
                  title: 'Notices',
                  subtitle: 'View important announcements',
                  color: AppColors.orange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NoticesScreen(),
                      ),
                    );
                  },
                ),

                _MenuTile(
                  icon: Icons.table_chart_outlined,
                  title: 'Meal Table',
                  subtitle: 'Daily meal tracking',
                  color: AppColors.purple,
                  onTap: () {},
                ),

                const SizedBox(height: AppStyles.spaceLarge),

                /// ACCOUNT SECTION
                _SectionHeader(title: 'Account & Settings'),
                const SizedBox(height: AppStyles.spaceSmall),

                _MenuTile(
                  icon: Icons.person_outline,
                  title: 'Profile',
                  subtitle: 'Manage your profile',
                  color: AppColors.teal,
                  onTap: () {},
                ),

                _MenuTile(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  subtitle: 'App preferences',
                  color: AppColors.blue,
                  onTap: () {},
                ),

                const SizedBox(height: AppStyles.spaceLarge),

                /// HELP SECTION
                _SectionHeader(title: 'Help & Support'),
                const SizedBox(height: AppStyles.spaceSmall),

                _MenuTile(
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  subtitle: 'FAQs and support',
                  color: AppColors.info,
                  onTap: () {},
                ),

                _MenuTile(
                  icon: Icons.feedback_outlined,
                  title: 'Send Feedback',
                  subtitle: 'Share your thoughts',
                  color: AppColors.warning,
                  onTap: () {},
                ),

                _MenuTile(
                  icon: Icons.info_outline,
                  title: 'About',
                  subtitle: 'App version & info',
                  color: AppColors.textSecondary,
                  onTap: () {},
                ),

                const SizedBox(height: AppStyles.spaceLarge),

                /// LOGOUT BUTTON
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppStyles.spaceLarge,
                  ),
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.logout, color: AppColors.error),
                    label: const Text(
                      'Logout',
                      style: TextStyle(color: AppColors.error),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.error),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                ),

                const SizedBox(height: AppStyles.spaceXLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// SECTION HEADER
/// ------------------------------------------------------------
class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppStyles.spaceLarge,
      ),
      child: Text(
        title,
        style: AppStyles.bodySmall.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.textSecondary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// MENU TILE
/// ------------------------------------------------------------
class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _MenuTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      margin: const EdgeInsets.symmetric(
        horizontal: AppStyles.spaceLarge,
        vertical: 4,
      ),
      padding: const EdgeInsets.all(AppStyles.spaceMedium),
      onTap: onTap,
      child: Row(
        children: [
          /// ICON
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),

          const SizedBox(width: AppStyles.spaceMedium),

          /// TEXT
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
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: AppStyles.spaceSmall),

          /// ARROW
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.textSecondary.withOpacity(0.4),
            size: 16,
          ),
        ],
      ),
    );
  }
}
