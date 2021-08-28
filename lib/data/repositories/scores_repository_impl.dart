import 'package:conveyor_stadium/data/data_sources/hive_client.dart';
import 'package:conveyor_stadium/domain/interfaces/scores_repository.dart';
import 'package:conveyor_stadium/domain/models/top_scores.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ResultsRepository)
class ResultsRepositoryImpl implements ResultsRepository {
  final HiveClient _hiveClient;

  ResultsRepositoryImpl(this._hiveClient);

  @override
  Future<Results> getResults() async {
    final results = _hiveClient.resultsBox.values;
    if (results.isNotEmpty) {
      return _hiveClient.resultsBox.values.first;
    } else {
      await saveResults(Results([0, 0, 0]));
      return _hiveClient.resultsBox.values.first;
    }
  }

  @override
  Future<void> saveResults(Results results) {
    return _hiveClient.resultsBox.put(HiveClient.key, results);
  }
}
