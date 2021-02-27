import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzgram/common/blocs/infinite_list/infinite_bloc.dart';
import 'package:fuzzgram/common/widgets/infinite_page.dart';
import 'package:template_repository/template_repository.dart';

class StarredPage extends StatelessWidget {
  StarredPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          InfiniteBloc(SqliteLocalTemplateRepository())..add(FetchTemplates()),
      child: InfinitePage(),
    );
  }
}
