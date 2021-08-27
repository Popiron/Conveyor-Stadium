import 'package:conveyor_stadium/app.dart';
import 'package:conveyor_stadium/bloc_observer.dart';
import 'package:conveyor_stadium/configure_dependencies.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  configureDependencies();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU')],
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        child: App()),
  );
}
