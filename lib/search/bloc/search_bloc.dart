import 'package:bloc/bloc.dart';
import 'package:fuzzgram/search/bloc/search_event.dart';
import 'package:fuzzgram/search/model/search_template.dart';

class SearchBloc extends Bloc<SearchEvent, TemplateSearchState> {
  SearchBloc() : super(TemplateSearchState.initial());

  @override
  Stream<TemplateSearchState> mapEventToState(SearchEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

}
