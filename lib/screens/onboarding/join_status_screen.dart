import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class JoinStatusScreen extends StatelessWidget {
  const JoinStatusScreen({super.key});

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

              /// ICON
              Center(
                child: Container(
                  padding: const EdgeInsets.all(AppStyles.spaceLarge),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.schedule_outlined,
                    size: 64,
                    color: AppColors.warning,
                  ),
                ),
              ),

              const SizedBox(height: AppStyles.spaceLarge),

              Text(
                'Waiting for Approval',
                style: AppStyles.heading2,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppStyles.spaceMedium),

              Text(
                'Your request has been sent to the manager.\nYou will be notified once approved.',
                style: AppStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppStyles.spaceXLarge),

              ModernCard(
                color: AppColors.info.withOpacity(0.05),
                padding: const EdgeInsets.all(AppStyles.spaceMedium),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.info,
                      size: 20,
                    ),
                    const SizedBox(width: AppStyles.spaceMedium),
                    Expanded(
                      child: Text(
                        'This usually takes a few minutes',
                        style: AppStyles.bodySmall.copyWith(
                          color: AppColors.info,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Go Back'),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.border),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppStyles.radiusMedium,
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
