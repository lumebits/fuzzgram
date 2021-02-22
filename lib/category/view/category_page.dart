import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fuzzgram/category/category.dart';
import 'package:template_repository/template_repository.dart';
import 'package:social_share/social_share.dart';

class CategoryPage extends StatelessWidget {
  final String category;

  CategoryPage(this.category, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      CategoryBloc(templateRepository: FirebaseTemplateRepository())
        ..add(FetchTemplatesByCategory(category)),
      child: ScrollableCategoryPage(category),
    );
  }
}

class ScrollableCategoryPage extends StatefulWidget {
  final String category;

  const ScrollableCategoryPage(this.category, {Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState(category);
}

class _CategoryPageState extends State<ScrollableCategoryPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  final String category;
  CategoryBloc _categoryBloc;

  _CategoryPageState(this.category);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      if (state is CategoryInitial) {
        return Center(child: BottomLoader());
      } else if (state is CategorySuccess) {
        final templatesList = state.templates;
        return GridView.builder(
          padding: EdgeInsets.only(bottom: 90.0),
          controller: _scrollController,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height) * 1.25,
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
      _categoryBloc.add(FetchTemplatesByCategory(category));
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
        onLongPress: () async {
          print("Long pressed template: "+ template.id + " " + template.name);
          final file = await DefaultCacheManager().getSingleFile(template.imageUrl);
          SocialShare.shareOptions("Download Fuzzgram and get lots of templates like this!", imagePath: file.path);
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
