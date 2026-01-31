import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/modern_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _profileFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  final _nameController = TextEditingController(text: 'Kh Faiaz Hasan');
  final _phoneController = TextEditingController(text: '01712345678');
  final _emailController = TextEditingController(text: 'faiaz.cse@diu.edu.bd');

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        setState(() => _profileImage = File(pickedFile.path));
      }
    } catch (e) {
      _showSnackBar('Error picking image: $e', isError: true);
    }
  }

  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppStyles.radiusLarge)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppStyles.spaceLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Profile Picture', style: AppStyles.heading3),
            const SizedBox(height: AppStyles.spaceLarge),
            _ActionTile(
              icon: Icons.photo_library_outlined,
              title: 'Choose from Gallery',
              color: AppColors.blue,
              onTap: () {
                Navigator.pop(context);
                _pickImage();
              },
            ),
            if (_profileImage != null)
              _ActionTile(
                icon: Icons.delete_outline,
                title: 'Remove Photo',
                color: AppColors.error,
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _profileImage = null);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.error : AppColors.success,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
            Text('My Profile', style: AppStyles.heading3.copyWith(fontWeight: FontWeight.w800)),
            Text('Account Settings', style: AppStyles.caption.copyWith(color: AppColors.textSecondary)),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primary.withOpacity(0.03), AppColors.background],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: AppStyles.spaceLarge),
            child: Column(
              children: [
                const SizedBox(height: AppStyles.spaceMedium),

                /// PROFILE IMAGE SECTION
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                          child: _profileImage == null
                              ? Icon(Icons.person_outline, size: 50, color: AppColors.primary)
                              : null,
                        ),
                      ),
                      GestureDetector(
                        onTap: _showImageSourceSheet,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.background, width: 3),
                          ),
                          child: const Icon(Icons.camera_alt_rounded, size: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppStyles.spaceXXLarge),

                /// PERSONAL INFO SECTION
                _SectionHeader(title: 'Personal Details', icon: Icons.person_outline),
                ModernCard(
                  padding: const EdgeInsets.all(AppStyles.spaceMedium),
                  child: Form(
                    key: _profileFormKey,
                    child: Column(
                      children: [
                        _buildTextField(_nameController, 'Full Name', Icons.person_outline,
                            validator: (v) => (v == null || v.isEmpty) ? 'Name is required' : null),
                        const SizedBox(height: AppStyles.spaceMedium),
                        _buildTextField(_phoneController, 'Phone', Icons.phone_outlined, isPhone: true,
                            validator: (v) => (v == null || v.length != 11) ? 'Enter a valid 11-digit number' : null),
                        const SizedBox(height: AppStyles.spaceMedium),
                        _buildTextField(_emailController, 'Email', Icons.email_outlined, isReadOnly: true),
                        const SizedBox(height: AppStyles.spaceLarge),
                        _buildButton('Update Profile', Icons.check_circle_outline, AppColors.primary, () {
                          if (_profileFormKey.currentState!.validate()) {
                            _showSnackBar('Profile updated successfully');
                          }
                        }),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppStyles.spaceXLarge),

                /// SECURITY SECTION
                _SectionHeader(title: 'Security', icon: Icons.lock_outline),
                ModernCard(
                  padding: const EdgeInsets.all(AppStyles.spaceMedium),
                  child: Form(
                    key: _passwordFormKey,
                    child: Column(
                      children: [
                        _buildPasswordField(
                          _currentPasswordController,
                          'Current Password',
                          _obscureCurrentPassword,
                              (v) => setState(() => _obscureCurrentPassword = !v),
                          validator: (v) => (v == null || v.isEmpty) ? 'Enter current password' : null,
                        ),
                        const SizedBox(height: AppStyles.spaceMedium),
                        _buildPasswordField(
                          _newPasswordController,
                          'New Password',
                          _obscureNewPassword,
                              (v) => setState(() => _obscureNewPassword = !v),
                          validator: (v) => (v == null || v.length < 6) ? 'Password must be at least 6 characters' : null,
                        ),
                        const SizedBox(height: AppStyles.spaceMedium),
                        _buildPasswordField(
                          _confirmPasswordController,
                          'Confirm Password',
                          _obscureConfirmPassword,
                              (v) => setState(() => _obscureConfirmPassword = !v),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Confirm your password';
                            if (v != _newPasswordController.text) return 'Passwords do not match';
                            return null;
                          },
                        ),
                        const SizedBox(height: AppStyles.spaceLarge),
                        _buildButton('Change Password', Icons.security_outlined, AppColors.orange, () {
                          if (_passwordFormKey.currentState!.validate()) {
                            _showSnackBar('Password changed successfully');
                            _currentPasswordController.clear();
                            _newPasswordController.clear();
                            _confirmPasswordController.clear();
                          }
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppStyles.spaceXXLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPhone = false, bool isReadOnly = false, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      readOnly: isReadOnly,
      validator: validator,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      style: AppStyles.bodyMedium.copyWith(
        fontWeight: FontWeight.w600,
        color: isReadOnly ? AppColors.textSecondary : AppColors.textPrimary,
      ),
      decoration: AppStyles.inputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: isReadOnly ? AppColors.textSecondary : AppColors.primary, size: 20),
      ).copyWith(
        filled: isReadOnly,
        fillColor: isReadOnly ? AppColors.border.withOpacity(0.1) : null,
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label, bool obscure, Function(bool) toggle, {String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
      decoration: AppStyles.inputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.lock_outline, color: AppColors.primary, size: 20),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 20, color: AppColors.textSecondary),
          onPressed: () => toggle(obscure),
        ),
      ),
    );
  }

  Widget _buildButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 20),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.5)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: AppStyles.spaceMedium),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(title.toUpperCase(), style: AppStyles.bodySmall.copyWith(fontWeight: FontWeight.w800, color: AppColors.textSecondary, letterSpacing: 1.2)),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;
  const _ActionTile({required this.icon, required this.title, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: color, size: 22),
      ),
      title: Text(title, style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
      onTap: onTap,
    );
  }
}