part of 'top_scores_bloc.dart';

@freezed
class TopScoresEvent with _$TopScoresEvent {
  const factory TopScoresEvent.started() = _Started;
}