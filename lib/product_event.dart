abstract class ProductEvent {}

class FetchProductsEvent extends ProductEvent {}

class FilterProductsByCategoryEvent extends ProductEvent {
  final String category;
  
  FilterProductsByCategoryEvent(this.category);
}

class FetchCategoriesEvent extends ProductEvent {}