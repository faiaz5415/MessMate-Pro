import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// ---------------- MOCK DATA ----------------
    final List<Map<String, dynamic>> members = [
      {
        'name': 'Ahmed Khan',
        'role': 'Manager',
        'totalMeals': 45,
        'balance': -120.0,
        'isActive': true,
      },
      {
        'name': 'Rafiq Islam',
        'role': 'Member',
        'totalMeals': 38,
        'balance': 50.0,
        'isActive': true,
      },
      {
        'name': 'Kamal Hossain',
        'role': 'Member',
        'totalMeals': 42,
        'balance': -80.0,
        'isActive': true,
      },
      {
        'name': 'Jamal Ahmed',
        'role': 'Member',
        'totalMeals': 40,
        'balance': 0.0,
        'isActive': true,
      },
      {
        'name': 'Rahim Uddin',
        'role': 'Member',
        'totalMeals': 35,
        'balance': 150.0,
        'isActive': false,
      },
    ];

    final int activeMembers = members.where((m) => m['isActive']).length;

    /// -------------------------------------------

    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
      ),
      body: Column(
        children: [
          /// MEMBER COUNT CARD
          Container(
            margin: const EdgeInsets.all(AppStyles.spaceMedium),
            padding: const EdgeInsets.all(AppStyles.spaceMedium),
            decoration: AppStyles.coloredCardDecoration(AppColors.blue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MemberStat(
                  label: 'Total Members',
                  value: members.length.toString(),
                  icon: Icons.people_outline,
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: AppColors.border,
                ),
                _MemberStat(
                  label: 'Active Members',
                  value: activeMembers.toString(),
                  icon: Icons.person_outline,
                ),
              ],
            ),
          ),

          /// MEMBERS LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                AppStyles.spaceMedium,
                0,
                AppStyles.spaceMedium,
                AppStyles.spaceMedium,
              ),
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];
                return _MemberCard(
                  name: member['name'],
                  role: member['role'],
                  totalMeals: member['totalMeals'],
                  balance: member['balance'],
                  isActive: member['isActive'],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Invite member
        },
        icon: const Icon(Icons.person_add),
        label: const Text('Invite Member'),
      ),
    );
  }
}

/// MEMBER STAT
class _MemberStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _MemberStat({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.blue,
          size: 28,
        ),
        const SizedBox(height: AppStyles.spaceSmall),
        Text(
          value,
          style: AppStyles.heading2.copyWith(
            color: AppColors.blue,
          ),
        ),
        const SizedBox(height: AppStyles.spaceXSmall),
        Text(
          label,
          style: AppStyles.caption.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

/// MEMBER CARD
class _MemberCard extends StatelessWidget {
  final String name;
  final String role;
  final int totalMeals;
  final double balance;
  final bool isActive;

  const _MemberCard({
    required this.name,
    required this.role,
    required this.totalMeals,
    required this.balance,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final bool owes = balance < 0;
    final Color balanceColor = owes ? AppColors.error : AppColors.success;

    return ModernCard(
      margin: const EdgeInsets.only(bottom: AppStyles.spaceMedium),
      padding: const EdgeInsets.all(AppStyles.spaceMedium),
      color: isActive
          ? AppColors.cardBackground
          : AppColors.textSecondary.withOpacity(0.05),
      child: Row(
        children: [
          /// AVATAR
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                name[0].toUpperCase(),
                style: AppStyles.heading3.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),

          const SizedBox(width: AppStyles.spaceMedium),

          /// INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: AppStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: AppStyles.spaceSmall),
                    if (role == 'Manager')
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius:
                          BorderRadius.circular(AppStyles.radiusSmall),
                        ),
                        child: Text(
                          'Manager',
                          style: AppStyles.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppStyles.spaceXSmall),
                Text(
                  '$totalMeals meals',
                  style: AppStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          /// BALANCE
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                balance == 0
                    ? 'Settled'
                    : '৳${balance.abs().toStringAsFixed(0)}',
                style: AppStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: balance == 0 ? AppColors.textSecondary : balanceColor,
                ),
              ),
              const SizedBox(height: AppStyles.spaceXSmall),
              if (balance != 0)
                Text(
                  owes ? 'Owes' : 'Advance',
                  style: AppStyles.caption.copyWith(
                    color: balanceColor,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
