import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

// Registered inside module

class HiveClient {
  // static const lastWatchDate = "__lastWatchDate";
  // static const isNewToApp = "__isNewToApp";
  // static const notRegisteredTrackedTime = "__notRegisteredTrackedTime";

  static const _scores = "scores";

  static final eagerBoxes = [
    // Hive.openBox<AuthorizedUser>(_users),
    // Hive.openBox<TrainingDTO>(_trainings),
    // Hive.openBox(_settings),
    // Hive.openBox<SavedFilters>(_filters),
    // Hive.openBox<TrainingViewDTO>(_views),
    // Hive.openBox<String>(_oneTimeEvents),
  ];

  // Box<AuthorizedUser> get usersBox => Hive.box<AuthorizedUser>(_users);
  // Box<TrainingDTO> get trainingsBox => Hive.box<TrainingDTO>(_trainings);
  // Box<dynamic> get settingsBox => Hive.box<dynamic>(_settings);
  // Box<String> get oneTimeEvents => Hive.box<String>(_oneTimeEvents);
  // Box<SavedFilters> get filtersBox => Hive.box<SavedFilters>(_filters);
  // Box<TrainingViewDTO> get viewsBox => Hive.box<TrainingViewDTO>(_views);
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
