import 'product_model.dart';


abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<Product> products;
  
  ProductsLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;
  
  ProductError(this.message);
}

class CategoriesLoaded extends ProductState {
  final List<String> categories;
  final String selectedCategory;
  
  CategoriesLoaded(this.categories, this.selectedCategory);
}