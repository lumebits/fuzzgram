import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fuzzgram/common/widgets/base_page.dart';
import 'package:fuzzgram/navigation/navigation.dart';

import '../../routes.dart';

class ExplorePage extends BasePage {
  ExplorePage({Key key}) : super(key, appTab: AppTab.explore);

  @override
  Widget widget(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.only(bottom: 90.0),
      crossAxisCount: 2,
      childAspectRatio: MediaQuery
          .of(context)
          .size
          .width / 200,
      children: [
        CategoryItem(
            category:
            new Category("MOVIES", "assets/categories/movies.jpg")),
        CategoryItem(
            category:
            new Category("BEAUTY", "assets/categories/beauty.jpg", 0.3)),
        CategoryItem(
            category:
            new Category("TV SHOWS", "assets/categories/tv-shows.jpg")),
        CategoryItem(
            category:
            new Category("TRAVEL", "assets/categories/travel.jpg", 0.2)),
        CategoryItem(
            category:
            new Category("ANIMALS", "assets/categories/animals.jpg", 0.2)),
        CategoryItem(
            category:
            new Category("TECH", "assets/categories/tech.jpg", 0.15)),
        CategoryItem(
            category:
            new Category("FOOD", "assets/categories/food.jpg", 0.2)),
        CategoryItem(
            category:
            new Category("FASHION", "assets/categories/fashion.jpg", 0.2)),
        CategoryItem(
            category:
            new Category("PRODUCTIVITY", "assets/categories/productivity.jpg", 0.2)),
        CategoryItem(
            category:
            new Category("SPORT", "assets/categories/sport.jpg", 0.15)),
        CategoryItem(
            category:
            new Category("MUSIC", "assets/categories/music.jpg", 0.15)),
        CategoryItem(
            category:
            new Category("SELF CARE", "assets/categories/self-care.jpg")),
        CategoryItem(
            category:
            new Category("ABOUT ME", "assets/categories/about-me.jpg", 0.15)),
        CategoryItem(
            category:
            new Category("THIS OR THAT", "assets/categories/this-or-that.jpg", 0.05)),
      ],
    );
  }
}

class Category {
  final String name;
  final String assetImage;
  final double darken;

  Category(this.name, this.assetImage, [this.darken = 0.1]);
}

class CategoryItem extends StatelessWidget {
  final Category category;

  CategoryItem({Key key, @required this.category}) : super(key: key);

  Decoration _cardDecoration() {
    return BoxDecoration(
      image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage(category.assetImage),
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(category.darken), BlendMode.darken)),
    );
  }

  Widget _cardText() {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: AutoSizeText(
            category.name,
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        )
    );
  }

  Widget _categoryCard(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAlias,
      child: Material(
          child: Ink(
            decoration: _cardDecoration(),
            child: InkWell(
                onTap: () {
                  print("Category tapped: " + category.name);
                  Navigator.pushNamed(context, FuzzgramRoutes.exploreCategory,
                      arguments: category.name);
                },
                child: _cardText()
            ),
          )
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(child: _categoryCard(context));
  }
}
