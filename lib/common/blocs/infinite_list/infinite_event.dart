part of 'infinite_bloc.dart';

abstract class InfiniteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchTemplates extends InfiniteEvent {}
