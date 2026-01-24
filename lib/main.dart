import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_flow_provider.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/auth/sign_in_screen.dart'; // Sign In Screen import করুন
import 'screens/auth/sign_up_screen.dart'; // Sign Up Screen import করুন
import 'screens/auth/forgot_password_screen.dart'; // Forgot Password Screen import করুন
import 'screens/onboarding/profile_setup_screen.dart'; // Profile Setup Screen import করুন
import 'screens/onboarding/dining_select_screen.dart'; // dining_select_screen.dart
import 'screens/onboarding/join_status_screen.dart'; // join_status_screen.dart
import 'screens/main/main_shell.dart'; // main_shell.dart

void main() {
  runApp(const MessMateApp());
}

class MessMateApp extends StatelessWidget {
  const MessMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppFlowProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MessMate Pro',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green,
        ),
        // home: const SplashScreen(), // home বাদ দিয়ে initialRoute এবং routes ব্যবহার করুন
        initialRoute: '/', // Splash Screen কে initial route হিসেবে সেট করুন
        routes: {
          '/': (context) => const SplashScreen(), // Splash Screen
          '/sign-in': (context) => const SignInScreen(),
          '/sign-up': (context) => const SignUpScreen(),
          '/forgot-password': (context) => const ForgotPasswordScreen(),
          '/profile-setup': (context) => const ProfileSetupScreen(),
          // Splash Screen থেকে নেভিগেট করার জন্য প্রয়োজনীয় রুটগুলি যোগ করুন
          '/dining-select': (context) => const DiningSelectScreen(), // dining_select_screen.dart
          '/join-status': (context) => const JoinStatusScreen(), // join_status_screen.dart
          '/main-shell': (context) => const MainShell(), // main_shell.dart
        },
      ),
    );
  }
}