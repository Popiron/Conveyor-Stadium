import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:conveyor_stadium/data/data_sources/hive_client.dart';
import 'package:conveyor_stadium/domain/interfaces/scores_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'results_event.dart';
part 'results_state.dart';
part 'results_bloc.freezed.dart';

@injectable
class ResultsBloc extends Bloc<ResultEvent, ResultState> {
  final ResultsRepository _resultsRepository;
  ResultsBloc(this._resultsRepository) : super(_Initial());

  @override
  Stream<ResultState> mapEventToState(
    ResultEvent event,
  ) async* {
    yield* event.when(started: () async* {
      final results = await _resultsRepository.getResults();
      final scores = results.scores.sorted((a, b) => b.compareTo(a)).take(3);
      yield ResultState.ready(scores: scores.toList());
    });
  }
}
