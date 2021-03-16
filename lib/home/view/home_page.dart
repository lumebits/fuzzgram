import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzgram/common/blocs/infinite_list/infinite_bloc.dart';
import 'package:fuzzgram/common/widgets/base_page.dart';
import 'package:fuzzgram/common/widgets/infinite_page.dart';
import 'package:fuzzgram/navigation/navigation.dart';
import 'package:template_repository/template_repository.dart';

class HomePage extends BasePage {
  HomePage({Key key}) : super(key, appTab: AppTab.home);

  @override
  Widget widget(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      InfiniteBloc(FirebaseTemplateRepository())..add(FetchTemplates()),
      child: InfinitePage(),
    );
  }
}
