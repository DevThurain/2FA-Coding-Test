import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:two_fa/core/constants/app_colors.dart';
import 'package:two_fa/core/constants/app_values.dart';
import 'package:two_fa/core/decorations/text_styles.dart';

class ColorButton extends StatelessWidget {
  const ColorButton({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
    this.darkText = false,
    this.isLoading = false,
  });

  final String text;
  final Color color;
  final VoidCallback onTap;
  final bool darkText;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? () {} : onTap,
      child: Container(
        width: double.infinity,
        height: AppValues.p_56,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppValues.p_10),
        ),
        child: Center(
          child: isLoading
              ? LoadingAnimationWidget.stretchedDots(
                  color: Colors.white,
                  size: AppValues.p_24,
                )
              : Text(
                  text,
                  style: TextStyles.inter16().copyWith(
                    color: darkText ? AppColors.black : AppColors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
