import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fuzzgram/common/widgets/base_page.dart';
import 'package:fuzzgram/common/widgets/bottom_loader.dart';
import 'package:fuzzgram/template/bloc/template_bloc.dart';
import 'package:template_repository/template_repository.dart';
import 'package:social_share/social_share.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TemplatePage extends BasePage {
  final Template template;

  TemplatePage(this.template, {Key key}) : super(key, withBackButton: true);

  @override
  Widget widget(BuildContext context) {
    return TemplateDetailPage(template);
  }

  @override
  List<Widget> actions() {
    return [
      BlocBuilder<TemplateBloc, TemplateState>(builder: (context, state) {
        return IconButton(
          icon: Icon(
            state is TemplateStarred ? Icons.star : Icons.star_border,
            color: Colors.black,
          ),
          tooltip: 'Save template',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state is TemplateStarred
                    ? AppLocalizations.of(context).template_unstarred
                    : AppLocalizations.of(context).template_starred)));
            BlocProvider.of<TemplateBloc>(context).add(
                state is TemplateStarred ? UnstarTemplate() : StarTemplate());
          },
        );
      })
    ];
  }

  @override
  Widget floatingActionButton(BuildContext context) {
    return Padding(
      child: FloatingActionButton(
        onPressed: () async {
          final file =
              await DefaultCacheManager().getSingleFile(template.imageUrl);
          SocialShare.shareOptions(
              AppLocalizations.of(context).share_message,
              imagePath: file.path);
        },
        child: Icon(
          Icons.share,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      padding: EdgeInsets.only(right: 14, bottom: 14),
    );
  }

  @override
  Widget bottomNavigationBar() {
    return null;
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
    return SingleChildScrollView(
      child: InkWell(
        child: Hero(
          tag: template.id,
          child: CachedNetworkImage(
            imageUrl: template.imageUrl,
            imageBuilder: (context, imageProvider) => Image(
              fit: BoxFit.fill,
              image: imageProvider,
            ),
            placeholder: (context, url) => BottomLoader(),
          ),
        ),
      ),
    );
  }
}
