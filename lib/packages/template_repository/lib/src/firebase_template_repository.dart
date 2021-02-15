import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../template_repository.dart';
import 'entity/entities.dart';

class FirebaseTemplateRepository implements TemplateRepository {
  final templatesCollection =
      FirebaseFirestore.instance.collection('templates');
  final categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

  @override
  Stream<List<Template>> findTemplates() {
    return templatesCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Template.fromEntity(TemplateEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Stream<List<String>> findCategories() {
    return categoriesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.get('name')).toList();
    });
  }
}
