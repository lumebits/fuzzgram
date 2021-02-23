import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzgram/template/bloc/template_bloc.dart';
import 'package:template_repository/template_repository.dart';

class TemplatePage extends StatelessWidget {
  final Template template;

  TemplatePage(this.template, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TemplateBloc(template)..add(LoadStarredStatus()),
      child: TemplateDetailPage(template),
    );
  }
}

class TemplateDetailPage extends StatelessWidget {
  final Template template;

  TemplateDetailPage(this.template, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateBloc, TemplateState>(builder: (context, state) {
      print(template);
      return Center();
    });
  }
}
