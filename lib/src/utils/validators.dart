/// Utility class for input validation
class Validators {
  Validators._();

  static const int minPasswordLength = 8;
  
  /// Validate email format
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  /// Validate password strength
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < minPasswordLength) {
      return 'Password must be at least $minPasswordLength characters';
    }
    
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    
    return null;
  }

  /// Validate password confirmation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  /// Calculate password strength (0-4)
  static int calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0;
    
    int strength = 0;
    
    // Length check
    if (password.length >= minPasswordLength) strength++;
    
    // Uppercase check
    if (RegExp(r'[A-Z]').hasMatch(password)) strength++;
    
    // Lowercase check
    if (RegExp(r'[a-z]').hasMatch(password)) strength++;
    
    // Number check
    if (RegExp(r'[0-9]').hasMatch(password)) strength++;
    
    // Special character check
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength++;
    
    // Return strength capped at 4
    return strength > 4 ? 4 : strength;
  }

  /// Get password strength text
  static String getPasswordStrengthText(int strength) {
    switch (strength) {
      case 0:
      case 1:
        return 'Weak';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Strong';
      default:
        return 'Weak';
    }
  }

  /// Get password strength color
  static PasswordStrengthColor getPasswordStrengthColor(int strength) {
    switch (strength) {
      case 0:
      case 1:
        return PasswordStrengthColor.weak;
      case 2:
        return PasswordStrengthColor.fair;
      case 3:
        return PasswordStrengthColor.good;
      case 4:
        return PasswordStrengthColor.strong;
      default:
        return PasswordStrengthColor.weak;
    }
  }
}

/// Enum for password strength colors
enum PasswordStrengthColor {
  weak,
  fair,
  good,
  strong,
}