part of 'template_bloc.dart';

abstract class TemplateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadStarredStatus extends TemplateEvent {}

class StarTemplate extends TemplateEvent {}

class UnstarTemplate extends TemplateEvent {}