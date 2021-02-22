import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzgram/template/bloc/template_bloc.dart';
import 'package:template_repository/template_repository.dart';

class TemplatePage extends StatelessWidget {
  final Template template;

  TemplatePage({Key key, this.template}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TemplateBloc(),
      child: TemplateDetailPage(),
    );
  }
}

class TemplateDetailPage extends StatelessWidget {
  final Template template;

  TemplateDetailPage({Key key, @required this.template}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateBloc, TemplateState>(builder: (context, state) {
      print(template);
      return Center();
    });
  }
}
