part of 'template_bloc.dart';

abstract class TemplateState extends Equatable {
  const TemplateState();

  @override
  List<Object> get props => [];
}

class TemplateInitial extends TemplateState {}

class TemplateDetail extends TemplateState {
  final Template template;

  const TemplateDetail(this.template);

  @override
  List<Object> get props => [template];

  @override
  String toString() =>
      'TemplateDetail { template: $template }';
}
