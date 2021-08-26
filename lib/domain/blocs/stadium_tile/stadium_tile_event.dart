part of 'stadium_tile_bloc.dart';

@freezed
class StadiumTileEvent with _$StadiumTileEvent {
  const factory StadiumTileEvent.started() = _Started;
  const factory StadiumTileEvent.changedDirection() = _ChangedDirection;
}
