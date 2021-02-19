part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryFailure extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<Template> templates;
  final bool hasReachedMax;

  const CategorySuccess({
    this.templates = const <Template>[],
    this.hasReachedMax = false,
  });

  CategorySuccess copyWith({
    List<Template> templates,
    bool hasReachedMax,
  }) {
    return CategorySuccess(
      templates: templates ?? this.templates,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [templates, hasReachedMax];

  @override
  String toString() =>
      'CategorySuccess { templates: ${templates.length}, hasReachedMax: $hasReachedMax }';
}
