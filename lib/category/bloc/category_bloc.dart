import 'dart:async';

import 'package:fuzzgram/common/blocs/infinite_list/infinite_bloc.dart';
import 'package:template_repository/template_repository.dart';

class CategoryBloc extends InfiniteBloc {
  final String category;

  CategoryBloc(templateRepository, this.category) : super(templateRepository);

  @override
  Future<List<Template>> fetchTemplates([DateTime lastDate]) {
    return templateRepository
        .findTemplates(templatesToLoad, category.toUpperCase(), lastDate)
        .first;
  }
}