import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppStyles.spaceLarge),
      decoration: AppStyles.coloredCardDecoration(color),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppStyles.spaceXSmall),
              Text(
                value,
                style: AppStyles.heading2.copyWith(color: color),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(AppStyles.spaceMedium),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
        ],
      ),
    );
  }
}
