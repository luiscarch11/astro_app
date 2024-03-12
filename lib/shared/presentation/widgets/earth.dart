import 'package:astro_app/shared/domain/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Earth extends StatelessWidget {
  const Earth({
    super.key,
    this.size = 100,
  });
  final double size;
  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      StringConstants.earthAnimationPath,
      repeat: true,
      height: size,
      width: size,
    );
  }
}
