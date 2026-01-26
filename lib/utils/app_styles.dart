import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  // ========================================
  // SPACING SYSTEM
  // ========================================
  static const double spaceXSmall = 4.0;
  static const double spaceSmall = 8.0;
  static const double spaceMedium = 12.0;
  static const double spaceLarge = 16.0;
  static const double spaceXLarge = 24.0;
  static const double spaceXXLarge = 32.0;

  // ========================================
  // BORDER RADIUS
  // ========================================
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;

  // ========================================
  // ICON SIZES
  // ========================================
  static const double iconSizeSmall = 18.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;

  // ========================================
  // TYPOGRAPHY SYSTEM
  // ========================================

  // Headings
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
    height: 1.3,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Body Text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  // Caption / Helper Text
  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // ========================================
  // SHADOWS
  // ========================================

  // Standard Card Shadow
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 12,
      offset: const Offset(0, 2),
    ),
  ];

  // Elevated Shadow (for floating elements)
  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  // Hero Card Shadow (for focus areas)
  static List<BoxShadow> heroShadow(Color color) => [
    BoxShadow(
      color: color.withOpacity(0.4),
      blurRadius: 24,
      offset: const Offset(0, 12),
    ),
  ];

  // ========================================
  // INPUT DECORATION
  // ========================================
  static InputDecoration inputDecoration({
    required String labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
    );
  }

  // ========================================
  // BUTTON STYLES
  // ========================================

  // Primary Button
  static ButtonStyle get primaryButton => ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 0,
    padding: const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 14,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusMedium),
    ),
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );

  // Secondary Button
  static ButtonStyle get secondaryButton => OutlinedButton.styleFrom(
    foregroundColor: AppColors.primary,
    side: const BorderSide(color: AppColors.border, width: 1.5),
    padding: const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 14,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusMedium),
    ),
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );

  // ========================================
  // ICON CONTAINER STYLES
  // ========================================

  // Standard Icon Container (for cards)
  static BoxDecoration iconContainer(Color color) {
    return BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: color.withOpacity(0.2),
        width: 1,
      ),
    );
  }

  // Circular Icon Container
  static BoxDecoration circularIconContainer(Color color) {
    return BoxDecoration(
      color: color.withOpacity(0.1),
      shape: BoxShape.circle,
    );
  }

  // ========================================
  // BADGE STYLES
  // ========================================

  // Status Badge
  static BoxDecoration statusBadge(Color color) {
    return BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: color.withOpacity(0.3),
        width: 1,
      ),
    );
  }

  // Simple Badge
  static BoxDecoration simpleBadge(Color color) {
    return BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(4),
    );
  }

  // ========================================
  // COMMON TEXT STYLES (UTILITIES)
  // ========================================

  // Badge Text
  static TextStyle badgeText(Color color) {
    return TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      color: color,
      letterSpacing: 0.5,
    );
  }

  // Currency Text
  static TextStyle currencyText(Color color, {double fontSize = 20}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w900,
      color: color,
      height: 1,
    );
  }

  // Large Currency Display
  static const TextStyle largeCurrency = TextStyle(
    fontSize: 56,
    fontWeight: FontWeight.w900,
    color: Colors.white,
    height: 1,
    letterSpacing: -2,
  );

  // ========================================
  // DIVIDER STYLES
  // ========================================
  static Divider get standardDivider => const Divider(
    color: AppColors.divider,
    thickness: 1,
    height: 1,
  );

  // ========================================
  // INKWELL/RIPPLE CONFIGURATIONS
  // ========================================
  static const double splashRadius = 24.0;
  static final Color rippleColor = AppColors.primary.withOpacity(0.1);
}
