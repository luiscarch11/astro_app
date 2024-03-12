import 'package:astro_app/shared/application/asteroids_page_controller_state.dart';
import 'package:astro_app/shared/domain/fetch_last_connection_use_case.dart';
import 'package:astro_app/shared/domain/fetch_neo_use_case.dart';
import 'package:flutter/material.dart';

class AsteroidsPageController extends ValueNotifier<AsteroidsPageControllerState> {
  AsteroidsPageController(
    this.fetchNeoUseCase,
    this.fetchLastConnectionUseCase,
  ) : super(
          AsteroidsPageControllerInitial(),
        );
  final FetchNeoUseCase fetchNeoUseCase;
  final FetchLastConnectionUseCase fetchLastConnectionUseCase;

  void inited() async {
    final lastConnection = await fetchLastConnectionUseCase.call();
    final now = DateTime.now();
    value = value.copyWith(
      filterDateFrom: lastConnection,
      filterDateUntil: now,
    );
    submitted(true);
  }

  void changedFromDate(
    DateTime newDate,
  ) {
    value = value.copyWith(
      filterDateFrom: newDate,
      filterDateUntil: newDate.isAfter(value.filterDateUntil) ? newDate : value.filterDateUntil,
    );
  }

  void changedUntilDate(
    DateTime newDate,
  ) {
    value = value.copyWith(
      filterDateUntil: newDate,
    );
  }

  void submitted([bool isFirstTime = false]) async {
    value = value.copyWith(
      isLoading: true,
    );
    final result = await fetchNeoUseCase.execute(
      value.filterDateFrom,
      value.filterDateUntil,
    );
    value = value.copyWith(
      asteroidsToShow: result,
      isLoading: false,
      asteroidsSinceLastVisit: isFirstTime ? result.length : null,
    );
  }
}
