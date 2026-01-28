import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';
import '../../widgets/common_dialogs.dart';
import '../main/main_shell.dart';
import 'join_status_screen.dart';

class DiningSelectScreen extends StatefulWidget {
  final bool isManager;

  const DiningSelectScreen({
    super.key,
    required this.isManager,
  });

  @override
  State<DiningSelectScreen> createState() => _DiningSelectScreenState();
}

class _DiningSelectScreenState extends State<DiningSelectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _diningNameController = TextEditingController();
  final _diningCodeController = TextEditingController();

  @override
  void dispose() {
    _diningNameController.dispose();
    _diningCodeController.dispose();
    super.dispose();
  }

  void _handleCreateDining() {
    if (!_formKey.currentState!.validate()) return;

    CommonDialogs.showConfirmation(
      context: context,
      title: 'Create Dining Mess?',
      message: 'You will be the manager of "${_diningNameController.text}"',
      confirmText: 'Create',
      onConfirm: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainShell()),
              (route) => false,
        );
      },
    );
  }

  void _handleJoinDining() {
    if (!_formKey.currentState!.validate()) return;

    CommonDialogs.showConfirmation(
      context: context,
      title: 'Join Dining Mess?',
      message: 'Send request to join this mess?',
      confirmText: 'Join',
      onConfirm: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const JoinStatusScreen()),
        );
      },
    );
  }

  String? _validateDiningName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter dining mess name';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? _validateDiningCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter dining code';
    }
    if (value.length < 6) {
      return 'Code must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isManager ? 'Create Dining' : 'Join Dining'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppStyles.spaceLarge),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// PROGRESS INDICATOR
                _StepIndicator(currentStep: 3, totalSteps: 3),

                const SizedBox(height: AppStyles.spaceXLarge),

                /// ICON
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(AppStyles.spaceLarge),
                    decoration: BoxDecoration(
                      color: (widget.isManager
                          ? AppColors.primary
                          : AppColors.blue)
                          .withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.isManager
                          ? Icons.add_business_outlined
                          : Icons.login_outlined,
                      size: 56,
                      color:
                      widget.isManager ? AppColors.primary : AppColors.blue,
                    ),
                  ),
                ),

                const SizedBox(height: AppStyles.spaceLarge),

                /// TITLE
                Text(
                  widget.isManager
                      ? 'Create Your Dining Mess'
                      : 'Join Existing Mess',
                  style: AppStyles.heading2,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppStyles.spaceSmall),

                Text(
                  widget.isManager
                      ? 'Set up your mess and invite members'
                      : 'Enter the code provided by your manager',
                  style: AppStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppStyles.spaceXXLarge),

                if (widget.isManager) ...[
                  /// DINING NAME INPUT (MANAGER)
                  TextFormField(
                    controller: _diningNameController,
                    validator: _validateDiningName,
                    decoration: AppStyles.inputDecoration(
                      labelText: 'Dining Mess Name',
                      hintText: 'e.g., Sunrise Mess',
                      prefixIcon: const Icon(Icons.restaurant_outlined),
                    ),
                  ),

                  const SizedBox(height: AppStyles.spaceMedium),

                  /// INFO CARD
                  ModernCard(
                    color: AppColors.info.withOpacity(0.05),
                    padding: const EdgeInsets.all(AppStyles.spaceMedium),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.info,
                          size: 20,
                        ),
                        const SizedBox(width: AppStyles.spaceMedium),
                        Expanded(
                          child: Text(
                            'You can add members later from settings',
                            style: AppStyles.bodySmall.copyWith(
                              color: AppColors.info,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  /// DINING CODE INPUT (MEMBER)
                  TextFormField(
                    controller: _diningCodeController,
                    validator: _validateDiningCode,
                    decoration: AppStyles.inputDecoration(
                      labelText: 'Dining Code',
                      hintText: 'Enter 6-digit code',
                      prefixIcon: const Icon(Icons.qr_code_outlined),
                    ),
                  ),

                  const SizedBox(height: AppStyles.spaceMedium),

                  /// INFO CARD
                  ModernCard(
                    color: AppColors.warning.withOpacity(0.05),
                    padding: const EdgeInsets.all(AppStyles.spaceMedium),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.warning_amber_outlined,
                          color: AppColors.warning,
                          size: 20,
                        ),
                        const SizedBox(width: AppStyles.spaceMedium),
                        Expanded(
                          child: Text(
                            'Your request will need manager approval',
                            style: AppStyles.bodySmall.copyWith(
                              color: AppColors.warning,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: AppStyles.spaceXLarge),

                /// ACTION BUTTON
                SizedBox(
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: widget.isManager
                        ? _handleCreateDining
                        : _handleJoinDining,
                    icon: Icon(
                      widget.isManager ? Icons.add_rounded : Icons.send_rounded,
                    ),
                    label: Text(
                      widget.isManager ? 'Create Dining' : 'Send Request',
                    ),
                    style: AppStyles.primaryButton.copyWith(
                      backgroundColor: MaterialStateProperty.all(
                        widget.isManager ? AppColors.primary : AppColors.blue,
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
