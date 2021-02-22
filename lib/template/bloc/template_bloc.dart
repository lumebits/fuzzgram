import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:template_repository/template_repository.dart';

part 'template_event.dart';
part 'template_state.dart';

class TemplateBloc extends Bloc<TemplateEvent, TemplateState> {

  TemplateBloc() : super(TemplateInitial());

  @override
  Stream<TemplateState> mapEventToState(TemplateEvent event) async* {
    if (event is TemplateTapped) {
      yield TemplateDetail(event.template);
    }
  }
}
