part of 'top_scores_bloc.dart';

@freezed
class TopScoresState with _$TopScoresState {
  const factory TopScoresState.initial() = _Initial;
  const factory TopScoresState.ready({required List<int> scores}) = _Ready;
}
