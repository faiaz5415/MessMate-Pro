import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/loading_overlay.dart';
import 'forgot_password_confirmation_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() => _isLoading = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ForgotPasswordConfirmationScreen(),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(AppStyles.spaceXLarge),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                        Icons.lock_reset_outlined,
                        size: 56,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppStyles.spaceXLarge),

                  /// TITLE
                  Text(
                    'Forgot Password?',
                    style: AppStyles.heading1.copyWith(
                      fontSize: 28,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppStyles.spaceMedium),

                  /// SUBTITLE
                  Text(
                    'Enter your email address and we\'ll send you a link to reset your password.',
                    style: AppStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppStyles.spaceXXLarge),

                  /// EMAIL INPUT
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                    decoration: AppStyles.inputDecoration(
                      labelText: 'Email Address',
                      hintText: 'your.email@example.com',
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                  ),

                  const SizedBox(height: AppStyles.spaceXLarge),

                  /// SEND RESET LINK BUTTON
                  SizedBox(
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: _handleResetPassword,
                      icon: const Icon(Icons.send_rounded),
                      label: const Text('Send Reset Link'),
                      style: AppStyles.primaryButton.copyWith(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppStyles.spaceXLarge),

                  /// INFO CARD
                  Container(
                    padding: const EdgeInsets.all(AppStyles.spaceMedium),
                    decoration: BoxDecoration(
                      color: AppColors.info.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(
                        AppStyles.radiusMedium,
                      ),
                      border: Border.all(
                        color: AppColors.info.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email not received?',
                                style: AppStyles.bodySmall.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.info,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Check your spam folder or ensure the email is correct',
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

                  const SizedBox(height: AppStyles.spaceXXLarge),

                  /// BACK TO SIGN IN
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Remember your password? ',
                        style: AppStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          'Sign In',
                          style: AppStyles.bodyMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
