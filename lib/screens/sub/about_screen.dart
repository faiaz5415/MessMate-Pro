import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          children: [
            Text(
              'About App',
              style: AppStyles.heading3.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              'Version 1.0.0',
              style: AppStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
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
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: AppStyles.spaceLarge),
            children: [
              const SizedBox(height: AppStyles.spaceXLarge),

              /// APP LOGO & NAME SECTION
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.restaurant_menu_rounded,
                        size: 60,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: AppStyles.spaceLarge),
                    Text(
                      'MessMate Pro',
                      style: AppStyles.heading2.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Smart Mess Management Solution',
                      style: AppStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppStyles.spaceXXLarge),

              /// APP INFO SECTION
              _SectionHeader(title: 'Application Info', icon: Icons.info_outline_rounded),
              ModernCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _AboutTile(
                      icon: Icons.code_rounded,
                      iconColor: AppColors.blue,
                      title: 'Developer',
                      value: 'Kh Faiaz Hasan',
                    ),
                    _Divider(),
                    _AboutTile(
                      icon: Icons.verified_user_outlined,
                      iconColor: AppColors.success,
                      title: 'Build Version',
                      value: 'v1.0.0 (Stable)',
                    ),
                    _Divider(),
                    _AboutTile(
                      icon: Icons.update_rounded,
                      iconColor: AppColors.orange,
                      title: 'Last Updated',
                      value: 'Feb 2026',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppStyles.spaceLarge),

              /// CONTACT & SOCIAL SECTION
              _SectionHeader(title: 'Connect with Us', icon: Icons.alternate_email_rounded),
              ModernCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _ActionTile(
                      icon: Icons.language_rounded,
                      iconColor: AppColors.purple,
                      title: 'Official Website',
                      subtitle: 'faiazis.live',
                      onTap: () {},
                    ),
                    _Divider(),
                    _ActionTile(
                      icon: Icons.email_outlined,
                      iconColor: AppColors.primary,
                      title: 'Support Email',
                      subtitle: 'support@messmate.pro',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppStyles.spaceLarge),

              /// LEGAL SECTION
              _SectionHeader(title: 'Legal', icon: Icons.gavel_rounded),
              ModernCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _ActionTile(
                      icon: Icons.description_outlined,
                      iconColor: AppColors.textSecondary,
                      title: 'Terms of Service',
                      subtitle: 'Read our usage terms',
                      onTap: () {},
                    ),
                    _Divider(),
                    _ActionTile(
                      icon: Icons.shield_outlined,
                      iconColor: AppColors.textSecondary,
                      title: 'Open Source Licenses',
                      subtitle: 'Third-party libraries used',
                      onTap: () {
                        showLicensePage(context: context);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppStyles.spaceXXLarge),

              Center(
                child: Column(
                  children: [
                    Text(
                      'Made with ❤️ in Bangladesh',
                      style: AppStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppStyles.spaceLarge),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Supporting UI Widgets (DNA Consistent) ---

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppStyles.spaceMedium, left: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: AppStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.textSecondary,
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;

  const _AboutTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: AppStyles.caption.copyWith(color: AppColors.textSecondary),
      ),
      subtitle: Text(
        value,
        style: AppStyles.bodyMedium.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        subtitle,
        style: AppStyles.caption.copyWith(color: AppColors.textSecondary),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 14,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 60,
      color: AppColors.border.withOpacity(0.2),
    );
  }
}