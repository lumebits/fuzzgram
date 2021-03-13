import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:template_repository/template_repository.dart';

part 'infinite_event.dart';

part 'infinite_state.dart';

const templatesToLoad = 10;

class InfiniteBloc extends Bloc<InfiniteEvent, InfiniteState> {
  final TemplateRepository templateRepository;

  InfiniteBloc(this.templateRepository) : super(InfiniteInitial());

  @override
  Stream<Transition<InfiniteEvent, InfiniteState>> transformEvents(
    Stream<InfiniteEvent> events,
    TransitionFunction<InfiniteEvent, InfiniteState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<InfiniteState> mapEventToState(InfiniteEvent event) async* {
    final currentState = state;
    if (event is FetchTemplates && !_hasReachedMax(currentState)) {
      try {
        if (currentState is InfiniteInitial) {
          final templates = await fetchTemplates();
          yield InfiniteSuccess(
              templates: templates,
              hasReachedMax: templates.length < templatesToLoad);
          return;
        }
        if (currentState is InfiniteSuccess) {
          final templates = await fetchTemplates(
              currentState.templates.last.date, currentState.templates.length);
          yield templates.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : InfiniteSuccess(
                  templates: currentState.templates + templates,
                  hasReachedMax: templates.length < templatesToLoad,
                );
        }
      } catch (e) {
        print(e);
        yield InfiniteFailure();
      }
    }
  }

  Future<List<Template>> fetchTemplates([DateTime lastDate, int offset]) {
    return templateRepository
        .findTemplates(templatesToLoad, null, lastDate, offset)
        .first;
  }

  bool _hasReachedMax(InfiniteState state) =>
      state is InfiniteSuccess && state.hasReachedMax;
}
