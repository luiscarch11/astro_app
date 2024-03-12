import 'package:astro_app/shared/domain/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Mars extends StatelessWidget {
  const Mars({
    super.key,
    this.size = 100,
  });
  final double size;
  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      StringConstants.marsAnimationPath,
      repeat: true,
      height: size,
      width: size,
    );
  }
}
