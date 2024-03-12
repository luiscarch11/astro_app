import 'dart:convert';

import 'package:astro_app/impact_risk/domain/fetch_sentry_data_use_case.dart';
import 'package:astro_app/impact_risk/domain/sentry_data.dart';
import 'package:astro_app/impact_risk/infrastructure/sentry_data_dto.dart';
import 'package:astro_app/shared/domain/string_constants.dart';
import 'package:http/http.dart' as http;

class NasaAPIFetchSentryDataUseCase implements FetchSentryDataUseCase {
  @override
  Future<List<SentryData>> call(double minimumPercentage) async {
    final client = http.Client();

    final uri = Uri.parse(
      StringConstants.asteroidsSentryURL(
        minimumPercentage / 100,
      ),
    );
    try {
      final result = await client.get(uri);

      final data = jsonDecode(result.body) as Map<String, dynamic>;
      return (data['data'] as List)
          .map(
            (e) => SentryDataDto.fromJson(e).toDomain(),
          )
          .toList();
    } catch (_) {
      return [];
    }
  }
}
