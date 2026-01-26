import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import 'sign_in_screen.dart';

class ForgotPasswordConfirmationScreen extends StatelessWidget {
  const ForgotPasswordConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppStyles.spaceLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              /// SUCCESS ICON
              Center(
                child: Container(
                  padding: const EdgeInsets.all(AppStyles.spaceLarge),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.mark_email_read_outlined,
                    size: 64,
                    color: AppColors.success,
                  ),
                ),
              ),

              const SizedBox(height: AppStyles.spaceLarge),

              Text(
                'Check Your Email',
                style: AppStyles.heading2,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppStyles.spaceMedium),

              Text(
                'We\'ve sent a password reset link to your email. Please check your inbox and follow the instructions.',
                style: AppStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              /// BACK TO SIGN IN
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SignInScreen(),
                    ),
                        (route) => false,
                  );
                },
                child: const Text('Back to Sign In'),
              ),

              const SizedBox(height: AppStyles.spaceMedium),
            ],
          ),
        ),
      ),
    );
  }
}
