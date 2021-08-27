import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:conveyor_stadium/data/data_sources/hive_client.dart';
import 'package:conveyor_stadium/domain/interfaces/scores_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'top_scores_event.dart';
part 'top_scores_state.dart';
part 'top_scores_bloc.freezed.dart';

@injectable
class TopScoresBloc extends Bloc<TopScoresEvent, TopScoresState> {
  final ScoresRepository _scoresRepository;
  TopScoresBloc(this._scoresRepository) : super(_Initial());

  @override
  Stream<TopScoresState> mapEventToState(
    TopScoresEvent event,
  ) async* {
    yield* event.when(started: () async* {
      final topScores = await _scoresRepository.getScores();
      final scores = topScores.scores.sorted((a, b) => b.compareTo(a)).take(3);
      yield TopScoresState.ready(scores: scores.toList());
    });
  }
}
