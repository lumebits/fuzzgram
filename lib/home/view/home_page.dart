import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzgram/home/home.dart';
import 'package:template_repository/template_repository.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(templateRepository: FirebaseTemplateRepository())..add(FetchTemplates()),
      child: HomeList(),
    );
  }
}

class HomeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is HomeInitial) {
        return Center(child: CircularProgressIndicator());
      } else if (state is HomeSuccess) {
        final templatesList = state.templates;
        return SafeArea(
          child: ListView.builder(
            itemCount: templatesList.length,
            itemBuilder: (context, index) {
              final template = templatesList[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: TemplateItem(template: template),
              );
            },
          ),
        );
      } else {
        return Center(child: Text("Error"));
      }
    });
  }
}

class TemplateItem extends StatelessWidget {
  final Template template;

  TemplateItem({Key key, @required this.template}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: new PageStorageKey<String>(template.id),
      title: Text(template.name),
      leading: Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
      ),
      children: [
        Center()
      ],
    );
  }
}
