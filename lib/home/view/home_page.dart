import 'package:cached_network_image/cached_network_image.dart';
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
      create: (context) =>
          HomeBloc(templateRepository: FirebaseTemplateRepository())
            ..add(FetchTemplates()),
      child: ScrollableHomePage(),
    );
  }
}

class ScrollableHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ScrollableHomePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is HomeInitial) {
        return Center(child: BottomLoader());
      } else if (state is HomeSuccess) {
        final templatesList = state.templates;
        return GridView.builder(
          padding: EdgeInsets.only(top: 75.0, bottom: 90.0),
          controller: _scrollController,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height),
          ),
          itemCount: state.hasReachedMax
              ? templatesList.length
              : templatesList.length + 1,
          itemBuilder: (context, index) {
            return index >= templatesList.length
                ? BottomLoader()
                : GridTile(
                    child: TemplateWidget(template: templatesList[index]));
          },
        );
      } else {
        return Center(child: Text("Error"));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _homeBloc.add(FetchTemplates());
    }
  }
}

class TemplateWidget extends StatelessWidget {
  final Template template;

  TemplateWidget({Key key, @required this.template}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          print("Template tapped: " + template.id + " " + template.name);
        },
        child: CachedNetworkImage(
          imageUrl: template.imageUrl,
          imageBuilder: (context, imageProvider) => Ink.image(
            fit: BoxFit.fill,
            image: imageProvider,
          ),
          placeholder: (context, url) => BottomLoader(),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
          ),
        ),
      ),
    );
  }
}
