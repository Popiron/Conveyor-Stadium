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
      final stadiums = [
        const Stadium(type: FanType.orange),
        const Stadium(type: FanType.white),
        const Stadium(type: FanType.yellow),
      ];
      stadiums.shuffle();
      _gameSession = GameSession(
          fans: <Fan?>[Fan.random()],
          stadiums: stadiums.take(2).toList(),
          score: 19,
          hearts: 3);
      yield _NextTick(gameSession: _gameSession);
      time(Duration.millisecondsPerSecond * 3, 0.995);
    }, changedDirection: (id, direction) async* {
      final fans = [..._gameSession.fans];
      fans[_gameSession.stadiums.length - 1 - id] =
          fans[_gameSession.stadiums.length - 1 - id]!
              .copyWith(direction: direction);
      _gameSession = _gameSession.copyWith(fans: fans);
    }, ticked: () async* {
      _gameSession.stadiums.forEachIndexed((index, element) {
        final fanIndex = _gameSession.stadiums.length - 1 - index;
        if (_gameSession.fans.asMap().containsKey(fanIndex) &&
            _gameSession.fans[fanIndex] != null) {
          if (_gameSession.fans[fanIndex]!.direction.isRight) {
            _gameSession.fans[fanIndex] = null;
          } else if (_gameSession.fans[fanIndex]!.direction.isLeft) {
            if (_gameSession.fans[fanIndex]!.type.index == element.type.index) {
              _addScore();
            } else {
              _gameSession =
                  _gameSession.copyWith(hearts: _gameSession.hearts - 1);
            }
            _gameSession.fans[fanIndex] = null;
          }
        }
      });
      if (_gameSession.hearts == 0) {
        add(const GameSessionEvent.finished());
      } else {
        final lastFanIndex = _gameSession.stadiums.length - 1;
        if (_gameSession.fans.asMap().containsKey(lastFanIndex)) {
          _gameSession.fans.removeLast();
        }
        _gameSession.fans.insert(0, Fan.random());
        yield _NextTick(
            gameSession: GameSession(
                score: _gameSession.score,
                hearts: _gameSession.hearts,
                fans: [..._gameSession.fans],
                stadiums: [..._gameSession.stadiums]));
      }
    }, finished: () async* {
      yield _Over(score: _gameSession.score);
    });
  }

  Future<dynamic> time(int milliseconds, double speedFactor) {
    return Future.delayed(Duration(milliseconds: milliseconds)).then((value) {
      if (milliseconds != 0 && state is! _Finished) {
        add(const _Ticked());
        time((milliseconds * speedFactor).floor(), speedFactor);
      }
    });
  }

  void _addScore() {
    _gameSession = _gameSession.copyWith(score: _gameSession.score + 1);
    if (_gameSession.score == 20) {
      var fan_types = FanType.values.toList();
      var stadium_types = _gameSession.stadiums.map((e) => e.type).toList();
      fan_types.removeWhere((element) => stadium_types.contains(element));
      fan_types.forEach((element) {
        _gameSession.stadiums.add(Stadium(type: element));
      });
    }
  }
}
