import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:template_repository/template_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

const _templatesToLoad = 10;

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final TemplateRepository templateRepository;

  CategoryBloc({@required this.templateRepository}) : super(CategoryInitial());

  @override
  Stream<Transition<CategoryEvent, CategoryState>> transformEvents(
      Stream<CategoryEvent> events,
      TransitionFunction<CategoryEvent, CategoryState> transitionFn,
      ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    final currentState = state;
    if (event is FetchTemplatesByCategory && !_hasReachedMax(currentState)) {
      try {
        if (currentState is CategoryInitial) {
          final templates = await _fetchTemplatesByCategory(event.category);
          yield CategorySuccess(templates: templates, hasReachedMax: false);
          return;
        }
        if (currentState is CategorySuccess) {
          final templates =
          await _fetchTemplatesByCategory(event.category, currentState.templates.last.date);
          yield templates.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : CategorySuccess(
            templates: currentState.templates + templates,
            hasReachedMax: false,
          );
        }
      } catch (e) {
        print(e);
        yield CategoryFailure();
      }
    }
  }

  Future<List<Template>> _fetchTemplatesByCategory(String category, [DateTime lastDate]) {
    return templateRepository.findTemplates(_templatesToLoad, category.toUpperCase(), lastDate).first;
  }

  bool _hasReachedMax(CategoryState state) =>
      state is CategorySuccess && state.hasReachedMax;
}
