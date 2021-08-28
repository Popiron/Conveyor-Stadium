import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:conveyor_stadium/domain/constants.dart';
import 'package:conveyor_stadium/domain/interfaces/music_service.dart';
import 'package:conveyor_stadium/domain/interfaces/scores_repository.dart';
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
  final ResultsRepository _resultsRepository;
  final MusicService _musicService;
  GameSessionBloc(this._resultsRepository, this._musicService)
      : super(_Initial());
  late GameSession _gameSession;
  final _stadiums = [
    const Stadium(type: FanType.orange),
    const Stadium(type: FanType.white),
    const Stadium(type: FanType.yellow),
  ];
  @override
  Stream<GameSessionState> mapEventToState(
    GameSessionEvent event,
  ) async* {
    yield* event.when(started: () async* {
      _initGameSession();
      yield _NextTick(gameSession: _gameSession);
      _gameTime(GAME_TIME, GAME_SPEED);
    }, changedDirection: (stadiumId, direction) async* {
      _updateFansDirection(stadiumId, direction);
    }, ticked: () async* {
      _checkFanTypes();
      if (_gameSession.hearts == 0) {
        add(const GameSessionEvent.finished());
      } else {
        _moveQueue();
        yield _NextTick(
            gameSession: GameSession(
                score: _gameSession.score,
                hearts: _gameSession.hearts,
                fans: [..._gameSession.fans],
                stadiums: [..._gameSession.stadiums]));
      }
    }, finished: () async* {
      final results = await _resultsRepository.getResults();
      if (!results.scores.contains(_gameSession.score)) {
        results.scores.add(_gameSession.score);
        await _resultsRepository.saveResults(results);
      }
      yield _Over(score: _gameSession.score);
    });
  }

  void _initGameSession() {
    _stadiums.shuffle();
    _gameSession = GameSession(
        fans: <Fan?>[Fan.random()],
        stadiums: _stadiums.take(2).toList(),
        score: 0,
        hearts: 3);
  }

  Future<dynamic> _gameTime(int milliseconds, double speedFactor) {
    return Future.delayed(Duration(milliseconds: milliseconds)).then((value) {
      if (milliseconds != 0 && state is! _Finished) {
        add(const _Ticked());
        _gameTime((milliseconds * speedFactor).floor(), speedFactor);
      } else {
        add(const _Finished());
      }
    });
  }

  void _updateFansDirection(int stadiumId, Direction direction) {
    final fans = [..._gameSession.fans];
    fans[_gameSession.stadiums.length - 1 - stadiumId] =
        fans[_gameSession.stadiums.length - 1 - stadiumId]!
            .copyWith(direction: direction);
    _gameSession = _gameSession.copyWith(fans: fans);
  }

  void _checkFanTypes() {
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
            _reduceHeart();
          }
          _gameSession.fans[fanIndex] = null;
        }
      }
    });
  }

  void _addScore() {
    _musicService.gainedOneScoreSound();
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

  void _reduceHeart() {
    _musicService.reducedOneHeartSound();
    _gameSession = _gameSession.copyWith(hearts: _gameSession.hearts - 1);
  }

  void _moveQueue() {
    final lastFanIndex = _gameSession.stadiums.length - 1;
    if (_gameSession.fans.asMap().containsKey(lastFanIndex)) {
      _gameSession.fans.removeLast();
    }
    _gameSession.fans.insert(0, Fan.random());
  }
}
