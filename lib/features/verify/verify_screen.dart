import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:two_fa/core/constants/app_colors.dart';
import 'package:two_fa/core/constants/app_values.dart';
import 'package:two_fa/core/decorations/text_styles.dart';
import 'package:two_fa/core/decorations/toast_styles.dart';
import 'package:two_fa/core/extensions/fpdart_extension.dart';
import 'package:two_fa/features/global/widgets/color_button.dart';
import 'package:two_fa/features/sign_in/sign_in_notifier.dart';
import 'package:pinput/pinput.dart';
import 'package:two_fa/features/verify/verify_notifier.dart';

class VerifyScreen extends HookConsumerWidget {
  const VerifyScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpController = useTextEditingController();

    ref.listen(verifyNotifierProvider, (prev, next) {
      next.whenOrNull(
        data: (data) {
          if (data.isSome()) {
            ToastStyles.showSuccessToast(data.force().message);
          }
        },
        error: (e, st) {
          if (e is Option<AccountVerifyStatus>) {
            ToastStyles.showErrorToast(e.force().message);
          } else {
            ToastStyles.showErrorToast(e.toString());
          }
        },
        loading: () {},
      );
    });
    return Scaffold(
      appBar: AppBar(title: Text('Verify OTP')),
      body: Column(
        children: [
          SizedBox(height: AppValues.p_16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p_16),
            child: Text('We sent verificaiton otp to your email.', style: TextStyles.inter16()),
          ),
          SizedBox(height: AppValues.p_20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p_16),
            child: Pinput(controller: otpController, length: 6),
          ),
          SizedBox(height: AppValues.p_32),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p_16),
            child: ColorButton(
              text: 'Verify',
              color: AppColors.primaryColor,
              isLoading: ref.watch(verifyNotifierProvider).isLoading,
              onTap: () {
                ref.read(verifyNotifierProvider.notifier).verify(email: email, otp: otpController.text);
              },
            ),
          ),
          SizedBox(height: AppValues.p_24),
        ],
      ),
    );
  }
}
