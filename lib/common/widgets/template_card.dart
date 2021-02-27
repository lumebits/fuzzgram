import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fuzzgram/routes.dart';
import 'package:social_share/social_share.dart';
import 'package:template_repository/template_repository.dart';

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
          Navigator.pushNamed(context, FuzzgramRoutes.template,
              arguments: template);
        },
        onLongPress: () async {
          print("Long pressed template: " + template.id + " " + template.name);
          final file =
              await DefaultCacheManager().getSingleFile(template.imageUrl);
          SocialShare.shareOptions(
              "Download Fuzzgram and get lots of templates like this!",
              imagePath: file.path);
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
