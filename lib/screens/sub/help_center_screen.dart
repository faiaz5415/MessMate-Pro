import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  int? _expandedIndex;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _helpCategories = [
    {
      'icon': Icons.book_outlined,
      'title': 'Getting Started',
      'color': AppColors.primary,
      'description': 'Learn the basics',
      'count': 5,
    },
    {
      'icon': Icons.restaurant_menu_outlined,
      'title': 'Managing Meals',
      'color': AppColors.blue,
      'description': 'Meal tracking & updates',
      'count': 8,
    },
    {
      'icon': Icons.payments_outlined,
      'title': 'Payments & Deposits',
      'color': AppColors.success,
      'description': 'Financial operations',
      'count': 6,
    },
    {
      'icon': Icons.people_outline,
      'title': 'Member Management',
      'color': AppColors.orange,
      'description': 'Add, remove & manage',
      'count': 4,
    },
  ];

  final List<Map<String, String>> _faqs = [
    {
      'question': 'How do I create a new mess?',
      'answer':
      'As a manager, navigate to the mess creation screen from the dashboard. Fill in the required details like mess name, location, and initial settings. You can then invite members using their email or phone numbers.',
    },
    {
      'question': 'How to add meals for members?',
      'answer':
      'Go to the Meals section, select the date, and tap on the member you want to add meals for. Enter the number of meals and save. Changes are reflected immediately.',
    },
    {
      'question': 'What happens when I lock the month?',
      'answer':
      'Locking the month prevents any further meal additions or modifications for that period. It finalizes the calculations and generates bills for all members. Only managers can lock or unlock months.',
    },
    {
      'question': 'How to record a deposit?',
      'answer':
      'Navigate to the Deposits section, select the member, enter the amount, add an optional note, and save. The deposit is instantly added to the member\'s balance.',
    },
    {
      'question': 'Can I edit bazar entries after adding?',
      'answer':
      'Yes, managers can edit bazar entries before the month is locked. Go to Bazar History, tap on the entry you want to edit, make changes, and save.',
    },
    {
      'question': 'How do meal rates work?',
      'answer':
      'Meal rate is calculated by dividing total bazar cost by total meals consumed. It updates automatically as new bazars and meals are added. You can view current rate on the dashboard.',
    },
    {
      'question': 'What if a member leaves mid-month?',
      'answer':
      'Calculate their dues up to their last meal date, settle the amount, and then remove them from the mess. Their historical data remains accessible for records.',
    },
    {
      'question': 'How to generate monthly reports?',
      'answer':
      'After locking the month, go to Reports section. Select the month and choose your preferred format (PDF/Excel). The report includes all transactions, meals, and calculations.',
    },
  ];

  List<Map<String, String>> get _filteredFAQs {
    if (_searchQuery.isEmpty) return _faqs;
    return _faqs
        .where((faq) =>
    faq['question']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        faq['answer']!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          children: [
            Text(
              'Help Center',
              style: AppStyles.heading3.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              'We\'re here to help',
              style: AppStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.03),
              AppColors.background,
            ],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(AppStyles.spaceLarge),
            children: [
              /// SEARCH BAR
              _SearchBar(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
              ),

              const SizedBox(height: AppStyles.spaceLarge),

              /// QUICK ACTIONS
              _QuickActions(),

              const SizedBox(height: AppStyles.spaceLarge),

              /// HELP CATEGORIES
              _SectionTitle(title: 'Browse by Category'),
              const SizedBox(height: AppStyles.spaceMedium),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppStyles.spaceMedium,
                  crossAxisSpacing: AppStyles.spaceMedium,
                  childAspectRatio: 1.1,
                ),
                itemCount: _helpCategories.length,
                itemBuilder: (context, index) {
                  final category = _helpCategories[index];
                  return _CategoryCard(category: category);
                },
              ),

              const SizedBox(height: AppStyles.spaceXLarge),

              /// FAQs
              _SectionTitle(
                title: 'Frequently Asked Questions',
                subtitle: '${_filteredFAQs.length} articles',
              ),
              const SizedBox(height: AppStyles.spaceMedium),

              if (_filteredFAQs.isEmpty)
                _EmptySearchResult()
              else
                ..._filteredFAQs.asMap().entries.map((entry) {
                  final index = entry.key;
                  final faq = entry.value;
                  return _FAQCard(
                    question: faq['question']!,
                    answer: faq['answer']!,
                    isExpanded: _expandedIndex == index,
                    onTap: () => setState(() {
                      _expandedIndex = _expandedIndex == index ? null : index;
                    }),
                  );
                }),

              const SizedBox(height: AppStyles.spaceXLarge),

              /// CONTACT SUPPORT
              _ContactSupportCard(),

              const SizedBox(height: AppStyles.spaceMedium),
            ],
          ),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// SEARCH BAR
