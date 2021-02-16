import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:template_repository/template_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

const _templatesLimit = 2000;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TemplateRepository templateRepository;

  HomeBloc(this.templateRepository)
      : assert(templateRepository != null),
        super(HomeState()) {
    _fetchTemplates();
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (state.hasReachedMax) yield state;

    if (event is TemplatesFetched) {
      final templates = List.of(state.templates)..addAll(event.data);
      yield state.copyWith(
          status: HomeStatus.success,
          templates: templates,
          hasReachedMax: _hasReachedMax(templates.length));
    }
  }

  void _fetchTemplates([DateTime lastDate]) {
    templateRepository
        .findTemplates(_templatesLimit, lastDate)
        .listen((data) => add(TemplatesFetched(data)));
  }

  bool _hasReachedMax(int templatesCount) =>
      templatesCount < _templatesLimit ? false : true;
}
