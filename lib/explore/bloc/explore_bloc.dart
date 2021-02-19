import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {

  ExploreBloc() : super(ExploreInitial());

  @override
  Stream<ExploreState> mapEventToState(ExploreEvent event) async* {
    if (event is CategoryTapped) {
      yield ExploringCategory(event.category);
    }
  }
}
