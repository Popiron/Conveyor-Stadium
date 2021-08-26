part of 'game_session_bloc.dart';

@freezed
class GameSessionState with _$GameSessionState {
  const factory GameSessionState.initial() = _Initial;
  const factory GameSessionState.nextTick({required GameSession gameSession}) =
      _NextTick;
  const factory GameSessionState.finished() = _Finished;
}
