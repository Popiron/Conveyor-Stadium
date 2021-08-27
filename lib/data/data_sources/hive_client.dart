import 'package:conveyor_stadium/domain/models/top_scores.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

// Registered inside module

class HiveClient {
  static const key = "stats";
  static const _scores = "scores";

  static final eagerBoxes = [
    Hive.openBox<TopScores>(_scores),
  ];

  Box<TopScores> get topScoresBox => Hive.box<TopScores>(_scores);
}

// extension FiltersBox on Box<SavedFilters> {
//   static const filter = "filter";
//   Future<void> saveFilters(List<FilterDTO> filters) async {
//     return put(filter, SavedFilters(filters));
//   }

//   Future<void> resetFilters() async {
//     return delete(filter);
//   }

//   List<FilterDTO>? getFilters() {
//     return get(filter)?.filters;
//   }
// }
