import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';
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
  final _diningKeyController = TextEditingController();

  @override
  void dispose() {
    _diningKeyController.dispose();
    super.dispose();
  }

  String _generateDiningKey() {
    final rand = Random();
    return (100000 + rand.nextInt(900000)).toString();
  }

  void _showCreateDiningDialog(BuildContext context) {
    final nameController = TextEditingController();
    final monthController = TextEditingController();
    final diningKey = _generateDiningKey();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
          ),
          title: Text(
            'Create Your Dining',
            style: AppStyles.heading3,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: nameController,
                  decoration: AppStyles.inputDecoration(
                    labelText: 'Dining Name',
                    hintText: 'e.g. Green House Mess',
                  ),
                ),

                const SizedBox(height: AppStyles.spaceMedium),

                TextField(
                  controller: monthController,
                  decoration: AppStyles.inputDecoration(
                    labelText: 'Month',
                    hintText: 'e.g. January 2026',
                  ),
                ),

                const SizedBox(height: AppStyles.spaceLarge),

                ModernCard(
                  color: AppColors.primary.withOpacity(0.05),
                  padding: const EdgeInsets.all(AppStyles.spaceMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dining Key',
                        style: AppStyles.caption.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppStyles.spaceSmall),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              diningKey,
                              style: AppStyles.heading3.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy),
                            color: AppColors.primary,
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(text: diningKey),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Dining key copied!'),
                                  backgroundColor: AppColors.success,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppStyles.radiusMedium,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: AppStyles.spaceSmall),
                      Text(
                        'Share this key with your mess members',
                        style: AppStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MainShell(),
                  ),
                      (route) => false,
                );
              },
              child: const Text('Create Dining'),
            ),
          ],
        );
      },
    );
  }

  void _joinDining() {
    if (_diningKeyController.text.length == 6) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const JoinStatusScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a valid 6-digit key'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dining Setup'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppStyles.spaceLarge),
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
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.isManager
                        ? Icons.add_business_outlined
                        : Icons.groups_outlined,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),
              ),

              const SizedBox(height: AppStyles.spaceLarge),

              Text(
                widget.isManager
                    ? 'Create Your Dining'
                    : 'Join a Dining',
                style: AppStyles.heading2,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppStyles.spaceSmall),

              Text(
                widget.isManager
                    ? 'Set up a new mess for your group'
                    : 'Enter the 6-digit key shared by your manager',
                style: AppStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppStyles.spaceXLarge),

              if (widget.isManager)
                ElevatedButton.icon(
                  onPressed: () => _showCreateDiningDialog(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Create New Dining'),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _diningKeyController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      textAlign: TextAlign.center,
                      style: AppStyles.heading2,
                      decoration: AppStyles.inputDecoration(
                        labelText: 'Dining Key',
                        hintText: '000000',
                        prefixIcon: const Icon(Icons.vpn_key_outlined),
                      ),
                    ),

                    const SizedBox(height: AppStyles.spaceLarge),

                    ElevatedButton(
                      onPressed: _joinDining,
                      child: const Text('Request to Join'),
                    ),
                  ],
                ),
            ],
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
