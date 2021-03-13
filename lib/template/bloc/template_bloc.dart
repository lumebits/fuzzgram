import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:template_repository/template_repository.dart';

part 'template_event.dart';
part 'template_state.dart';

class TemplateBloc extends Bloc<TemplateEvent, TemplateState> {
  final TemplateRepository templateRepository;
  final Template template;

  TemplateBloc(this.templateRepository, this.template) : super(TemplateNotStarred());

  @override
  Stream<TemplateState> mapEventToState(TemplateEvent event) async* {
    if (event is LoadStarredStatus) {
      final isStarred = await _isTemplateStarred();
      yield isStarred ? TemplateStarred() : TemplateNotStarred();
    } else if (event is StarTemplate) {
      templateRepository.insert(template);
      yield TemplateStarred();
    } else if (event is UnstarTemplate) {
      templateRepository.delete(template.id);
      yield TemplateNotStarred();
    }
  }

  Future<bool> _isTemplateStarred() async {
    return await templateRepository.exists(template.id);
  }
}
