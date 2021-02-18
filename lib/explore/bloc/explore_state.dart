part of 'explore_bloc.dart';

abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object> get props => [];
}

class ExploreInitial extends ExploreState {}

class ExploreFailure extends ExploreState {}

class ExploreSuccess extends ExploreState {
  final List<Template> templates;
  final bool hasReachedMax;

  const ExploreSuccess({
    this.templates = const <Template>[],
    this.hasReachedMax = false,
  });

  ExploreSuccess copyWith({
    List<Template> templates,
    bool hasReachedMax,
  }) {
    return ExploreSuccess(
      templates: templates ?? this.templates,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [templates, hasReachedMax];

  @override
  String toString() =>
      'ExploreSuccess { templates: ${templates.length}, hasReachedMax: $hasReachedMax }';
}
