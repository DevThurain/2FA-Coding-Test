import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:two_fa/core/constants/app_colors.dart';
import 'package:two_fa/core/constants/app_fonts.dart';
import 'package:two_fa/core/constants/app_values.dart';
import 'package:two_fa/core/decorations/text_styles.dart';

class SimpleTextField extends HookConsumerWidget {
  const SimpleTextField({
    super.key,
    required this.title,
    required this.textController,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.enabled = true,
    this.maxLength,
  });
  final String title;
  final TextEditingController textController;
  final int maxLines;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool enabled;
  final int? maxLength;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visibleText = useState(true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Focus(
          canRequestFocus: false,
          descendantsAreFocusable: false,
          child: Text(title, style: TextStyles.inter16().copyWith(fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: AppValues.p_12),
        TextField(
          controller: textController,
          maxLines: maxLines,
          maxLength: maxLength,
          style: const TextStyle(fontFamily: AppFonts.inter),
          textInputAction: textInputAction,
          obscureText: obscureText ? visibleText.value : false,
          enabled: enabled,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.greyBase.withAlpha(40),
            counterText: "",
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppValues.p_10)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppValues.p_10)),
              borderSide: BorderSide.none,
            ),
            suffixIcon:
                obscureText
                    ? _buildVisibleIcons(() {
                      visibleText.value = !visibleText.value;
                    }, visibleText.value)
                    : null,
          ),
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ],
    );
  }

  Widget _buildVisibleIcons(VoidCallback onToggle, bool visibleText) {
    return IconButton(onPressed: onToggle, icon: visibleText ? Icon(Icons.visibility_off) : Icon(Icons.visibility));
  }
}