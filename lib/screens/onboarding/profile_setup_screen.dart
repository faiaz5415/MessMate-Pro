import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';
import '../onboarding/role_selection_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  /// Pick image from gallery
  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
          ),
        ),
      );
    }
  }

  /// Show image source bottom sheet
  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppStyles.radiusLarge),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppStyles.spaceLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Choose Profile Picture',
              style: AppStyles.heading3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppStyles.spaceLarge),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(AppStyles.spaceSmall),
                decoration: BoxDecoration(
                  color: AppColors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.photo_library_outlined,
                  color: AppColors.blue,
                ),
              ),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage();
              },
            ),
            if (_profileImage != null)
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(AppStyles.spaceSmall),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    color: AppColors.error,
                  ),
                ),
                title: const Text('Remove Photo'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _profileImage = null;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  void _handleContinue() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RoleSelectionScreen(),
      ),
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.length != 11) {
      return 'Phone number must be 11 digits';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Phone number must contain only digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppStyles.spaceLarge),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// PROGRESS INDICATOR
                _StepIndicator(currentStep: 1, totalSteps: 3),

                const SizedBox(height: AppStyles.spaceXLarge),

                /// PROFILE PICTURE SECTION
                Center(
                  child: Stack(
                    children: [
                      /// Profile Picture Container
                      GestureDetector(
                        onTap: _showImageSourceSheet,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.3),
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.2),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: _profileImage != null
                                ? Image.file(
                              _profileImage!,
                              fit: BoxFit.cover,
                            )
                                : Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.primary.withOpacity(0.1),
                                    AppColors.primary.withOpacity(0.05),
                                  ],
                                ),
                              ),
                              child: Icon(
                                Icons.person_outline,
                                size: 56,
                                color: AppColors.primary.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// Camera Icon Overlay
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _showImageSourceSheet,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.surface,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppStyles.spaceSmall),

                /// Upload Hint Text
                Text(
                  'Tap to upload profile picture',
                  style: AppStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppStyles.spaceXXLarge),

                /// TITLE
                Text(
                  'Tell Us About You',
                  style: AppStyles.heading2,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppStyles.spaceSmall),

                Text(
                  'We need some basic information to get started',
                  style: AppStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppStyles.spaceXXLarge),

                /// NAME INPUT
                TextFormField(
                  controller: _nameController,
                  validator: _validateName,
                  decoration: AppStyles.inputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Enter your full name',
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                ),

                const SizedBox(height: AppStyles.spaceMedium),

                /// PHONE INPUT
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: _validatePhone,
                  decoration: AppStyles.inputDecoration(
                    labelText: 'Phone Number',
                    hintText: '01XXXXXXXXX',
                    prefixIcon: const Icon(Icons.phone_outlined),
                  ),
                ),

                const SizedBox(height: AppStyles.spaceMedium),

                /// INFO CARD
                ModernCard(
                  color: AppColors.info.withOpacity(0.05),
                  padding: const EdgeInsets.all(AppStyles.spaceMedium),
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
                          'Your information is secure and will only be visible to your dining mess members',
                          style: AppStyles.bodySmall.copyWith(
                            color: AppColors.info,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppStyles.spaceXLarge),

                /// CONTINUE BUTTON
                SizedBox(
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: _handleContinue,
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Continue'),
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
    );
  }
}

/// STEP INDICATOR WIDGET
class _StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const _StepIndicator({
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Step $currentStep of $totalSteps',
          style: AppStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppStyles.spaceSmall),
        Row(
          children: List.generate(
            totalSteps,
                (index) => Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(
                  right: index < totalSteps - 1 ? AppStyles.spaceSmall : 0,
                ),
                decoration: BoxDecoration(
                  color: index < currentStep
                      ? AppColors.primary
                      : AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
