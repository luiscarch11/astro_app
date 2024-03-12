enum Planet {
  mercury,
  venus,
  earth,
  mars;

  factory Planet.fromIndex(int index) {
    return switch (index) {
      0 => Planet.mars,
      1 => Planet.earth,
      2 => Planet.venus,
      3 => Planet.mercury,
      _ => throw Exception('Invalid index'),
    };
  }
  int get orbitIndex {
    return switch (this) {
      Planet.mercury => 3,
      Planet.venus => 2,
      Planet.earth => 1,
      Planet.mars => 0,
    };
  }
}
