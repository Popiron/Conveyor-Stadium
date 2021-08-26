import 'dart:async';

import 'package:conveyor_stadium/data/data_sources/hive_client.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@module
abstract class HiveModule {
  @preResolve
  Future<HiveClient> get client async {
    // Hive.registerAdapter(DurationAdapter());
    // Hive.registerAdapter(TrainingDTOAdapter());
    // Hive.registerAdapter(IntensityAdapter());
    // Hive.registerAdapter(FilterTargetDTOAdapter());
    // Hive.registerAdapter(FilterIntensityDTOAdapter());
    // Hive.registerAdapter(FilterCategoryDTOAdapter());
    // Hive.registerAdapter(TrainingCategoryAdapter());
    // Hive.registerAdapter(TargetAdapter());
    // Hive.registerAdapter(SavedFiltersAdapter());
    // Hive.registerAdapter(TrainingViewDTOAdapter());
    // Hive.registerAdapter(PartnerDTOAdapter());

    await Hive.initFlutter();

    //await Future.wait(HiveClient.eagerBoxes);
    return HiveClient();
  }
}
