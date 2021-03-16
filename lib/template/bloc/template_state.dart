part of 'template_bloc.dart';

abstract class TemplateState extends Equatable {
  const TemplateState();

  @override
  List<Object> get props => [];
}

class TemplateStarred extends TemplateState {}

class TemplateNotStarred extends TemplateState {}
