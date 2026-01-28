import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import 'dining_select_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  int? _selectedRole;

  void _handleContinue() {
    if (_selectedRole == null) return;

    final bool isManager = _selectedRole == 0;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DiningSelectScreen(isManager: isManager),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Role'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppStyles.spaceLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// PROGRESS INDICATOR
              _StepIndicator(currentStep: 2, totalSteps: 3),

              const SizedBox(height: AppStyles.spaceXLarge),

              /// TITLE
              Text(
                'What\'s Your Role?',
                style: AppStyles.heading1.copyWith(fontSize: 28),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppStyles.spaceMedium),

              Text(
                'Choose whether you\'re managing a mess or joining one',
                style: AppStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppStyles.spaceXXLarge),

              /// MANAGER OPTION
              _RoleCard(
                icon: Icons.admin_panel_settings_outlined,
                title: 'I\'m a Manager',
                description: 'Create and manage your dining mess',
                color: AppColors.primary,
                isSelected: _selectedRole == 0,
                onTap: () => setState(() => _selectedRole = 0),
              ),

              const SizedBox(height: AppStyles.spaceMedium),

              /// MEMBER OPTION
              _RoleCard(
                icon: Icons.person_outline,
                title: 'I\'m a Member',
                description: 'Join an existing dining mess',
                color: AppColors.blue,
                isSelected: _selectedRole == 1,
                onTap: () => setState(() => _selectedRole = 1),
              ),

              const SizedBox(height: AppStyles.spaceXXLarge),

              /// CONTINUE BUTTON
              SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _selectedRole != null ? _handleContinue : null,
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: const Text('Continue'),
                  style: AppStyles.primaryButton.copyWith(
                    backgroundColor: MaterialStateProperty.resolveWith(
                          (states) {
                        if (states.contains(MaterialState.disabled)) {
                          return AppColors.border;
                        }
                        return _selectedRole == 0
                            ? AppColors.primary
                            : AppColors.blue;
                      },
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ROLE SELECTION CARD
class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppStyles.spaceLarge),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.08) : AppColors.surface,
          borderRadius: BorderRadius.circular(AppStyles.radiusLarge),
          border: Border.all(
            color: isSelected ? color : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ]
              : AppStyles.cardShadow,
        ),
        child: Row(
          children: [
            /// ICON
            Container(
              padding: const EdgeInsets.all(AppStyles.spaceMedium),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 32,
                color: color,
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
                    style: AppStyles.heading3.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isSelected ? color : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: AppStyles.spaceSmall),

            /// CHECK ICON
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? color : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? color : AppColors.border,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(
                Icons.check_rounded,
                size: 16,
                color: Colors.white,
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

/// STEP INDICATOR WIDGET
class _StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const _StepIndicator({
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Step $currentStep of $totalSteps',
          style: AppStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppStyles.spaceSmall),
        Row(
          children: List.generate(
            totalSteps,
                (index) => Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(
                  right: index < totalSteps - 1 ? AppStyles.spaceSmall : 0,
                ),
                decoration: BoxDecoration(
                  color: index < currentStep
                      ? AppColors.primary
                      : AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
