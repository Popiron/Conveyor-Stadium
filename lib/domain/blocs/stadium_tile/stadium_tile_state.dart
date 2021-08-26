part of 'stadium_tile_bloc.dart';

@freezed
class StadiumTileState with _$StadiumTileState {
  factory StadiumTileState.initial() => const _DirectionForward();
  const factory StadiumTileState.directionLeft() = _DirectionLeft;
  const factory StadiumTileState.directionRight() = _DirectionRight;
  const factory StadiumTileState.directionForward() = _DirectionForward;
}
