import 'package:astro_app/shared/domain/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Sun extends StatelessWidget {
  const Sun({
    super.key,
    this.size = 100,
  });
  final double size;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.yellow[800]!,
        BlendMode.srcIn,
      ),
      child: LottieBuilder.asset(
        StringConstants.sunAnimationPath,
        repeat: true,
        height: size,
        reverse: true,
        width: size,
      ),
    );
  }
}
