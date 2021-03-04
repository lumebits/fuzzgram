import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fuzzgram/common/widgets/base_page.dart';
import 'package:fuzzgram/template/bloc/template_bloc.dart';
import 'package:template_repository/template_repository.dart';
import 'package:social_share/social_share.dart';

class TemplatePage extends BasePage {
  final Template template;

  TemplatePage(this.template, {Key key}) : super(key, withBackButton: true);

  @override
  Widget widget(BuildContext context) {
    return BlocProvider(
      create: (context) => TemplateBloc(template)..add(LoadStarredStatus()),
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
      return TemplateWidget(template: template);
    });
  }
}

class TemplateWidget extends StatelessWidget {
  final Template template;

  TemplateWidget({Key key, @required this.template}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x00000000),
      body: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
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
          margin: EdgeInsets.fromLTRB(30, 18, 30, 150)),
      floatingActionButton: Padding(
        child: FloatingActionButton(
          onPressed: () async {
            final file =
                await DefaultCacheManager().getSingleFile(template.imageUrl);
            SocialShare.shareOptions(
                "Download Fuzzgram and get lots of templates like this!",
                imagePath: file.path);
          },
          child: Icon(
            Icons.share,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
        padding: EdgeInsets.fromLTRB(20, 0, 20, 120),
      ),
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
