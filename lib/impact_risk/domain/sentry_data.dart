class SentryData {
  final double diameter;
  final double impactRiskPercentage;
  final int impactRangeFrom;
  final int impactRangeTo;
  final String name;
  SentryData({
    required this.diameter,
    required this.impactRiskPercentage,
    required this.impactRangeFrom,
    required this.impactRangeTo,
    required this.name,
  });

  SentryData copyWith({
    double? diameter,
    double? impactRiskPercentage,
    int? impactRangeFrom,
    int? impactRangeTo,
    String? name,
  }) {
    return SentryData(
      diameter: diameter ?? this.diameter,
      impactRiskPercentage: impactRiskPercentage ?? this.impactRiskPercentage,
      impactRangeFrom: impactRangeFrom ?? this.impactRangeFrom,
      impactRangeTo: impactRangeTo ?? this.impactRangeTo,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'SentryData(diameter: $diameter, impactRiskPercentage: $impactRiskPercentage, impactRangeFrom: $impactRangeFrom, impactRangeTo: $impactRangeTo, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SentryData &&
        other.diameter == diameter &&
        other.impactRiskPercentage == impactRiskPercentage &&
        other.impactRangeFrom == impactRangeFrom &&
        other.impactRangeTo == impactRangeTo &&
        other.name == name;
  }

  @override
  int get hashCode {
    return diameter.hashCode ^
        impactRiskPercentage.hashCode ^
        impactRangeFrom.hashCode ^
        impactRangeTo.hashCode ^
        name.hashCode;
  }
}
