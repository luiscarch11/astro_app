import 'package:astro_app/impact_risk/domain/sentry_data.dart';

abstract interface class FetchSentryDataUseCase {
  Future<List<SentryData>> call(double minimumPercentage);
}
