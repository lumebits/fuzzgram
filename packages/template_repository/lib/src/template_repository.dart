import 'model/models.dart';

abstract class TemplateRepository {
  Stream<List<Template>> findTemplates(int limit,
      [String category, DateTime startAfter, int offset]);

  Future insert(Template template);

  Future initialize();
}
