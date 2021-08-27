part of 'game_session_bloc.dart';

@freezed
class GameSessionEvent with _$GameSessionEvent {
  const factory GameSessionEvent.started() = _Started;
  const factory GameSessionEvent.changedDirection(int id, Direction direction) =
      _ChangedDirection;
  const factory GameSessionEvent.ticked() = _Ticked;
  const factory GameSessionEvent.finished() = _Finished;
}
