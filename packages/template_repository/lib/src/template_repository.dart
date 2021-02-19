import 'package:firebase_core/firebase_core.dart';

import 'model/models.dart';

abstract class TemplateRepository {
  Stream<List<Template>> findTemplates(int limit, [DateTime startAfter]);
  Stream<List<Template>> findTemplatesByCategory(int limit, String category, [DateTime startAfter]);
  Stream<List<String>> findCategories();

  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }
}
