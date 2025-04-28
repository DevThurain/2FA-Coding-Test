import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:two_fa/core/constants/app_colors.dart';
import 'package:two_fa/core/constants/app_values.dart';
import 'package:two_fa/core/decorations/text_styles.dart';
import 'package:two_fa/core/decorations/toast_styles.dart';
import 'package:two_fa/core/extensions/fpdart_extension.dart';
import 'package:two_fa/core/router/app_routes.dart';
import 'package:two_fa/core/utils/validator_utils.dart';
import 'package:two_fa/features/create/create_notifier.dart';
import 'package:two_fa/features/global/widgets/color_button.dart';
import 'package:two_fa/features/global/widgets/simple_text_field.dart';

class CreateScreen extends HookConsumerWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userIdController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    ref.listen(createNotifierProvider, (prev, next) {
      next.whenOrNull(
        data: (data) {
          if (data.isSome()) {
            ToastStyles.showSuccessToast(data.force().message);
          }
        },
        error: (e, st) {
          if (e is Option<AccountCreateStatus>) {
            ToastStyles.showErrorToast(e.force().message);
          } else {
            ToastStyles.showErrorToast(e.toString());
          }
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(title: Text('Account Creation')),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: AppValues.p_16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppValues.p_16),
              child: SimpleTextField(
                title: 'User ID',
                textController: userIdController,
                validator: (value) {
                  return ValidatorUtils.validateEmptyField('user ID', value);
                },
              ),
            ),
            SizedBox(height: AppValues.p_16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppValues.p_16),
              child: SimpleTextField(
                title: 'Email',
                textController: emailController,
                validator: (value) {
                  return ValidatorUtils.validateEmail(value);
                },
              ),
            ),
            SizedBox(height: AppValues.p_16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppValues.p_16),
              child: SimpleTextField(
                title: 'Password',
                obscureText: true,
                textController: passwordController,
                validator: (value) {
                  return ValidatorUtils.validatePassword(value);
                },
              ),
            ),
            SizedBox(height: AppValues.p_32),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppValues.p_16),
              child: ColorButton(
                text: 'Create Account',
                color: AppColors.primaryColor,
                isLoading: ref.watch(createNotifierProvider).isLoading,
                onTap: () {
                  final isValidated = formKey.currentState?.validate() ?? false;
                  if (isValidated) {
                    ref
                        .read(createNotifierProvider.notifier)
                        .createAccount(
                          userId: userIdController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        );
                  }
                },
              ),
            ),
            SizedBox(height: AppValues.p_24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppValues.p_16),
              child: GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoutes.sign_in_screen);
                },
                child: Text(
                  'Already have account? Sign In',
                  style: TextStyles.inter14().copyWith(color: AppColors.greyBase),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
