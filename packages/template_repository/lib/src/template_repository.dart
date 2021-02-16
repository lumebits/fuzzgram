import 'model/models.dart';

abstract class TemplateRepository {
  Stream<List<Template>> findTemplates(int limit, [DateTime startAfter]);
  Stream<List<String>> findCategories();
}
