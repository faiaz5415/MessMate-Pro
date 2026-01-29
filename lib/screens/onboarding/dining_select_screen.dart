import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:confetti/confetti.dart';
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
  late ConfettiController _confettiController;
  late String _generatedCode;

  @override
  void initState() {
    super.initState();
    _generatedCode = _generateRandomCode();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }

  String _generateRandomCode() {
    var rng = Random();
    return (100000 + rng.nextInt(900000)).toString();
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _generatedCode));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Dining code copied to clipboard!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _diningNameController.dispose();
    _diningCodeController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _handleCreateDining() {
    if (!_formKey.currentState!.validate()) return;

    CommonDialogs.showConfirmation(
      context: context,
      title: 'Create Dining Mess?',
      message: 'You will be the manager of "${_diningNameController.text}"\nDining Code: $_generatedCode',
      confirmText: 'Create',
      onConfirm: () async {
        _confettiController.play();

        await Future.delayed(const Duration(seconds: 1));

        if (!mounted) return;
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
    if (value == null || value.isEmpty) return 'Please enter dining mess name';
    return null;
  }

  String? _validateDiningCode(String? value) {
    if (value == null || value.isEmpty) return 'Please enter dining code';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                    _StepIndicator(currentStep: 3, totalSteps: 3),
                    const SizedBox(height: AppStyles.spaceXLarge),

                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(AppStyles.spaceLarge),
                        decoration: BoxDecoration(
                          color: (widget.isManager ? AppColors.primary : AppColors.blue).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.isManager ? Icons.add_business_outlined : Icons.login_outlined,
                          size: 56,
                          color: widget.isManager ? AppColors.primary : AppColors.blue,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppStyles.spaceLarge),
                    Text(
                      widget.isManager ? 'Create Your Dining Mess' : 'Join Existing Mess',
                      style: AppStyles.heading2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppStyles.spaceSmall),
                    Text(
                      widget.isManager ? 'Set up your mess and invite members' : 'Enter the code provided by your manager',
                      style: AppStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppStyles.spaceXXLarge),

                    if (widget.isManager) ...[
                      ModernCard(
                        color: AppColors.primary.withOpacity(0.08),
                        padding: const EdgeInsets.all(AppStyles.spaceMedium),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.pin_outlined, color: AppColors.primary, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      'UNIQUE DINING CODE',
                                      style: AppStyles.bodySmall.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: _copyToClipboard,
                                  icon: const Icon(Icons.copy_rounded, size: 20),
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _generatedCode,
                                  style: AppStyles.heading1.copyWith(
                                    color: AppColors.primary,
                                    letterSpacing: 8,
                                    fontSize: 32,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Icon(Icons.qr_code_scanner_rounded, color: AppColors.primary.withOpacity(0.5)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppStyles.spaceLarge),
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
                      ModernCard(
                        color: AppColors.info.withOpacity(0.05),
                        padding: const EdgeInsets.all(AppStyles.spaceMedium),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.info_outline, color: AppColors.info, size: 20),
                            const SizedBox(width: AppStyles.spaceMedium),
                            Expanded(
                              child: Text(
                                'Share this code with your friends to let them join',
                                style: AppStyles.bodySmall.copyWith(color: AppColors.info),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
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
                      ModernCard(
                        color: AppColors.warning.withOpacity(0.05),
                        padding: const EdgeInsets.all(AppStyles.spaceMedium),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.warning_amber_outlined, color: AppColors.warning, size: 20),
                            const SizedBox(width: AppStyles.spaceMedium),
                            Expanded(
                              child: Text(
                                'Your request will need manager approval',
                                style: AppStyles.bodySmall.copyWith(color: AppColors.warning),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: AppStyles.spaceXLarge),
                    SizedBox(
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: widget.isManager ? _handleCreateDining : _handleJoinDining,
                        icon: Icon(widget.isManager ? Icons.add_rounded : Icons.send_rounded),
                        label: Text(widget.isManager ? 'Create Dining' : 'Send Request'),
                        style: AppStyles.primaryButton.copyWith(
                          backgroundColor: MaterialStateProperty.all(
                            widget.isManager ? AppColors.primary : AppColors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
          ),
        ),
      ],
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  const _StepIndicator({required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Step $currentStep of $totalSteps',
          style: AppStyles.bodySmall.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppStyles.spaceSmall),
        Row(
          children: List.generate(
            totalSteps,
                (index) => Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(right: index < totalSteps - 1 ? AppStyles.spaceSmall : 0),
                decoration: BoxDecoration(
                  color: index < currentStep ? AppColors.primary : AppColors.border,
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