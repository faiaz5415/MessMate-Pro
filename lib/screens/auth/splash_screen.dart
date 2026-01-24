import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main/main_shell.dart'; // Assuming MainShell is your main screen after login

import '../../providers/app_flow_provider.dart';
import 'sign_in_screen.dart';
import '../onboarding/profile_setup_screen.dart';
import '../onboarding/dining_select_screen.dart';
import '../onboarding/join_status_screen.dart';
import '../main/dashboard_screen.dart'; // Assuming DashboardScreen is part of MainShell

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Added a delay for the splash screen effect
    Future.delayed(const Duration(seconds: 2), _handleNavigation);
  }

  void _handleNavigation() {
    // Using context.read<AppFlowProvider>() is fine here as it's inside initState
    // If you were to use context in build, you might consider context.watch or context.select
    final flow = context.read<AppFlowProvider>();

    String initialRoute;

    if (!flow.isLoggedIn) {
      initialRoute = '/sign-in'; // Use named route
    } else if (!flow.profileCompleted) {
      initialRoute = '/profile-setup'; // Use named route
    } else if (!flow.hasDining && flow.joinRequestPending) {
      initialRoute = '/join-status'; // Assuming you have a '/join-status' route
    } else if (!flow.hasDining) {
      initialRoute = '/dining-select'; // Assuming you have a '/dining-select' route
    } else {
      initialRoute = '/main-shell'; // Use named route for your main shell/dashboard
    }

    // Use pushReplacementNamed to replace the splash screen with the new screen
    Navigator.pushReplacementNamed(context, initialRoute);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant, size: 64),
            SizedBox(height: 16),
            Text(
              'MessMate Pro',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}