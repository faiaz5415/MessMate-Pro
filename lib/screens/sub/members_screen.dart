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
        'name': 'You (Faiaz)',
        'role': 'Manager',
        'meals': 189,
        'balance': 350.0,
        'isActive': true,
      },
      {
        'name': 'Karim Ahmed',
        'role': 'Member',
        'meals': 165,
        'balance': -120.0,
        'isActive': true,
      },
      {
        'name': 'Rahim Uddin',
        'role': 'Member',
        'meals': 178,
        'balance': 80.0,
        'isActive': true,
      },
      {
        'name': 'Sakib Hassan',
        'role': 'Member',
        'meals': 142,
        'balance': -80.0,
        'isActive': true,
      },
      {
        'name': 'Tanvir Islam',
        'role': 'Member',
        'meals': 156,
        'balance': 45.0,
        'isActive': false,
      },
    ];

    final int totalMembers = members.length;
    final int activeMembers = members.where((m) => m['isActive']).length;
    final double totalBalance = members.fold(0, (sum, m) => sum + (m['balance'] as double));
    /// -------------------------------------------

    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
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
        child: Column(
          children: [
            /// MEMBER COUNT CARD
            Container(
              margin: const EdgeInsets.all(AppStyles.spaceMedium),
              padding: const EdgeInsets.all(AppStyles.spaceMedium),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.blue,
                    AppColors.blue.withOpacity(0.85),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blue.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(
                    label: 'Total',
                    value: totalMembers.toString(),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  _StatItem(
                    label: 'Active',
                    value: activeMembers.toString(),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  _StatItem(
                    label: 'Balance',
                    value: '৳${totalBalance.toStringAsFixed(0)}',
                  ),
                ],
              ),
            ),

            /// MEMBERS LIST
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
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
                    meals: member['meals'],
                    balance: member['balance'],
                    isActive: member['isActive'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            height: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}

class _MemberCard extends StatelessWidget {
  final String name;
  final String role;
  final int meals;
  final double balance;
  final bool isActive;

  const _MemberCard({
    required this.name,
    required this.role,
    required this.meals,
    required this.balance,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      margin: const EdgeInsets.only(bottom: AppStyles.spaceMedium),
      padding: const EdgeInsets.all(AppStyles.spaceMedium),
      child: Row(
        children: [
          /// AVATAR
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.blue.withOpacity(0.8),
                  AppColors.blue,
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                name[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
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
                    Expanded(
                      child: Text(
                        name,
                        style: AppStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (!isActive)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.textSecondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Inactive',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  role,
                  style: AppStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.restaurant_menu_outlined,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$meals meals',
                      style: AppStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: AppStyles.spaceSmall),

          /// BALANCE
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                balance >= 0 ? '+৳${balance.toStringAsFixed(0)}' : '৳${balance.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: balance >= 0 ? AppColors.success : AppColors.error,
                  height: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                balance >= 0 ? 'To receive' : 'To pay',
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
