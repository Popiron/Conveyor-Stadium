import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:conveyor_stadium/domain/interfaces/music_service.dart';
import 'package:conveyor_stadium/domain/models/direction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'stadium_tile_event.dart';
part 'stadium_tile_state.dart';
part 'stadium_tile_bloc.freezed.dart';

@injectable
class StadiumTileBloc extends Bloc<StadiumTileEvent, StadiumTileState> {
  final MusicService _musicService;
  StadiumTileBloc(this._musicService) : super(StadiumTileState.initial());
  late Direction _currentDirection;
  @override
  Stream<StadiumTileState> mapEventToState(
    StadiumTileEvent event,
  ) async* {
    yield* event.when(started: () async* {
      _currentDirection = Direction.forward;
      yield const _DirectionForward();
    }, changedDirection: () async* {
      _musicService.changedPathSound();
      if (_currentDirection.isForward) {
        _currentDirection = Direction.right;
        yield const _DirectionRight();
      } else if (_currentDirection.isRight) {
        _currentDirection = Direction.left;
        yield const _DirectionLeft();
      } else if (_currentDirection.isLeft) {
        _currentDirection = Direction.forward;
        yield const _DirectionForward();
      }
    });
  }
}
