import 'package:conveyor_stadium/domain/models/top_scores.dart';

abstract class ScoresRepository {
  Future<TopScores> getScores();
  Future<void> saveScores(TopScores scores);
}
