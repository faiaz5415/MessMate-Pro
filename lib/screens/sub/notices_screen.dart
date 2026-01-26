import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class NoticesScreen extends StatefulWidget {
  const NoticesScreen({super.key});

  @override
  State<NoticesScreen> createState() => _NoticesScreenState();
}

class _NoticesScreenState extends State<NoticesScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    /// ---------------- MOCK DATA ----------------
    final List<Map<String, dynamic>> notices = [
      {
        'id': 1,
        'title': 'Meal Rate Adjustment',
        'body': 'Starting next month, meal rate will be adjusted to ৳70 per meal due to market price increase. Please plan accordingly.',
        'author': 'Manager',
        'date': '2 hours ago',
        'isPinned': true,
        'isImportant': true,
        'category': 'Announcement',
      },
      {
        'id': 2,
        'title': 'Weekly Cleanup Schedule',
        'body': 'This week\'s cleanup duty: Monday - Karim, Tuesday - Rahim, Wednesday - You, Thursday - Salman, Friday - Jamal.',
        'author': 'Manager',
        'date': 'Yesterday',
        'isPinned': true,
        'isImportant': false,
        'category': 'Schedule',
      },
      {
        'id': 3,
        'title': 'Gas Cylinder Refill',
        'body': 'Gas cylinder will be refilled this Friday. Additional ৳50 will be added to everyone\'s cost share.',
        'author': 'Karim',
        'date': '2 days ago',
        'isPinned': false,
        'isImportant': false,
        'category': 'Update',
      },
      {
        'id': 4,
        'title': 'Weekend Guest Policy',
        'body': 'Reminder: If bringing guests on weekends, please inform manager 1 day before. Extra meal costs apply.',
        'author': 'Manager',
        'date': '3 days ago',
        'isPinned': false,
        'isImportant': false,
        'category': 'Policy',
      },
      {
        'id': 5,
        'title': 'Monthly Meeting',
        'body': 'Next monthly mess meeting scheduled for January 25th at 8 PM. Attendance is mandatory.',
        'author': 'Manager',
        'date': '4 days ago',
        'isPinned': false,
        'isImportant': true,
        'category': 'Event',
      },
    ];

    final filteredNotices = _selectedFilter == 'All'
        ? notices
        : notices.where((n) => n['category'] == _selectedFilter).toList();

    final pinnedNotices = filteredNotices.where((n) => n['isPinned'] == true).toList();
    final regularNotices = filteredNotices.where((n) => n['isPinned'] == false).toList();

    /// -------------------------------------------

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          children: [
            Text(
              'Notices',
              style: AppStyles.heading3.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              'Community Board',
              style: AppStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.blue.withOpacity(0.03),
              AppColors.background,
            ],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: AppStyles.spaceMedium),

              /// FILTER CHIPS
              _FilterChips(
                selectedFilter: _selectedFilter,
                onFilterChanged: (filter) {
                  setState(() => _selectedFilter = filter);
                },
              ),

              const SizedBox(height: AppStyles.spaceLarge),

              /// PINNED NOTICES SECTION
              if (pinnedNotices.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppStyles.spaceLarge,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.push_pin,
                        size: 16,
                        color: AppColors.warning,
                      ),
                      const SizedBox(width: AppStyles.spaceSmall),
                      Text(
                        'Pinned',
                        style: AppStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppStyles.spaceMedium),
                ...pinnedNotices.map((notice) => _NoticeCard(
                  notice: notice,
                  isPinned: true,
                )),
                const SizedBox(height: AppStyles.spaceLarge),
              ],

              /// RECENT NOTICES SECTION
              if (regularNotices.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppStyles.spaceLarge,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: AppStyles.spaceSmall),
                      Text(
                        'Recent',
                        style: AppStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppStyles.spaceMedium),
              ],

              /// NOTICES LIST
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    AppStyles.spaceLarge,
                    0,
                    AppStyles.spaceLarge,
                    AppStyles.spaceLarge,
                  ),
                  itemCount: regularNotices.length,
                  itemBuilder: (context, index) {
                    return _NoticeCard(
                      notice: regularNotices[index],
                      isPinned: false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add_rounded),
        label: const Text('Post Notice'),
        backgroundColor: AppColors.blue,
      ),
    );
  }
}

/// ------------------------------------------------------------
/// FILTER CHIPS
/// ------------------------------------------------------------
class _FilterChips extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const _FilterChips({
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = ['All', 'Announcement', 'Schedule', 'Update', 'Policy', 'Event'];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppStyles.spaceLarge),
        physics: const BouncingScrollPhysics(),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter == selectedFilter;

          return Container(
            margin: EdgeInsets.only(
              right: index < filters.length - 1 ? AppStyles.spaceSmall : 0,
            ),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (_) => onFilterChanged(filter),
              backgroundColor: AppColors.surface,
              selectedColor: AppColors.blue.withOpacity(0.15),
              checkmarkColor: AppColors.blue,
              labelStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.blue : AppColors.textSecondary,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.blue.withOpacity(0.3)
                      : AppColors.border,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// ------------------------------------------------------------
/// NOTICE CARD (Premium Community Board Style)
/// ------------------------------------------------------------
class _NoticeCard extends StatelessWidget {
  final Map<String, dynamic> notice;
  final bool isPinned;

  const _NoticeCard({
    required this.notice,
    required this.isPinned,
  });

  @override
  Widget build(BuildContext context) {
    final isImportant = notice['isImportant'] as bool;
    final accentColor = isImportant ? AppColors.warning : AppColors.blue;

    return ModernCard(
      margin: const EdgeInsets.only(bottom: AppStyles.spaceMedium),
      padding: const EdgeInsets.all(AppStyles.spaceMedium),
      color: isPinned
          ? AppColors.warning.withOpacity(0.03)
          : isImportant
          ? AppColors.warning.withOpacity(0.02)
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER ROW
          Row(
            children: [
              /// CATEGORY BADGE
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getCategoryIcon(notice['category']),
                      size: 12,
                      color: accentColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      notice['category'],
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: accentColor,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              /// PINNED INDICATOR
              if (isPinned)
                Icon(
                  Icons.push_pin,
                  size: 16,
                  color: AppColors.warning.withOpacity(0.6),
                ),
            ],
          ),

          const SizedBox(height: AppStyles.spaceMedium),

          /// TITLE
          Text(
            notice['title'],
            style: AppStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          ),

          const SizedBox(height: AppStyles.spaceSmall),

          /// BODY PREVIEW
          Text(
            notice['body'],
            style: AppStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: AppStyles.spaceMedium),

          /// FOOTER
          Row(
            children: [
              /// AUTHOR AVATAR + NAME
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    notice['author'][0],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: accentColor,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: AppStyles.spaceSmall),

              Text(
                notice['author'],
                style: AppStyles.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(width: AppStyles.spaceSmall),

              Container(
                width: 3,
                height: 3,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: AppStyles.spaceSmall),

              Text(
                notice['date'],
                style: AppStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),

              const Spacer(),

              /// READ MORE BUTTON
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Read',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: accentColor,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 12,
                        color: accentColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Announcement':
        return Icons.campaign_outlined;
      case 'Schedule':
        return Icons.calendar_today_outlined;
      case 'Update':
        return Icons.info_outline;
      case 'Policy':
        return Icons.gavel_outlined;
      case 'Event':
        return Icons.event_outlined;
      default:
        return Icons.article_outlined;
    }
  }
}
