import 'package:astro_app/shared/domain/neo_approach_data.dart';

class NEO {
  final String id;
  final NEOApproachData approachData;
  final double diameterMinMeters;
  final double diameterMaxMeters;
  final String name;
  final bool isHazardous;
  final bool isSentry;
  NEO({
    required this.id,
    required this.approachData,
    required this.diameterMinMeters,
    required this.diameterMaxMeters,
    required this.name,
    required this.isHazardous,
    required this.isSentry,
  });

  NEO copyWith({
    String? id,
    NEOApproachData? approachData,
    double? diameterMinMeters,
    double? diameterMaxMeters,
    String? name,
    bool? isHazardous,
    bool? isSentry,
  }) {
    return NEO(
      id: id ?? this.id,
      approachData: approachData ?? this.approachData,
      diameterMinMeters: diameterMinMeters ?? this.diameterMinMeters,
      diameterMaxMeters: diameterMaxMeters ?? this.diameterMaxMeters,
      name: name ?? this.name,
      isHazardous: isHazardous ?? this.isHazardous,
      isSentry: isSentry ?? this.isSentry,
    );
  }

  @override
  String toString() {
    return 'NEO(id: $id, approachData: $approachData, diameterMinMeters: $diameterMinMeters, diameterMaxMeters: $diameterMaxMeters, name: $name, isHazardous: $isHazardous, isSentry: $isSentry)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NEO &&
        other.id == id &&
        other.approachData == approachData &&
        other.diameterMinMeters == diameterMinMeters &&
        other.diameterMaxMeters == diameterMaxMeters &&
        other.name == name &&
        other.isHazardous == isHazardous &&
        other.isSentry == isSentry;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        approachData.hashCode ^
        diameterMinMeters.hashCode ^
        diameterMaxMeters.hashCode ^
        name.hashCode ^
        isHazardous.hashCode ^
        isSentry.hashCode;
  }
}
