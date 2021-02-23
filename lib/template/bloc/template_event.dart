part of 'template_bloc.dart';

abstract class TemplateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadStarredStatus extends TemplateEvent {
  final Template template;

  LoadStarredStatus(this.template);
}

class StarTemplate extends TemplateEvent {}

class UnstarTemplate extends TemplateEvent {}