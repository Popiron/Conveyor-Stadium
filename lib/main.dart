import 'package:conveyor_stadium/app.dart';
import 'package:conveyor_stadium/bloc_observer.dart';
import 'package:conveyor_stadium/configure_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = CustomBlocObserver();
  configureDependencies();
  runApp(
    App(),
  );
}
