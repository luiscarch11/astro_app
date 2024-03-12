import 'package:astro_app/shared/domain/neo.dart';
import 'package:flutter/foundation.dart';

class AsteroidsPageControllerState {
  final List<NEO> asteroidsToShow;
  final bool isLoading;
  final DateTime filterDateFrom;
  final DateTime filterDateUntil;
  final int asteroidsSinceLastVisit;
  AsteroidsPageControllerState({
    required this.asteroidsToShow,
    required this.isLoading,
    required this.filterDateFrom,
    required this.filterDateUntil,
    required this.asteroidsSinceLastVisit,
  });

  AsteroidsPageControllerState copyWith({
    List<NEO>? asteroidsToShow,
    bool? isLoading,
    DateTime? filterDateFrom,
    DateTime? filterDateUntil,
    int? asteroidsSinceLastVisit,
  }) {
    return AsteroidsPageControllerState(
      asteroidsToShow: asteroidsToShow ?? this.asteroidsToShow,
      isLoading: isLoading ?? this.isLoading,
      filterDateFrom: filterDateFrom ?? this.filterDateFrom,
      filterDateUntil: filterDateUntil ?? this.filterDateUntil,
      asteroidsSinceLastVisit: asteroidsSinceLastVisit ?? this.asteroidsSinceLastVisit,
    );
  }

  @override
  String toString() {
    return 'AsteroidsPageControllerState(asteroidsToShow: $asteroidsToShow, isLoading: $isLoading, filterDateFrom: $filterDateFrom, filterDateUntil: $filterDateUntil, asteroidsSinceLastVisit: $asteroidsSinceLastVisit)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AsteroidsPageControllerState &&
        listEquals(other.asteroidsToShow, asteroidsToShow) &&
        other.isLoading == isLoading &&
        other.filterDateFrom == filterDateFrom &&
        other.filterDateUntil == filterDateUntil &&
        other.asteroidsSinceLastVisit == asteroidsSinceLastVisit;
  }

  @override
  int get hashCode {
    return asteroidsToShow.hashCode ^
        isLoading.hashCode ^
        filterDateFrom.hashCode ^
        filterDateUntil.hashCode ^
        asteroidsSinceLastVisit.hashCode;
  }
}

class AsteroidsPageControllerInitial extends AsteroidsPageControllerState {
  AsteroidsPageControllerInitial()
      : super(
          asteroidsToShow: [],
          isLoading: false,
          filterDateFrom: DateTime.now(),
          filterDateUntil: DateTime.now(),
          asteroidsSinceLastVisit: 0,
        );
}
