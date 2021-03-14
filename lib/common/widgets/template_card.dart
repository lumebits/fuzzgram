import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fuzzgram/common/widgets/bottom_loader.dart';
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
          print("Template tapped: " + template.id);
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
        child: Hero(
          tag: template.id,
          child: Material(
            child: CachedNetworkImage(
              height: (MediaQuery.of(context).size.width / 2 - 20) * (1920 / 1080),
              imageUrl: template.imageUrl,
              imageBuilder: (context, imageProvider) => Ink.image(
                fit: BoxFit.fill,
                image: imageProvider,
              ),
              placeholder: (context, url) => BottomLoader(),
            ),
          ),
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
