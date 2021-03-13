import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../template_repository.dart';
import 'entity/entities.dart';

final templatesCollection = FirebaseFirestore.instance.collection('templates');

class FirebaseTemplateRepository implements TemplateRepository {
  static final FirebaseTemplateRepository _firebaseTemplateRepository =
      FirebaseTemplateRepository._internal();

  FirebaseTemplateRepository._internal();

  factory FirebaseTemplateRepository() {
    return _firebaseTemplateRepository;
  }

  @override
  Future initialize() async {
    await Firebase.initializeApp();
  }

  @override
  Stream<List<Template>> findTemplates(int limit,
      [String category, DateTime startAfter, int offset]) {
    var refTemplates =
        templatesCollection.orderBy('date', descending: true).limit(limit);

    if (category != null) {
      refTemplates = refTemplates.where('categories', arrayContains: category);
    }

    if (startAfter != null) {
      refTemplates = refTemplates.startAfter([startAfter]);
    }

    return refTemplates.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Template.fromEntity(TemplateEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future insert(Template template) {
    throw UnimplementedError();
  }

  @override
  Future delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<bool> exists(String id) {
    throw UnimplementedError();
  }
}
