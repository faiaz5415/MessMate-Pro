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
                'We\'ve sent a password reset link to your email address.\nPlease check your inbox and follow the instructions.',
                style: AppStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppStyles.spaceXLarge),

              /// INFO CARD
              Container(
                padding: const EdgeInsets.all(AppStyles.spaceMedium),
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
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
                            'Didn\'t receive the email?',
                            style: AppStyles.bodySmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.info,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Check your spam folder or wait a few minutes',
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

              const Spacer(),

              /// BACK TO LOGIN BUTTON
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

              /// RESEND BUTTON
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Reset link sent again!'),
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
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Resend Email'),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.border),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
