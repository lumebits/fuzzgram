part of 'explore_bloc.dart';

abstract class ExploreEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryTapped extends ExploreEvent {
  final String category;

  CategoryTapped(this.category);
}
