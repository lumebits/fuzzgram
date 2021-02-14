import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchTemplate extends SearchEvent {
  final String query;

  const SearchTemplate(this.query);

  @override
  String toString() => 'SearchTemplateEvent { query: $query }';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
