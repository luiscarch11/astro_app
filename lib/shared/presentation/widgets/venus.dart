import 'package:astro_app/shared/domain/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Venus extends StatelessWidget {
  const Venus({
    super.key,
    this.size = 100,
  });
  final double size;
  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(
        Colors.grey,
        BlendMode.modulate,
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
