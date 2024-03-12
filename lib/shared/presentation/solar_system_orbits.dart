import 'dart:math';

import 'package:astro_app/impact_risk/domain/planets.dart';
import 'package:astro_app/shared/application/focused_orbits_controller.dart';
import 'package:astro_app/shared/presentation/widgets/asteroid_widget.dart';
import 'package:astro_app/shared/presentation/widgets/earth.dart';
import 'package:astro_app/shared/presentation/widgets/mars.dart';
import 'package:astro_app/shared/presentation/widgets/mercury.dart';
import 'package:astro_app/shared/presentation/widgets/sun.dart';
import 'package:astro_app/shared/presentation/widgets/venus.dart';
import 'package:flutter/material.dart';

class SolarSystemOrbits<T> extends StatelessWidget {
  SolarSystemOrbits({
    super.key,
    required this.items,
    required this.onTap,
    this.isHazardousBuilder,
  });
  final focusedOrbitsController = FocusedOrbitsController();
  final List<T> items;
  final ValueChanged<T> onTap;
  final bool Function(T)? isHazardousBuilder;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 50,
      child: Stack(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Center(
                child: Sun(),
              ),
              Spacer(),
            ],
          ),
          ...(List<Widget>.generate(
            4,
            (i) {
              return Center(
                child: GestureDetector(
                  onTap: () => focusedOrbitsController.focusedOrbit(i),
                  child: ValueListenableBuilder<List<int>>(
                    valueListenable: focusedOrbitsController,
                    builder: (__, snapshot, _) {
                      return Container(
                        width: 150 + (3 - i) * 50,
                        height: 150 + (3 - i) * 50,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: snapshot.contains(i) ? Colors.white.withOpacity(.5) : Colors.white,
                            width: snapshot.contains(i) ? 25 : 1,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          )),
          ValueListenableBuilder<List<int>>(
              valueListenable: focusedOrbitsController,
              builder: (__, snapshot, _) {
                return _RotationPlanet(
                  radius: 75,
                  isFocused: snapshot.contains(3),
                  child: const Mercury(
                    size: 20,
                  ),
                );
              }),
          ValueListenableBuilder<List<int>>(
              valueListenable: focusedOrbitsController,
              builder: (__, snapshot, _) {
                return _RotationPlanet(
                  radius: 100,
                  isFocused: snapshot.contains(2),
                  child: const Venus(
                    size: 20,
                  ),
                );
              }),
          ValueListenableBuilder<List<int>>(
              valueListenable: focusedOrbitsController,
              builder: (__, snapshot, _) {
                return _RotationPlanet(
                  radius: 125,
                  isFocused: snapshot.contains(1),
                  child: const Earth(
                    size: 30,
                  ),
                );
              }),
          ValueListenableBuilder<List<int>>(
              valueListenable: focusedOrbitsController,
              builder: (__, snapshot, _) {
                return _RotationPlanet(
                  radius: 150,
                  isFocused: snapshot.contains(0),
                  child: const Mars(
                    size: 20,
                  ),
                );
              }),
          ...List.generate(
            items.length,
            (index) => RotationAsteroid(
              isHazardous: isHazardousBuilder?.call(
                    items[index],
                  ) ??
                  false,
              controller: focusedOrbitsController,
              planetOrbit: Planet.fromIndex(
                Random().nextInt(4),
              ),
              onTap: () => onTap(
                items[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RotationAsteroid extends StatelessWidget {
  const RotationAsteroid({
    super.key,
    required this.controller,
    required this.planetOrbit,
    required this.onTap,
    required this.isHazardous,
  });
  final bool isHazardous;
  final Planet planetOrbit;
  final FocusedOrbitsController controller;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = 150 - planetOrbit.orbitIndex * 25 - (Random().nextDouble() * 25);
    return ValueListenableBuilder<List<int>>(
      valueListenable: controller,
      builder: (__, snapshot, _) {
        return GestureDetector(
          onTap: onTap,
          child: _RotationPlanet(
            radius: radius,
            isFocused: snapshot.contains(planetOrbit.orbitIndex),
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.modulate,
              ),
              child: Asteroid(
                size: 5,
                isHazardous: isHazardous,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RotationPlanet extends StatefulWidget {
  final double radius;
  final Widget child;
  final bool randomStartingLocation;
  final bool isFocused;
  const _RotationPlanet({
    required this.radius,
    required this.child,
    this.randomStartingLocation = false,
    required this.isFocused,
  });

  @override
  State<_RotationPlanet> createState() => _RotationPlanetState();
}

class _RotationPlanetState extends State<_RotationPlanet> with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;
  var x = 0.0;
  var y = 0.0;
  var angle = 0.0;
  @override
  void didUpdateWidget(covariant _RotationPlanet oldWidget) {
    if (widget.isFocused) {
      _rotationController.stop();
    } else {
      _rotationController.repeat();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    if (!widget.randomStartingLocation) angle = Random().nextDouble() * 2 * pi;
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 50,
      ),
    );
    _rotationController.addListener(
      () {
        setState(
          () {
            final radius = widget.radius;
            x = radius * cos(angle);
            y = radius * sin(angle);
            angle += 0.01;
          },
        );
      },
    );
    if (!widget.isFocused) {
      _rotationController.repeat(
        reverse: false,
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(x, y),
      child: Center(
        child: widget.child,
      ),
    );
  }
}
