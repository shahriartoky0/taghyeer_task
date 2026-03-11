import 'package:flutter/material.dart';
import 'package:taghyeer_test/core/extensions/context_extensions.dart';
import 'package:taghyeer_test/core/extensions/widget_extensions.dart';

import '../../core/config/app_colors.dart';
import '../../core/config/app_sizes.dart';
import '../../core/utils/device/device_utility.dart';


class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final num width;
  final double radius;
  final Color bgColor;
  final Color buttonEffectColor;

  const PrimaryButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.width = double.infinity,
    this.radius = 24,
    this.bgColor = AppColors.lightSecondaryColor,
    this.buttonEffectColor = AppColors.lightSurfaceColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(radius),

      color: bgColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),

        splashColor: buttonEffectColor,
        highlightColor: buttonEffectColor,
        // onLongPress: (){
        //
        // },
        onTap: () {
          DeviceUtility.hapticFeedback();
          onPressed();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm, vertical: 12),
          width: width.toDouble(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            // boxShadow: const <BoxShadow>[
            //   BoxShadow(
            //     color: Colors.grey,
            //     spreadRadius: 5
            //     ),
            // ],
          ),
          child: Text(buttonText, style: context.txtTheme.labelMedium).centered,
        ),
      ),
    );
  }
}
