import 'package:astro_app/impact_risk/domain/sentry_data.dart';
import 'package:flutter/foundation.dart';

class ImpactRiskPageControllerState {
  final List<SentryData> asteroidsToShow;
  final bool isLoading;
  final double minimumPercentage;
  ImpactRiskPageControllerState({
    required this.asteroidsToShow,
    required this.isLoading,
    required this.minimumPercentage,
  });

  ImpactRiskPageControllerState copyWith({
    List<SentryData>? asteroidsToShow,
    bool? isLoading,
    double? minimumPercentage,
  }) {
    return ImpactRiskPageControllerState(
      asteroidsToShow: asteroidsToShow ?? this.asteroidsToShow,
      isLoading: isLoading ?? this.isLoading,
      minimumPercentage: minimumPercentage ?? this.minimumPercentage,
    );
  }

  @override
  String toString() =>
      'ImpactRiskPageControllerState(asteroidsToShow: $asteroidsToShow, isLoading: $isLoading, minimumPercentage: $minimumPercentage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImpactRiskPageControllerState &&
        listEquals(other.asteroidsToShow, asteroidsToShow) &&
        other.isLoading == isLoading &&
        other.minimumPercentage == minimumPercentage;
  }

  @override
  int get hashCode => asteroidsToShow.hashCode ^ isLoading.hashCode ^ minimumPercentage.hashCode;
}

class ImpactRiskPageControllerInitial extends ImpactRiskPageControllerState {
  ImpactRiskPageControllerInitial()
      : super(
          asteroidsToShow: [],
          isLoading: false,
          minimumPercentage: 0,
        );
}
