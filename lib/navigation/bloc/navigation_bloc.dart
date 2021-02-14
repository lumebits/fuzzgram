import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fuzzgram/navigation/bloc/navigation_event.dart';
import 'package:fuzzgram/navigation/model/app_tab.dart';

class NavigationBloc extends Bloc<NavigationEvent, AppTab> {
  NavigationBloc() : super(AppTab.home);

  @override
  Stream<AppTab> mapEventToState(NavigationEvent event) async* {
    if (event is TabTapped) {
      yield event.tab;
    }
  }
}