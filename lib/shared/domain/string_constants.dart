import 'package:intl/intl.dart';

class StringConstants {
  static String _dateToStr(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String closeToEarthAsteroidsURL(
    DateTime fromDate,
    DateTime toDate,
  ) {
    final fromDateStr = _dateToStr(fromDate);
    final toDateStr = _dateToStr(toDate);
    return '$_closeToEarthAsteroids&start_date=$fromDateStr&end_date=$toDateStr';
  }

  static const geminiPrompt = 'Te voy a hacer una pregunta relacionada con Astronomía. Mi pregunta es la siguiente: ';
  String asteroidsDistanceSearchURL(
    DateTime from,
    DateTime to,
    double maxDistance,
  ) {
    return '$_asteroidsDistanceSearchBaseURL?date-min=${_dateToStr(from)}&date-max=${_dateToStr(to)}&dist-max=$maxDistance';
  }

  static String asteroidsSentryURL(
    double impactProb,
  ) {
    return '$_asteroidsSentryBaseURL?ip-min=$impactProb';
  }

  static const planetLoaderAnimationPath = 'assets/planet_loader.json';
  static const earthAnimationPath = 'assets/earth_animation.json';
  static const marsAnimationPath = 'assets/mars_animation.json';
  static const sunAnimationPath = 'assets/sun_animation.json';
  static const asteroidImagePath = 'assets/asteroid_image.png';
  static const telescopeIconPath = 'assets/telescope_icon.svg';

  static const _asteroidsDistanceSearchBaseURL = 'https://ssd-api.jpl.nasa.gov/cad.api';
  static const _closeToEarthAsteroids = 'https://api.nasa.gov/neo/rest/v1/feed?api_key=${const String.fromEnvironment(
    'NASA_API_KEY',
  )}';
  static const _asteroidsSentryBaseURL = 'https://ssd-api.jpl.nasa.gov/sentry.api';
}
