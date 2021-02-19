import 'package:firebase_core/firebase_core.dart';

import 'model/models.dart';

abstract class TemplateRepository {
  Stream<List<Template>> findTemplates(int limit, [String category, DateTime startAfter]);

  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }
}
