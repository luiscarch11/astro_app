import 'package:astro_app/impact_risk/domain/sentry_data.dart';
import 'package:astro_app/shared/domain/numeric_constants.dart';
import 'package:astro_app/shared/presentation/widgets/asteroid_widget.dart';
import 'package:flutter/material.dart';

class SentryAsteroidDetails extends StatelessWidget {
  const SentryAsteroidDetails({
    super.key,
    required this.asteroid,
  });
  final SentryData asteroid;
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
                Asteroid(
                  isHazardous: asteroid.diameter > NumericConstants.hazardousAsteroidDiameterMeters,
                  isPotentialImpact: false,
                ),
                if (asteroid.diameter > NumericConstants.hazardousAsteroidDiameterMeters)
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
                      'Riesgo de impacto desde el año ${asteroid.impactRangeFrom}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Riesgo de impacto hasta el año ${asteroid.impactRangeTo}',
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
                'Probabilidades de impacto: ${asteroid.impactRiskPercentage}%',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
