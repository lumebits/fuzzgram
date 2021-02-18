import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzgram/explore/explore.dart';
import 'package:template_repository/template_repository.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExploreBloc(templateRepository: FirebaseTemplateRepository()),
      child: ExploreList(),
    );
  }
}

class ExploreList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreBloc, ExploreState>(builder: (context, state) {
      return GridView.count(
        padding: EdgeInsets.only(top: 75.0, bottom: 90.0),
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width / 200,
        children: [
          CategoryItem(category: new Category("movies", "assets/categories/movies.jpg")),
          CategoryItem(category: new Category("beauty", "assets/categories/beauty.jpg", 0.3)),
          CategoryItem(category: new Category("tv shows", "assets/categories/tv-shows.jpg")),
          CategoryItem(category: new Category("travel", "assets/categories/travel.jpg", 0.2)),
          CategoryItem(category: new Category("animals", "assets/categories/animals.jpg", 0.2)),
          CategoryItem(category: new Category("tech", "assets/categories/tech.jpg", 0.15)),
          CategoryItem(category: new Category("food", "assets/categories/food.jpg", 0.2)),
          CategoryItem(category: new Category("fashion", "assets/categories/fashion.jpg", 0.2)),
          CategoryItem(category: new Category("productivity", "assets/categories/productivity.jpg", 0.2)),
          CategoryItem(category: new Category("sport", "assets/categories/sport.jpg", 0.15)),
          CategoryItem(category: new Category("music", "assets/categories/music.jpg", 0.15)),
          CategoryItem(category: new Category("self care", "assets/categories/self-care.jpg")),
          CategoryItem(category: new Category("about me", "assets/categories/about-me.jpg", 0.15)),
          CategoryItem(category: new Category("this or that", "assets/categories/this-or-that.jpg", 0.05)),
        ],
      );
    });
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

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAlias,
          child: Material(
            child: Ink(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage(category.assetImage),
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(category.darken), BlendMode.darken)
                ),
              ),
              child: InkWell(
                onTap: () {
                  print("Category tapped: " + category.name);
                },
                child: Center(
                  child: Text(
                    category.name.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  )
                )
              ),
            )
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        )
    );
  }
}
