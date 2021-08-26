import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:conveyor_stadium/domain/models/direction.dart';
import 'package:conveyor_stadium/domain/models/fan.dart';
import 'package:conveyor_stadium/domain/models/fan_type.dart';
import 'package:conveyor_stadium/domain/models/game_session.dart';
import 'package:conveyor_stadium/domain/models/stadium.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'game_session_event.dart';
part 'game_session_state.dart';
part 'game_session_bloc.freezed.dart';

@injectable
class GameSessionBloc extends Bloc<GameSessionEvent, GameSessionState> {
  GameSessionBloc() : super(_Initial());
  late GameSession _gameSession;
  @override
  Stream<GameSessionState> mapEventToState(
    GameSessionEvent event,
  ) async* {
    yield* event.when(started: () async* {
      var stadiums = [
        const Stadium(type: FanType.orange),
        const Stadium(type: FanType.white),
        const Stadium(type: FanType.yellow),
      ];
      stadiums.shuffle();
      _gameSession = GameSession(
          fans: [Fan.random()],
          stadiums: stadiums.take(2).toList(),
          score: 15,
          hearts: 2);
      yield _NextTick(gameSession: _gameSession);
      time(Duration.millisecondsPerSecond * 3, 0.95);
    }, changedDirection: (id, direction) async* {
      final fans = [..._gameSession.fans];
      fans[_gameSession.stadiums.length - 1 - id] =
          fans[_gameSession.stadiums.length - 1 - id]
              .copyWith(direction: direction);
      _gameSession = _gameSession.copyWith(fans: fans);
    }, ticked: () async* {
      if (_gameSession.fans.length == 3) {
        _gameSession.fans.removeLast();
      }
      _gameSession.fans.insert(0, Fan.random());
      yield* state.maybeMap(nextTick: (state) async* {
        var s = _NextTick(
            gameSession: GameSession(
                score: _gameSession.score,
                hearts: _gameSession.hearts,
                fans: [..._gameSession.fans],
                stadiums: [..._gameSession.stadiums]));
        yield s;
      }, orElse: () async* {
        yield _NextTick(
            gameSession: GameSession(
                score: _gameSession.score,
                hearts: _gameSession.hearts,
                fans: _gameSession.fans,
                stadiums: _gameSession.stadiums));
      });
    });
  }

  void time(int milliseconds, double speedFactor) {
    Future.delayed(Duration(milliseconds: milliseconds)).then((value) {
      if (milliseconds != 0) {
        add(const _Ticked());
        time((milliseconds * speedFactor).floor(), speedFactor);
      }
    });
  }
}
