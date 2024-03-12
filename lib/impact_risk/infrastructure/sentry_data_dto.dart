import 'package:astro_app/impact_risk/domain/sentry_data.dart';

class SentryDataDto {
  const SentryDataDto._({
    required this.diameter,
    required this.impactRiskPercentage,
    required this.impactRangeFrom,
    required this.impactRangeTo,
    required this.name,
  });
  final double diameter;
  final double impactRiskPercentage;
  final int impactRangeFrom;
  final int impactRangeTo;
  final String name;

  static SentryDataDto fromJson(Map<String, dynamic> json) {
    final range = json['range'] as String;
    final splitDates = range.split('-');
    final rangeFrom = int.parse(
      splitDates[0],
    );
    final rangeTo = int.parse(
      splitDates[1],
    );
    final diameterString = (json['diameter'] as String);
    final diameter = double.parse(
      diameterString,
    );
    final ipString = json['ip'] as String;
    final impactRiskPercentage = double.parse(
      ipString,
    );
    return SentryDataDto._(
      diameter: diameter * 1000,
      impactRiskPercentage: impactRiskPercentage,
      impactRangeFrom: rangeFrom,
      impactRangeTo: rangeTo,
      name: json['fullname'] as String,
    );
  }

  SentryData toDomain() {
    return SentryData(
      diameter: diameter,
      impactRiskPercentage: impactRiskPercentage,
      impactRangeFrom: impactRangeFrom,
      impactRangeTo: impactRangeTo,
      name: name,
    );
  }
}
