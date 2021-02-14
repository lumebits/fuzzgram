class Template {
  final String name;

  const Template(this.name);

  @override
  String toString() => 'Template { name: $name }';
}

class TemplateSearchState {
  final bool isLoading;
  final List<Template> templates;
  final bool hasError;

  const TemplateSearchState({this.isLoading, this.templates, this.hasError});

  factory TemplateSearchState.initial() {
    return TemplateSearchState(
      templates: [],
      isLoading: false,
      hasError: false,
    );
  }

  factory TemplateSearchState.loading() {
    return TemplateSearchState(
      templates: [],
      isLoading: true,
      hasError: false,
    );
  }

  factory TemplateSearchState.success(List<Template> templates) {
    return TemplateSearchState(
      templates: templates,
      isLoading: false,
      hasError: false,
    );
  }

  factory TemplateSearchState.error() {
    return TemplateSearchState(
      templates: [],
      isLoading: false,
      hasError: true,
    );
  }

  @override
  String toString() =>
      'TemplateSearchState {template: ${templates.toString()}, isLoading: $isLoading, hasError: $hasError }';
}
