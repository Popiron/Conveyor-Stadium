import 'dart:async';

import 'package:conveyor_stadium/data/data_sources/hive_client.dart';
import 'package:conveyor_stadium/domain/models/top_scores.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@module
abstract class HiveModule {
  @preResolve
  Future<HiveClient> get client async {
    Hive.registerAdapter(TopScoresAdapter());

    await Hive.initFlutter();

    await Future.wait(HiveClient.eagerBoxes);
    return HiveClient();
  }
}
