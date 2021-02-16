part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TemplatesFetched extends HomeEvent {
  final List<Template> data;

  TemplatesFetched(this.data);
}
