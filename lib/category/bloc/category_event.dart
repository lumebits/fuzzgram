part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchTemplatesByCategory extends CategoryEvent {

  final String category;

  FetchTemplatesByCategory(this.category);

}
