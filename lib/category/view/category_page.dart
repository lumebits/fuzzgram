import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzgram/category/category.dart';
import 'package:fuzzgram/common/blocs/infinite_list/infinite_bloc.dart';
import 'package:fuzzgram/common/widgets/infinite_page.dart';
import 'package:template_repository/template_repository.dart';

class CategoryPage extends StatelessWidget {
  final String category;

  CategoryPage(this.category, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(FirebaseTemplateRepository(), category)
        ..add(FetchTemplates()),
      child: InfiniteCategoryPage(),
    );
  }
}


class InfiniteCategoryPage extends InfinitePage {
  @override
  _InfiniteCategoryPageState createState() => _InfiniteCategoryPageState();
}

class _InfiniteCategoryPageState extends InfinitePageState {

  @override
  void initState() {
    try {
      super.initState();
    } catch (e) {
      infiniteBloc = BlocProvider.of<CategoryBloc>(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, InfiniteState>(builder: (context, state) {
      return super.stateToView(state);
    });
  }
}
