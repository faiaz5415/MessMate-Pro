import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _darkMode = false;
  bool _autoBackup = true;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'BDT (৳)';

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
              'App Settings',
              style: AppStyles.heading3.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              'Preferences & Controls',
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
              const SizedBox(height: AppStyles.spaceMedium),

              /// NOTIFICATIONS SECTION
              _SectionHeader(title: 'Notifications', icon: Icons.notifications_none_rounded),
              ModernCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _SwitchTile(
                      icon: Icons.notifications_outlined,
                      iconColor: AppColors.blue,
                      title: 'Notifications',
                      subtitle: 'All app alerts',
                      value: _notificationsEnabled,
                      onChanged: (value) => setState(() => _notificationsEnabled = value),
                    ),
                    _Divider(),
                    _SwitchTile(
                      icon: Icons.notifications_active_outlined,
                      iconColor: AppColors.primary,
                      title: 'Push Notifications',
                      subtitle: 'Real-time updates',
                      value: _pushNotifications,
                      enabled: _notificationsEnabled,
                      onChanged: (value) => setState(() => _pushNotifications = value),
                    ),
                    _Divider(),
                    _SwitchTile(
                      icon: Icons.email_outlined,
                      iconColor: AppColors.orange,
                      title: 'Email Notifications',
                      subtitle: 'Weekly summaries',
                      value: _emailNotifications,
                      enabled: _notificationsEnabled,
                      onChanged: (value) => setState(() => _emailNotifications = value),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppStyles.spaceLarge),

              /// APPEARANCE SECTION
              _SectionHeader(title: 'Appearance', icon: Icons.palette_outlined),
              ModernCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _SwitchTile(
                      icon: Icons.center_focus_strong_outlined,
                      iconColor: AppColors.purple,
                      title: 'Reading Mode',
                      subtitle: 'Reduce eye strain',
                      value: _darkMode,
                      onChanged: (value) => setState(() => _darkMode = value),
                    ),
                    _Divider(),
                    _SelectionTile(
                      icon: Icons.language_outlined,
                      iconColor: AppColors.blue,
                      title: 'Language',
                      subtitle: _selectedLanguage,
                      onTap: () => _showLanguageDialog(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppStyles.spaceLarge),

              /// DATA & BACKUP SECTION
              _SectionHeader(title: 'Data Management', icon: Icons.storage_rounded),
              ModernCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _SwitchTile(
                      icon: Icons.backup_outlined,
                      iconColor: AppColors.success,
                      title: 'Auto Backup',
                      subtitle: 'Cloud synchronization',
                      value: _autoBackup,
                      onChanged: (value) => setState(() => _autoBackup = value),
                    ),
                    _Divider(),
                    _ActionTile(
                      icon: Icons.cloud_upload_outlined,
                      iconColor: AppColors.blue,
                      title: 'Backup Now',
                      subtitle: 'Last sync: 2h ago',
                      onTap: () => _showSnackBar('Backup started...'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppStyles.spaceLarge),

              /// ABOUT SECTION
              _SectionHeader(title: 'Other', icon: Icons.more_horiz_rounded),
              ModernCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _SelectionTile(
                      icon: Icons.payments_outlined,
                      iconColor: AppColors.success,
                      title: 'Currency',
                      subtitle: _selectedCurrency,
                      onTap: () => _showCurrencyDialog(),
                    ),
                    _Divider(),
                    _ActionTile(
                      icon: Icons.privacy_tip_outlined,
                      iconColor: AppColors.purple,
                      title: 'Privacy Policy',
                      subtitle: 'Data usage terms',
                      onTap: () {},
                    ),
                    _Divider(),
                    _ActionTile(
                      icon: Icons.delete_outline,
                      iconColor: AppColors.error,
                      title: 'Clear Cache',
                      subtitle: 'Delete temporary data',
                      onTap: () => _showClearDataDialog(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppStyles.spaceXXLarge),

              Center(
                child: Text(
                  'Version 1.0.0',
                  style: AppStyles.caption.copyWith(color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: AppStyles.spaceLarge),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Dialogs ---
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.radiusMedium)),
        title: Text('Select Language', style: AppStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('English'),
              value: 'English',
              groupValue: _selectedLanguage,
              activeColor: AppColors.blue,
              onChanged: (v) { setState(() => _selectedLanguage = v!); Navigator.pop(context); },
            ),
            RadioListTile<String>(
              title: const Text('বাংলা'),
              value: 'বাংলা',
              groupValue: _selectedLanguage,
              activeColor: AppColors.blue,
              onChanged: (v) { setState(() => _selectedLanguage = v!); Navigator.pop(context); },
            ),
          ],
        ),
      ),
    );
  }

  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.radiusMedium)),
        title: Text('Select Currency', style: AppStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(title: const Text('BDT (৳)'), value: 'BDT (৳)', groupValue: _selectedCurrency, activeColor: AppColors.success, onChanged: (v) { setState(() => _selectedCurrency = v!); Navigator.pop(context); }),
            RadioListTile<String>(title: const Text('USD (\$)'), value: 'USD (\$)', groupValue: _selectedCurrency, activeColor: AppColors.success, onChanged: (v) { setState(() => _selectedCurrency = v!); Navigator.pop(context); }),
          ],
        ),
      ),
    );
  }

  void _showClearDataDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.radiusMedium)),
        title: const Text('Clear Cache?'),
        content: const Text('This will delete temporary local data.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () { Navigator.pop(context); _showSnackBar('Cache cleared!'); }, child: const Text('Clear', style: TextStyle(color: AppColors.error))),
        ],
      ),
    );
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }
}

// --- Supporting UI Widgets ---

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppStyles.spaceMedium),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.blue),
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

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool value;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({required this.icon, required this.iconColor, required this.title, required this.subtitle, required this.value, required this.onChanged, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(title, style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700, color: enabled ? AppColors.textPrimary : AppColors.textSecondary)),
      subtitle: Text(subtitle, style: AppStyles.caption.copyWith(color: AppColors.textSecondary)),
      trailing: Switch.adaptive(
        value: value,
        onChanged: enabled ? onChanged : null,
        activeColor: iconColor,
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _ActionTile({required this.icon, required this.iconColor, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(title, style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle, style: AppStyles.caption.copyWith(color: AppColors.textSecondary)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
}

class _SelectionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SelectionTile({required this.icon, required this.iconColor, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(title, style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle, style: AppStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, thickness: 1, indent: 60, color: AppColors.border.withOpacity(0.2));
  }
}