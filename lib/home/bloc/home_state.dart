part of 'home_bloc.dart';

enum HomeStatus { loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.loading,
    this.templates = const <Template>[],
    this.hasReachedMax = false,
  });

  final HomeStatus status;
  final List<Template> templates;
  final bool hasReachedMax;

  HomeState copyWith({
    HomeStatus status,
    List<Template> templates,
    bool hasReachedMax,
  }) {
    return HomeState(
      status: status ?? this.status,
      templates: templates ?? this.templates,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, templates, hasReachedMax];
}
