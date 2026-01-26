import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class NoticesScreen extends StatelessWidget {
  const NoticesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// ---------------- MOCK DATA ----------------
    final List<Map<String, dynamic>> notices = [
      {
        'title': 'Meal Rate Updated',
        'content': 'New meal rate is ৳65 per meal starting from tomorrow.',
        'date': '22 Jan 2026',
        'isImportant': true,
      },
      {
        'title': 'Weekly Bazar Schedule',
        'content': 'This week\'s bazar will be on Monday and Thursday.',
        'date': '20 Jan 2026',
        'isImportant': false,
      },
      {
        'title': 'Deposit Reminder',
        'content': 'Please submit your monthly deposit by 25th Jan.',
        'date': '18 Jan 2026',
        'isImportant': true,
      },
      {
        'title': 'Guest Meal Policy',
        'content': 'Guest meals must be informed 1 day in advance.',
        'date': '15 Jan 2026',
        'isImportant': false,
      },
    ];

    /// -------------------------------------------

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notices'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppStyles.spaceMedium),
        itemCount: notices.length,
        itemBuilder: (context, index) {
          final notice = notices[index];
          return _NoticeCard(
            title: notice['title'],
            content: notice['content'],
            date: notice['date'],
            isImportant: notice['isImportant'],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add notice (manager only)
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Notice'),
      ),
    );
  }
}

/// NOTICE CARD
class _NoticeCard extends StatelessWidget {
  final String title;
  final String content;
  final String date;
  final bool isImportant;

  const _NoticeCard({
    required this.title,
    required this.content,
    required this.date,
    required this.isImportant,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      margin: const EdgeInsets.only(bottom: AppStyles.spaceMedium),
      padding: const EdgeInsets.all(AppStyles.spaceMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isImportant) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppStyles.spaceSmall,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.priority_high,
                        color: AppColors.error,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Important',
                        style: AppStyles.caption.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppStyles.spaceSmall),
              ],
              Expanded(
                child: Text(
                  title,
                  style: AppStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppStyles.spaceSmall),

          Text(
            content,
            style: AppStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: AppStyles.spaceMedium),

          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppStyles.spaceXSmall),
              Text(
                date,
                style: AppStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
