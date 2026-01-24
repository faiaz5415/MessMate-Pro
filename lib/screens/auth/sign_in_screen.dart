import 'package:flutter/material.dart';
import 'forgot_password_screen.dart'; // নিশ্চিত করুন যে এই ফাইলটি বিদ্যমান
import 'sign_up_screen.dart'; // নিশ্চিত করুন যে এই ফাইলটি বিদ্যমান
import '../onboarding/profile_setup_screen.dart'; // login এর পর এখানেই যাবে

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        centerTitle: true,
      ),
      body: SafeArea( // SafeArea ব্যবহার করা হয়েছে overflow রোধের জন্য
        child: SingleChildScrollView( // SingleChildScrollView ব্যবহার করা হয়েছে overflow রোধের জন্য
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              const Text(
                'Welcome Back 👋',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Sign in to continue',
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 32),

              /// Email
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// Password
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// Sign In button
              ElevatedButton(
                onPressed: () {
                  // Sign In button press action
                  Navigator.pushReplacementNamed( // Use pushReplacementNamed
                    context,
                    '/profile-setup', // Route defined in main.dart
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Sign In'),
              ),

              const SizedBox(height: 12),

              /// Forgot Password
              TextButton(
                onPressed: () {
                  // Forgot Password button press action
                  Navigator.pushReplacementNamed( // Use pushReplacementNamed
                    context,
                    '/forgot-password', // Route defined in main.dart
                  );
                },
                child: const Text('Forgot Password?'),
              ),

              const SizedBox(height: 300),

              /// Sign Up section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      // Sign Up button press action
                      Navigator.pushReplacementNamed( // Use pushReplacementNamed
                        context,
                        '/sign-up', // Route defined in main.dart
                      );
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}