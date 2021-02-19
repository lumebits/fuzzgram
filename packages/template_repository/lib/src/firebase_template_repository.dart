import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../template_repository.dart';
import 'entity/entities.dart';

class FirebaseTemplateRepository implements TemplateRepository {
  final templatesCollection =
      FirebaseFirestore.instance.collection('templates');

  @override
  Stream<List<Template>> findTemplates(int limit, [String category, DateTime startAfter]) {
    var refTemplates = templatesCollection
        .orderBy('date', descending: true)
        .limit(limit);

    if (category != null) {
      refTemplates = refTemplates.where('categories', arrayContains: category);
    }

    if (startAfter != null) {
      refTemplates = refTemplates.startAfter([startAfter]);
    }

    return refTemplates
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Template.fromEntity(TemplateEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
