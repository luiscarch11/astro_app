import 'dart:convert';

import 'package:astro_app/shared/domain/fetch_neo_use_case.dart';
import 'package:astro_app/shared/domain/neo.dart';
import 'package:astro_app/shared/domain/string_constants.dart';
import 'package:astro_app/shared/infrastructure/neo_dto.dart';
import 'package:http/http.dart' as http;

class NasaAPIFetchNEOUseCase implements FetchNeoUseCase {
  @override
  Future<List<NEO>> execute(
    DateTime from,
    DateTime until,
  ) async {
    final url = StringConstants.closeToEarthAsteroidsURL(
      from,
      until,
    );
    final client = http.Client();
    try {
      final uri = Uri.parse(url);
      final result = await client.get(uri);
      final data = result.body;
      final json = jsonDecode(data) as Map<String, dynamic>;
      final neoDates = (json['near_earth_objects'] as Map<String, dynamic>);

      final neosToReturn = neoDates.values
          .expand<NEO>(
            (element) => (element as List)
                .map(
                  (e) => NEODto.fromJson(e).toDomain(),
                )
                .toList(),
          )
          .toList();
      return neosToReturn;
    } catch (_) {
      return [];
    }
  }
}
