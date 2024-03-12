import 'package:astro_app/impact_risk/application/impact_risk_page_controller.dart';
import 'package:astro_app/impact_risk/application/impact_risk_page_controller_state.dart';
import 'package:astro_app/impact_risk/domain/sentry_data.dart';
import 'package:astro_app/impact_risk/infrastructure/nasa_api_fetch_sentry_data_use_case.dart';
import 'package:astro_app/shared/domain/numeric_constants.dart';
import 'package:astro_app/shared/presentation/sentry_asteroid_details.dart';
import 'package:astro_app/shared/presentation/solar_system_orbits.dart';
import 'package:astro_app/shared/presentation/widgets/loader.dart';
import 'package:astro_app/shared/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class ImpactRiskPage extends StatefulWidget {
  const ImpactRiskPage({super.key});

  @override
  State<ImpactRiskPage> createState() => _ImpactRiskPageState();
}

class _ImpactRiskPageState extends State<ImpactRiskPage> {
  late final TextEditingController textController;
  late final ImpactRiskPageController pageController;

  @override
  void initState() {
    textController = TextEditingController();
    pageController = ImpactRiskPageController(
      NasaAPIFetchSentryDataUseCase(),
    )..initializedController(textController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerRight,
                child: Tooltip(
                  showDuration: Duration(
                    seconds: 5,
                  ),
                  triggerMode: TooltipTriggerMode.tap,
                  message:
                      'Acá podrás buscar asteroides de acuerdo a la probabilidad de impacto con la Tierra. Puedes hacer zoom para interactuar con ellos.',
                  child: Icon(
                    Icons.info,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              ValueListenableBuilder<ImpactRiskPageControllerState>(
                  valueListenable: pageController,
                  builder: (context, snapshot, _) {
                    return AnimatedSwitcher(
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeIn,
                      child: snapshot.isLoading
                          ? const Loader()
                          : Column(
                              children: [
                                Text(
                                  'Probabilidad de impacto mínima',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                TextFieldWidget(
                                  onChanged: pageController.changedPercentageTextField,
                                  controller: textController,
                                  textInputType: const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                OutlinedButton(
                                  onPressed: () => pageController.submitted(),
                                  child: const Text('Buscar'),
                                ),
                              ],
                            ),
                    );
                  }),
              ValueListenableBuilder<ImpactRiskPageControllerState>(
                valueListenable: pageController,
                builder: (_, snapshot, __) {
                  return Slider(
                    min: 0,
                    max: 100,
                    onChanged: pageController.changedPercentageCircularProgress,
                    value: snapshot.minimumPercentage,
                  );
                },
              ),
              ValueListenableBuilder<ImpactRiskPageControllerState>(
                valueListenable: pageController,
                builder: (BuildContext context, ImpactRiskPageControllerState value, _) {
                  return Text(
                    '${value.asteroidsToShow.length} asteroides encontrados',
                    style: Theme.of(context).textTheme.titleMedium,
                  );
                },
              ),
              Expanded(
                child: ValueListenableBuilder<ImpactRiskPageControllerState>(
                  valueListenable: pageController,
                  builder: (_, snapshot, __) {
                    return SolarSystemOrbits<SentryData>(
                      items: snapshot.asteroidsToShow,
                      isHazardousBuilder: (data) => data.diameter >= NumericConstants.hazardousAsteroidDiameterMeters,
                      onTap: (data) {
                        showDialog(
                          context: context,
                          builder: (_) => SentryAsteroidDetails(
                            asteroid: data,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
