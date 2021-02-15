import 'model/models.dart';

abstract class TemplateRepository {
  Stream<List<Template>> findTemplates();
  Stream<List<String>> findCategories();
}
