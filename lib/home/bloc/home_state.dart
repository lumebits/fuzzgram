part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeFailure extends HomeState {}

class HomeSuccess extends HomeState {
  final List<Template> templates;
  final bool hasReachedMax;

  const HomeSuccess({
    this.templates = const <Template>[],
    this.hasReachedMax = false,
  });

  HomeSuccess copyWith({
    List<Template> templates,
    bool hasReachedMax,
  }) {
    return HomeSuccess(
      templates: templates ?? this.templates,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [templates, hasReachedMax];

  @override
  String toString() =>
      'HomeSuccess { templates: ${templates.length}, hasReachedMax: $hasReachedMax }';
}
