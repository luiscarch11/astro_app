import 'package:astro_app/shared/domain/neo.dart';
import 'package:astro_app/shared/infrastructure/neo_approach_data_dto.dart';

class NEODto {
  const NEODto._({
    required this.diameterMin,
    required this.diameterMax,
    required this.name,
    required this.isHazardous,
    required this.isSentry,
    required this.id,
    required this.approachDataDto,
  });
  final String id;
  final NEOApproachDataDto approachDataDto;

  final double diameterMin;
  final double diameterMax;
  final String name;
  final bool isHazardous;
  final bool isSentry;

  static NEODto fromJson(Map<String, dynamic> json) {
    final diameterValues = json['estimated_diameter'] as Map<String, dynamic>;
    final diameterMin = diameterValues['meters']['estimated_diameter_min'] as double;
    final diameterMax = diameterValues['meters']['estimated_diameter_max'] as double;

    return NEODto._(
      approachDataDto: NEOApproachDataDto.fromJson(
        json['close_approach_data'][0] as Map<String, dynamic>,
      ),
      id: json['id'],
      diameterMin: diameterMin,
      diameterMax: diameterMax,
      name: json['name'],
      isHazardous: json['is_potentially_hazardous_asteroid'],
      isSentry: json['is_sentry_object'],
    );
  }

  NEO toDomain() {
    return NEO(
      id: id,
      approachData: approachDataDto.toDomain(),
      diameterMinMeters: diameterMin,
      diameterMaxMeters: diameterMax,
      name: name,
      isHazardous: isHazardous,
      isSentry: isSentry,
    );
  }
}
