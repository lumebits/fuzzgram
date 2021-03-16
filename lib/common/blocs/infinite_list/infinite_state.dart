part of 'infinite_bloc.dart';

abstract class InfiniteState extends Equatable {
  const InfiniteState();

  @override
  List<Object> get props => [];
}

class InfiniteInitial extends InfiniteState {}

class InfiniteFailure extends InfiniteState {}

class InfiniteSuccess extends InfiniteState {
  final List<Template> templates;
  final bool hasReachedMax;

  const InfiniteSuccess({
    this.templates = const <Template>[],
    this.hasReachedMax = false,
  });

  InfiniteSuccess copyWith({
    List<Template> templates,
    bool hasReachedMax,
  }) {
    return InfiniteSuccess(
      templates: templates ?? this.templates,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [templates, hasReachedMax];

  @override
  String toString() =>
      'InfiniteSuccess { templates: ${templates.length}, hasReachedMax: $hasReachedMax }';
}
