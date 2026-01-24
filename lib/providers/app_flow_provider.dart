import 'package:flutter/material.dart';

class AppFlowProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _profileCompleted = false;
  bool _hasDining = false;
  bool _joinRequestPending = false;

  bool get isLoggedIn => _isLoggedIn;
  bool get profileCompleted => _profileCompleted;
  bool get hasDining => _hasDining;
  bool get joinRequestPending => _joinRequestPending;

  // Mock actions (for now)
  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void completeProfile() {
    _profileCompleted = true;
    notifyListeners();
  }

  void requestJoinDining() {
    _joinRequestPending = true;
    notifyListeners();
  }

  void approveDining() {
    _hasDining = true;
    _joinRequestPending = false;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _profileCompleted = false;
    _hasDining = false;
    _joinRequestPending = false;
    notifyListeners();
  }
}
