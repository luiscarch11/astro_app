import 'package:astro_app/impact_risk/application/impact_risk_page_controller_state.dart';
import 'package:astro_app/impact_risk/domain/fetch_sentry_data_use_case.dart';
import 'package:flutter/material.dart';

class ImpactRiskPageController extends ValueNotifier<ImpactRiskPageControllerState> {
  ImpactRiskPageController(this.fetchSentryDataUseCase)
      : super(
          ImpactRiskPageControllerInitial(),
        );
  final FetchSentryDataUseCase fetchSentryDataUseCase;
  late final TextEditingController textController;
  void initializedController(TextEditingController controller) {
    textController = controller;
  }

  void changedPercentageCircularProgress(double percentage) {
    textController.value = TextEditingValue(
      text: percentage.toString(),
    );
    value = value.copyWith(
      minimumPercentage: percentage,
    );
  }

  void changedPercentageTextField(String newPercentage) {
    final transformedValue = double.tryParse(newPercentage);
    if (transformedValue == null) return;
    value = value.copyWith(
      minimumPercentage: transformedValue,
    );
  }

  void submitted() async {
    value = value.copyWith(
      isLoading: true,
    );
    final result = await fetchSentryDataUseCase.call(
      value.minimumPercentage,
    );
    value = value.copyWith(
      asteroidsToShow: result,
      isLoading: false,
    );
  }
}
