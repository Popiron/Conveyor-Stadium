import 'package:conveyor_stadium/domain/models/top_scores.dart';

abstract class ResultsRepository {
  Future<Results> getResults();
  Future<void> saveResults(Results scores);
}
