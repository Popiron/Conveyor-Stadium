import 'package:hive_flutter/hive_flutter.dart';

part 'top_scores.g.dart';

@HiveType(typeId: 0)
class Results {
  @HiveField(0)
  final List<int> scores;
  Results(this.scores);
}
