import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:two_fa/core/decorations/text_styles.dart';

class ToastStyles {
  static showSuccessToast(String message) {
    toastification.show(
      type: ToastificationType.success,
      title: Text(message, style: TextStyles.inter14()),
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.bottomCenter,
    );
  }

  static showErrorToast(String message) {
    toastification.show(
      type: ToastificationType.error,
      title: Text(message, style: TextStyles.inter14()),
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.bottomCenter,
    );
  }
}
