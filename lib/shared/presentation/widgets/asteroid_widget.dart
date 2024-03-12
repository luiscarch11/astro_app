import 'dart:math';

import 'package:astro_app/shared/domain/string_constants.dart';
import 'package:flutter/material.dart';

class Asteroid extends StatefulWidget {
  const Asteroid({
    super.key,
    this.size = 100,
    this.isHazardous = false,
    this.isPotentialImpact = false,
  });
  final double size;
  final bool isHazardous;
  final bool isPotentialImpact;

  @override
  State<Asteroid> createState() => _AsteroidState();
}

class _AsteroidState extends State<Asteroid> with TickerProviderStateMixin {
  late final AnimationController _rotationController;
  late final Animation<double> value;
  late final AnimationController _bouncingController;
  late final AnimationController _colorController;
  late final Animation<double> _bouncingValue;
  late final Animation<Color?> _colorValue;

  @override
  void dispose() {
    _rotationController.dispose();
    _bouncingController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _bouncingController = AnimationController(
      vsync: this,
      value: 0.0,
      duration: const Duration(
        seconds: 1,
      ),
    );
    _colorController = AnimationController(
      vsync: this,
      value: 0.0,
      duration: const Duration(
        seconds: 1,
      ),
    );
    _rotationController = AnimationController(
      vsync: this,
      value: 0.0,
      duration: const Duration(
        seconds: 10,
      ),
    );
    value = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_rotationController);
    _rotationController.addListener(
      () {
        setState(
          () {},
        );
      },
    );

    _rotationController.repeat();
    _bouncingValue = Tween<double>(
      begin: 0,
      end: 30,
    ).animate(
      CurvedAnimation(
        parent: _bouncingController,
        curve: Curves.bounceIn,
      ),
    );
    _colorValue = ColorTween(
      begin: Colors.grey,
      end: Colors.red,
    ).animate(
      _colorController,
    );
    if (widget.isPotentialImpact) {
      _bouncingController.repeat(
        reverse: true,
      );
    }
    if (widget.isHazardous) {
      _colorController.repeat(
        reverse: true,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        _colorValue.value ?? Colors.transparent,
        BlendMode.modulate,
      ),
      child: Transform.translate(
        offset: Offset(
          0,
          -_bouncingValue.value,
        ),
        child: Transform.rotate(
          angle: (2 * pi) * value.value,
          child: Image.asset(
            StringConstants.asteroidImagePath,
            height: widget.size,
            width: widget.size,
          ),
        ),
      ),
    );
  }
}
