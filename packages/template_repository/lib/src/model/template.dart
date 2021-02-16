import 'package:meta/meta.dart';
import '../entity/entities.dart';

@immutable
class Template {
  final String id;
  final String name;
  final int popularity;
  final String imageUrl;
  final DateTime date;
  final List<String> categories;

  Template(this.id, this.name, this.popularity, this.imageUrl, this.date,
      this.categories);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      popularity.hashCode ^
      imageUrl.hashCode ^
      date.hashCode ^
      categories.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Template &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          popularity == other.popularity &&
          imageUrl == other.imageUrl &&
          date == other.date &&
          categories == other.categories;

  @override
  String toString() {
    return 'Template { id: $id, name: $name, popularity: $popularity, imageUrl: $imageUrl, date: $date, categories: $categories }';
  }

  TemplateEntity toEntity() {
    return TemplateEntity(id, name, popularity, imageUrl, date, categories);
  }

  static Template fromEntity(TemplateEntity entity) {
    return Template(
      entity.id,
      entity.name,
      entity.popularity,
      entity.imageUrl,
      entity.date,
      entity.categories,
    );
  }
}
