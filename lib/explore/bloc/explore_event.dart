part of 'explore_bloc.dart';

abstract class ExploreEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchTemplates extends ExploreEvent {}