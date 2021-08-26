enum Direction {
  forward,
  right,
  left,
}

extension DirectionX on Direction {
  bool get isForward => this == Direction.forward;
  bool get isRight => this == Direction.right;
  bool get isLeft => this == Direction.left;
}
