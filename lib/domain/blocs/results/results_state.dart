part of 'results_bloc.dart';

@freezed
class ResultState with _$ResultState {
  const factory ResultState.initial() = _Initial;
  const factory ResultState.ready({required List<int> scores}) = _Ready;
}
