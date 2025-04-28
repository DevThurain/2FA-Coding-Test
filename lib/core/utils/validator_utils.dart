class ValidatorUtils {
  static String? validateEmptyField(String fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty $fieldName.';
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Empty email.';
    }

    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
      r"[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
    );
    final isValid = emailRegex.hasMatch(email);

    return !isValid ? 'Invalid email format.' : null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Empty password.';
    }

    final isValid = password.length >= 8;

    return !isValid ? 'Password should be atlease 8 characters.' : null;
  }

  static String? validatePin(String? pin) {
    if (pin == null || pin.isEmpty) {
      return 'Empty pin.';
    }

    final isValid = pin.length == 6;

    return !isValid ? 'Please fill pin correctly.' : null;
  }
}
