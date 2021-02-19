part of 'explore_bloc.dart';

abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object> get props => [];
}

class ExploreInitial extends ExploreState {}

class ExploringCategory extends ExploreState {
  final String category;

  const ExploringCategory(this.category);

  @override
  List<Object> get props => [category];

  @override
  String toString() =>
      'ExploringCategory { category: $category }';
}
