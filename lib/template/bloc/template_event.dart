part of 'template_bloc.dart';

abstract class TemplateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TemplateTapped extends TemplateEvent {
  final Template template;

  TemplateTapped(this.template);
}