/// ------------------------------------------------------------
class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search for help...',
          hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.6)),
          prefixIcon: Icon(Icons.search_rounded, color: AppColors.primary),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear_rounded),
            onPressed: () {
              controller.clear();
              onChanged('');
            },
          )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppStyles.spaceMedium,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// QUICK ACTIONS
/// ------------------------------------------------------------
class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionButton(
            icon: Icons.video_library_outlined,
            label: 'Video Tutorials',
            color: AppColors.error,
            onTap: () {},
          ),
        ),
        const SizedBox(width: AppStyles.spaceMedium),
        Expanded(
          child: _QuickActionButton(
            icon: Icons.chat_bubble_outline,
            label: 'Live Chat',
            color: AppColors.success,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
        horizontal: AppStyles.spaceMedium,
        vertical: AppStyles.spaceMedium,
      ),
      color: color.withOpacity(0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: AppStyles.spaceSmall),
          Text(
            label,
            style: AppStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// SECTION TITLE
/// ------------------------------------------------------------
class _SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _SectionTitle({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.heading3.copyWith(fontWeight: FontWeight.w800),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: AppStyles.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ],
    );
  }
}

/// ------------------------------------------------------------
/// CATEGORY CARD
/// ------------------------------------------------------------
class _CategoryCard extends StatelessWidget {
  final Map<String, dynamic> category;

  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      onTap: () {},
      padding: const EdgeInsets.all(AppStyles.spaceMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (category['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              category['icon'],
              color: category['color'],
              size: 28,
            ),
          ),
          const SizedBox(height: AppStyles.spaceMedium),
          Text(
            category['title'],
            style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '${category['count']} articles',
            style: AppStyles.caption.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// FAQ CARD
/// ------------------------------------------------------------
class _FAQCard extends StatelessWidget {
  final String question;
  final String answer;
  final bool isExpanded;
  final VoidCallback onTap;

  const _FAQCard({
    required this.question,
    required this.answer,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppStyles.spaceMedium),
      margin: const EdgeInsets.only(bottom: AppStyles.spaceSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  question,
                  style: AppStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              AnimatedRotation(
                turns: isExpanded ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: AppStyles.spaceMedium),
              child: Text(
                answer,
                style: AppStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// EMPTY SEARCH RESULT
/// ------------------------------------------------------------
class _EmptySearchResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModernCard(
      padding: const EdgeInsets.all(AppStyles.spaceXLarge),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: AppColors.textSecondary.withOpacity(0.3),
          ),
          const SizedBox(height: AppStyles.spaceMedium),
          Text(
            'No results found',
            style: AppStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppStyles.spaceSmall),
          Text(
            'Try different keywords',
            style: AppStyles.bodySmall.copyWith(
              color: AppColors.textSecondary.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// CONTACT SUPPORT CARD
/// ------------------------------------------------------------
class _ContactSupportCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModernCard(
      color: AppColors.primary.withOpacity(0.05),
      padding: const EdgeInsets.all(AppStyles.spaceLarge),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppStyles.spaceMedium),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.support_agent_rounded,
              size: 40,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppStyles.spaceMedium),
          Text(
            'Still Need Help?',
            style: AppStyles.heading3.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppStyles.spaceSmall),
          Text(
            'Our support team is ready to assist you',
            style: AppStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppStyles.spaceLarge),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.email_outlined, size: 18),
                  label: const Text('Email Us'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppStyles.spaceMedium),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.phone_outlined, size: 18),
                  label: const Text('Call Now'),
                  style: AppStyles.primaryButton.copyWith(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
