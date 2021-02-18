import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:template_repository/template_repository.dart';

part 'explore_event.dart';
part 'explore_state.dart';

const _templatesToLoad = 20;

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final TemplateRepository templateRepository;

  ExploreBloc({@required this.templateRepository}) : super(ExploreInitial());

  @override
  Stream<Transition<ExploreEvent, ExploreState>> transformEvents(
      Stream<ExploreEvent> events,
      TransitionFunction<ExploreEvent, ExploreState> transitionFn,
      ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ExploreState> mapEventToState(ExploreEvent event) async* {
    final currentState = state;
    if (event is FetchTemplates && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ExploreInitial) {
          final templates = await _fetchTemplates();
          yield ExploreSuccess(templates: templates, hasReachedMax: false);
          return;
        }
        if (currentState is ExploreSuccess) {
          final templates =
              await _fetchTemplates(currentState.templates.last.date);
          yield templates.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ExploreSuccess(
                  templates: currentState.templates + templates,
                  hasReachedMax: false,
                );
        }
      } catch (e) {
        yield ExploreFailure();
      }
    }
  }

  Future<List<Template>> _fetchTemplates([DateTime lastDate]) {
    return templateRepository.findTemplates(_templatesToLoad, lastDate).first;
  }

  bool _hasReachedMax(ExploreState state) =>
      state is ExploreSuccess && state.hasReachedMax;
}
