import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:template_repository/template_repository.dart';

part 'template_event.dart';
part 'template_state.dart';

class TemplateBloc extends Bloc<TemplateEvent, TemplateState> {
  final Template template;

  TemplateBloc(this.template) : super(TemplateNotStarred());

  @override
  Stream<TemplateState> mapEventToState(TemplateEvent event) async* {
    if (event is LoadStarredStatus) {
      yield _isTemplateStarred() ? TemplateStarred() : TemplateNotStarred();
    } else if (event is StarTemplate) {
      // TODO: Save template id in local sqlite
      yield TemplateStarred();
    } else if (event is UnstarTemplate) {
      // TODO: Remove template id from local sqlite
      yield TemplateNotStarred();
    }
  }

  bool _isTemplateStarred() {
    // TODO: Check if template id is in local sqlite
    return true;
  }
}
