class NEOApproachData {
  final double distanceKM;
  final DateTime date;
  NEOApproachData({
    required this.distanceKM,
    required this.date,
  });

  NEOApproachData copyWith({
    double? distanceKM,
    DateTime? date,
  }) {
    return NEOApproachData(
      distanceKM: distanceKM ?? this.distanceKM,
      date: date ?? this.date,
    );
  }

  @override
  String toString() => 'NEOApproachData(distanceKM: $distanceKM, date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NEOApproachData && other.distanceKM == distanceKM && other.date == date;
  }

  @override
  int get hashCode => distanceKM.hashCode ^ date.hashCode;
}
