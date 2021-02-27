import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzgram/app.dart';
import 'package:template_repository/template_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  await FirebaseTemplateRepository().initialize();
  await SqliteLocalTemplateRepository().initialize();
  runApp(App());
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print('onEvent $event');
    super.onEvent(bloc, event);
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    print('onTransition $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('onError $error');
    super.onError(cubit, error, stackTrace);
  }
}
