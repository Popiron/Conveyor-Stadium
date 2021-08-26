import 'package:conveyor_stadium/domain/models/fan.dart';
import 'package:conveyor_stadium/domain/models/stadium.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_session.freezed.dart';

@freezed
class GameSession with _$GameSession {
  const factory GameSession(
      {required int score,
      required int hearts,
      required List<Fan> fans,
      required List<Stadium> stadiums}) = _GameSession;

  const GameSession._();
}
