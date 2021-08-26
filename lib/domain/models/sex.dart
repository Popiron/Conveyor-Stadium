enum Sex { male, female }

extension SexX on Sex {
  bool get isMale => this == Sex.male;
  bool get isFemale => this == Sex.female;
}
