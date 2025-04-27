import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:two_fa/core/constants/app_colors.dart';
import 'package:two_fa/core/constants/app_values.dart';
import 'package:two_fa/core/decorations/toast_styles.dart';
import 'package:two_fa/core/extensions/fpdart_extension.dart';
import 'package:two_fa/core/router/app_routes.dart';
import 'package:two_fa/features/global/widgets/color_button.dart';
import 'package:two_fa/features/global/widgets/simple_text_field.dart';
import 'package:two_fa/features/sign_in/sign_in_notifier.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userIdController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    ref.listen(signInNotifierProvider, (prev, next) {
      next.whenOrNull(
        data: (data) {
          if (data.isSome()) {
            ToastStyles.showSuccessToast(data.force().message);
            context.pushNamed(AppRoutes.verify_screen, extra: emailController.text);
          }
        },
        error: (e, st) {
          if (e is Option<AccountSignInStatus>) {
            ToastStyles.showErrorToast(e.force().message);
          } else {
            ToastStyles.showErrorToast(e.toString());
          }
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Column(
        children: [
          SizedBox(height: AppValues.p_16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p_16),
            child: SimpleTextField(title: 'User ID', textController: userIdController),
          ),
          SizedBox(height: AppValues.p_16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p_16),
            child: SimpleTextField(title: 'Email', textController: emailController),
          ),
          SizedBox(height: AppValues.p_16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p_16),
            child: SimpleTextField(title: 'Password', obscureText: true, textController: passwordController),
          ),
          SizedBox(height: AppValues.p_32),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p_16),
            child: ColorButton(
              text: 'Sign In',
              color: AppColors.primaryColor,
              isLoading: ref.watch(signInNotifierProvider).isLoading,
              onTap: () {
                ref
                    .read(signInNotifierProvider.notifier)
                    .loginAndSend2FAEmail(emailController.text, passwordController.text);
              },
            ),
          ),
          SizedBox(height: AppValues.p_24),
        ],
      ),
    );
  }
}
