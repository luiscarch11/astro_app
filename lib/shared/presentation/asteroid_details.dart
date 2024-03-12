import 'package:astro_app/shared/domain/neo.dart';
import 'package:astro_app/shared/presentation/widgets/asteroid_widget.dart';
import 'package:astro_app/shared/presentation/widgets/earth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

class AsteroidDetails extends StatelessWidget {
  const AsteroidDetails({
    super.key,
    required this.asteroid,
  });
  final NEO asteroid;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black12,
              Colors.blueGrey.shade500,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'asteroid_tile0',
                  child: Asteroid(
                    key: const Key('asteroid_tile'),
                    isHazardous: asteroid.isHazardous,
                    isPotentialImpact: asteroid.isSentry,
                  ),
                ),
                if (asteroid.isHazardous)
                  const Tooltip(
                    triggerMode: TooltipTriggerMode.tap,
                    message: 'Si impacta contra la Tierra, podría causar un daño significativo',
                    child: Icon(
                      Icons.info,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
            Center(
              child: Text(
                asteroid.name,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Diametro mínimo: ${asteroid.diameterMinMeters.toStringAsFixed(2)} m',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Diametro máximo: ${asteroid.diameterMaxMeters.toStringAsFixed(2)} m',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                asteroid.isSentry
                    ? 'Este asteroide está siendo monitoreado por la NASA'
                    : 'Este asteroide no está siendo monitoreado por la NASA',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: Asteroid(
                    key: const Key('asteroid_tile'),
                    isHazardous: asteroid.isHazardous,
                    isPotentialImpact: asteroid.isSentry,
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constr) {
                      return CustomPaint(
                        painter: _DistancePainter(
                          asteroid,
                          constr.maxWidth,
                        ),
                      );
                    },
                  ),
                ),
                const Expanded(
                  child: Earth(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DistancePainter extends CustomPainter {
  final NEO asteroid;
  final double availableWidth;

  _DistancePainter(
    this.asteroid,
    this.availableWidth,
  );
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final path = Path();
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    path
      ..lineTo(
        availableWidth,
        0,
      )
      ..moveTo(
        availableWidth + 2,
        0,
      )
      ..lineTo(
        availableWidth - 10,
        10,
      )
      ..moveTo(
        availableWidth + 2,
        0,
      )
      ..lineTo(
        availableWidth - 10,
        -10,
      )
      ..moveTo(-2, 0)
      ..lineTo(
        10,
        10,
      )
      ..moveTo(
        -2,
        0,
      )
      ..lineTo(
        10,
        -10,
      );
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${NumberFormat.decimalPattern().format(
          asteroid.approachData.distanceKM,
        )} km',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      const Offset(
        0,
        16,
      ),
    );
    canvas.drawPath(
      path,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
