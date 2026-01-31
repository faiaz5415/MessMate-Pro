import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  int _rating = 0;
  String? _selectedCategory;
  bool _isSubmitting = false;

  final List<Map<String, dynamic>> _categories = [
    {'id': 'bug', 'label': 'Bug Report', 'icon': Icons.bug_report_outlined, 'color': AppColors.error},
    {'id': 'feature', 'label': 'Feature Request', 'icon': Icons.lightbulb_outline, 'color': AppColors.warning},
    {'id': 'improvement', 'label': 'Improvement', 'icon': Icons.trending_up_outlined, 'color': AppColors.blue},
    {'id': 'general', 'label': 'General Feedback', 'icon': Icons.chat_bubble_outline, 'color': AppColors.success},
  ];

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    if (!_formKey.currentState!.validate() || _selectedCategory == null) {
      _showSnackBar('Please complete all required fields', AppColors.error);
      return;
    }

    setState(() => _isSubmitting = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() => _isSubmitting = false);

    _showSnackBar('Thank you for your feedback!', AppColors.success);

    // Clear form
    _feedbackController.clear();
    setState(() {
      _rating = 0;
      _selectedCategory = null;
    });
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
        ),
      ),
    );
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
              'Send Feedback',
              style: AppStyles.heading3.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              'Help us improve',
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(AppStyles.spaceLarge),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// RATING SECTION
                  ModernCard(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.warning.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.star_outline_rounded,
                                color: AppColors.warning,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: AppStyles.spaceMedium),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rate Your Experience',
                                    style: AppStyles.bodyLarge.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'How satisfied are you?',
                                    style: AppStyles.bodySmall.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppStyles.spaceLarge),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return GestureDetector(
                              onTap: () => setState(() => _rating = index + 1),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Icon(
                                  index < _rating ? Icons.star_rounded : Icons.star_outline_rounded,
                                  size: 42,
                                  color: index < _rating ? AppColors.warning : AppColors.border,
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppStyles.spaceLarge),

                  /// CATEGORY SECTION
                  Text(
                    'Feedback Category',
                    style: AppStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: AppStyles.spaceMedium),

                  Wrap(
                    spacing: AppStyles.spaceSmall,
                    runSpacing: AppStyles.spaceSmall,
                    children: _categories.map((category) {
                      final isSelected = _selectedCategory == category['id'];
                      return GestureDetector(
                        onTap: () => setState(() => _selectedCategory = category['id']),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppStyles.spaceMedium,
                            vertical: AppStyles.spaceSmall,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? category['color'].withOpacity(0.1) : AppColors.surface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? category['color'] : AppColors.border,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                category['icon'],
                                size: 18,
                                color: isSelected ? category['color'] : AppColors.textSecondary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                category['label'],
                                style: AppStyles.bodySmall.copyWith(
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                  color: isSelected ? category['color'] : AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: AppStyles.spaceLarge),

                  /// FEEDBACK TEXT SECTION
                  Text(
                    'Your Feedback',
                    style: AppStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: AppStyles.spaceMedium),

                  TextFormField(
                    controller: _feedbackController,
                    maxLines: 6,
                    maxLength: 500,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your feedback';
                      }
                      if (value.trim().length < 10) {
                        return 'Feedback must be at least 10 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Tell us what you think...',
                      filled: true,
                      fillColor: AppColors.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
                        borderSide: BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
                        borderSide: BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
                        borderSide: BorderSide(color: AppColors.primary, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
                        borderSide: BorderSide(color: AppColors.error),
                      ),
                      counterStyle: AppStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppStyles.spaceLarge),

                  /// INFO CARD
                  ModernCard(
                    color: AppColors.info.withOpacity(0.05),
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
                          child: Text(
                            'Your feedback helps us improve MessMate Pro. We read every submission!',
                            style: AppStyles.bodySmall.copyWith(
                              color: AppColors.info,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppStyles.spaceXLarge),

                  /// SUBMIT BUTTON
                  SizedBox(
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: _isSubmitting ? null : _submitFeedback,
                      icon: _isSubmitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Icon(Icons.send_rounded),
                      label: Text(_isSubmitting ? 'Submitting...' : 'Submit Feedback'),
                      style: AppStyles.primaryButton.copyWith(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}