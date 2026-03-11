import 'dart:math';
import 'package:get/get.dart';

class PasswordStrengthChecker {
  // Minimum criteria
  static const int minLength = 8;
  static const int maxLength = 16;

  // Regex patterns for validation
  static final RegExp _lowerCaseRegex = RegExp(r'[a-z]');
  static final RegExp _upperCaseRegex = RegExp(r'[A-Z]');
  static final RegExp _digitRegex = RegExp(r'\d');
  static final RegExp _specialCharRegex = RegExp(r'[@$!%*?&]');

  // Method to calculate password strength
  double validatePassword(String password) {
    int score = 0 ;


    // Check length of the password
    if (password.length >= minLength && password.length <= maxLength) {
      score += 1;
    }

    // Check for lowercase letters
    if (_lowerCaseRegex.hasMatch(password)) {
      score += 1;
    }

    // Check for uppercase letters
    if (_upperCaseRegex.hasMatch(password)) {
      score += 1;
    }

    // Check for digits
    if (_digitRegex.hasMatch(password)) {
      score += 1;
    }

    // Check for special characters
    if (_specialCharRegex.hasMatch(password)) {
      score += 1;
    }

    // Return a value between 0 and 1 based on how many criteria the password meets
    print("==================> Score: ${min(score / 5.0, 1.0)}");
    return min(score / 5.0, 1.0); // Normalize the score to a range of 0.0 to 1.0
  }
}
