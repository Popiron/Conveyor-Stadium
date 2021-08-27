import 'package:conveyor_stadium/data/data_sources/hive_client.dart';
import 'package:conveyor_stadium/domain/interfaces/scores_repository.dart';
import 'package:conveyor_stadium/domain/models/top_scores.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ScoresRepository)
class ScoresRepositoryImpl implements ScoresRepository {
  final HiveClient _hiveClient;

  ScoresRepositoryImpl(this._hiveClient);

  @override
  Future<TopScores> getScores() async {
    final scores = _hiveClient.topScoresBox.values;
    if (scores.isNotEmpty) {
      return _hiveClient.topScoresBox.values.first;
    } else {
      await saveScores(TopScores([0, 0, 0]));
      return _hiveClient.topScoresBox.values.first;
    }
  }

  @override
  Future<void> saveScores(TopScores scores) {
    return _hiveClient.topScoresBox.put(HiveClient.key, scores);
  }
}
