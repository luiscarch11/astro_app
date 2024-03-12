import 'package:astro_app/shared/domain/neo_approach_data.dart';

class NEOApproachDataDto {
  const NEOApproachDataDto._({
    required this.distanceKM,
    required this.date,
  });
  final double distanceKM;
  final DateTime date;

  static NEOApproachDataDto fromJson(Map<String, dynamic> json) {
    final kmString = json['miss_distance']['kilometers'] as String;
    final distanceKM = double.parse(
      kmString,
    );
    return NEOApproachDataDto._(
      distanceKM: distanceKM,
      date: DateTime.fromMillisecondsSinceEpoch(
        json['epoch_date_close_approach'] as int,
      ),
    );
  }

  NEOApproachData toDomain() {
    return NEOApproachData(
      distanceKM: distanceKM,
      date: date,
    );
  }
}
