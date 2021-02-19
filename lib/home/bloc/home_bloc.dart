import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:template_repository/template_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

const _templatesToLoad = 10;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TemplateRepository templateRepository;

  HomeBloc({@required this.templateRepository}) : super(HomeInitial());

  @override
  Stream<Transition<HomeEvent, HomeState>> transformEvents(
      Stream<HomeEvent> events,
      TransitionFunction<HomeEvent, HomeState> transitionFn,
      ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    final currentState = state;
    if (event is FetchTemplates && !_hasReachedMax(currentState)) {
      try {
        if (currentState is HomeInitial) {
          final templates = await _fetchTemplates();
          yield HomeSuccess(templates: templates, hasReachedMax: false);
          return;
        }
        if (currentState is HomeSuccess) {
          final templates =
              await _fetchTemplates(currentState.templates.last.date);
          yield templates.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : HomeSuccess(
                  templates: currentState.templates + templates,
                  hasReachedMax: false,
                );
        }
      } catch (e) {
        print(e);
        yield HomeFailure();
      }
    }
  }

  Future<List<Template>> _fetchTemplates([DateTime lastDate]) {
    return templateRepository.findTemplates(_templatesToLoad, null, lastDate).first;
  }

  bool _hasReachedMax(HomeState state) =>
      state is HomeSuccess && state.hasReachedMax;
}
