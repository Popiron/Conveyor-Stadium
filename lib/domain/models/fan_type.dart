enum FanType { white, yellow, orange }

extension FanTypeX on FanType {
  bool isWhite() => this == FanType.white;
  bool isYellow() => this == FanType.yellow;
  bool isOrange() => this == FanType.orange;
}
