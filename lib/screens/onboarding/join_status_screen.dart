import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class JoinStatusScreen extends StatelessWidget {
  const JoinStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.warning.withOpacity(0.05),
              AppColors.background,
            ],
            stops: const [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppStyles.spaceLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),

                /// ANIMATED ICON
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.warning,
                          AppColors.warning.withOpacity(0.7),
                        ],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.warning.withOpacity(0.3),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.schedule_outlined,
                      size: 56,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: AppStyles.spaceXLarge),

                /// TITLE
                Text(
                  'Waiting for Approval',
                  style: AppStyles.heading1.copyWith(
                    fontSize: 28,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppStyles.spaceMedium),

                /// DESCRIPTION
                Text(
                  'Your request has been sent to the manager.\nYou will be notified once approved.',
                  style: AppStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppStyles.spaceXLarge),

                /// STATUS CARD
                ModernCard(
                  color: AppColors.warning.withOpacity(0.05),
                  padding: const EdgeInsets.all(AppStyles.spaceMedium),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.warning.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.pending_actions_outlined,
                              color: AppColors.warning,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: AppStyles.spaceMedium),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Request Status',
                                  style: AppStyles.bodySmall.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.warning,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Pending approval from manager',
                                  style: AppStyles.caption.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppStyles.spaceMedium),
                      Container(
                        height: 1,
                        color: AppColors.border,
                      ),
                      const SizedBox(height: AppStyles.spaceMedium),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'This usually takes a few minutes',
                            style: AppStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppStyles.spaceMedium),

                /// INFO TIPS
                ModernCard(
                  color: AppColors.info.withOpacity(0.05),
                  padding: const EdgeInsets.all(AppStyles.spaceMedium),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: AppColors.info,
                        size: 20,
                      ),
                      const SizedBox(width: AppStyles.spaceMedium),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'What happens next?',
                              style: AppStyles.bodySmall.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.info,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '• Manager will review your request\n'
                                  '• You\'ll receive a notification\n'
                                  '• You can start using the app',
                              style: AppStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                /// BACK BUTTON
                OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text('Go Back'),
                  style: AppStyles.secondaryButton.copyWith(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 16),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppStyles.spaceMedium),

                /// CANCEL REQUEST BUTTON
                TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppStyles.radiusMedium,
                          ),
                        ),
                        title: Text(
                          'Cancel Request?',
                          style: AppStyles.heading3,
                        ),
                        content: Text(
                          'Are you sure you want to cancel this join request?',
                          style: AppStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('No, Keep It'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.error,
                            ),
                            child: const Text('Yes, Cancel'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    color: AppColors.error,
                  ),
                  label: Text(
                    'Cancel Request',
                    style: TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
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
