import 'package:bloc/bloc.dart';
import 'package:conveyor_stadium/logger.dart';
import 'package:flutter/foundation.dart';

class CustomBlocObserver extends BlocObserver {
  bool get debugOnCreate => kDebugMode && true;
  bool get debugOnEvent => kDebugMode && false;
  bool get debugOnChange => kDebugMode && false;
  bool get debugOnTransition => kDebugMode && false;
  bool get debugOnError => true;
  bool get debugOnClose => kDebugMode && true;

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (debugOnCreate) logger.d('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (debugOnEvent) logger.d('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (debugOnChange) logger.d('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (debugOnTransition)
      logger.d('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (debugOnError)
      logger.e('onError -- ${bloc.runtimeType}, $error', error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (debugOnClose) logger.d('onClose -- ${bloc.runtimeType}');
  }
}
