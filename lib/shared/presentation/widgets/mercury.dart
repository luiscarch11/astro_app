import 'package:astro_app/shared/domain/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Mercury extends StatelessWidget {
  const Mercury({
    super.key,
    this.size = 100,
  });
  final double size;
  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(
        Colors.grey,
        BlendMode.srcIn,
      ),
      child: LottieBuilder.asset(
        StringConstants.marsAnimationPath,
        repeat: true,
        height: size,
        width: size,
      ),
    );
  }
}
