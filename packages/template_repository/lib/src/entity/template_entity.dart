import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class TemplateEntity extends Equatable {
  final String id;
  final String name;
  final int popularity;
  final String imageUrl;
  final DateTime date;
  final List<String> categories;

  const TemplateEntity(this.id, this.name, this.popularity, this.imageUrl,
      this.date, this.categories);

  Map<String, Object> toJson() {
    return {
      "id": id,
      "name": name,
      "popularity": popularity,
      "image": imageUrl,
      "date": date,
      "categories": categories,
    };
  }

  @override
  List<Object> get props => [id, name, popularity, imageUrl, date, categories];

  @override
  String toString() {
    return 'TemplateEntity { id: $id, name: $name, popularity: $popularity, imageUrl: $imageUrl, date: $date, categories: $categories }';
  }

  static TemplateEntity fromJson(Map<String, Object> json) {
    return TemplateEntity(
      json["id"] as String,
      json["name"] as String,
      json["popularity"] as int,
      json["imageUrl"] as String,
      json["date"] as DateTime,
      json["categories"] as List,
    );
  }

  static TemplateEntity fromSnapshot(DocumentSnapshot snap) {
    return TemplateEntity(
      snap.id,
      snap.get('name'),
      snap.get('popularity'),
      snap.get('imageUrl'),
      snap.get('date').toDate(),
      new List<String>.from(snap.get('categories')),
    );
  }

  Map<String, Object> toDocument() {
    return {
      "name": name,
      "popularity": popularity,
      "imageUrl": imageUrl,
      "date": date,
      "categories": categories,
    };
  }
}
