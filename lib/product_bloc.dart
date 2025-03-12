import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';
import 'product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;
  String selectedCategory = 'all';
  List<String> categories = ['all'];
  
  ProductBloc({required this.repository}) : super(ProductInitial()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<FilterProductsByCategoryEvent>(_onFilterProductsByCategory);
    on<FetchCategoriesEvent>(_onFetchCategories);
  }
  
  Future<void> _onFetchProducts(
    FetchProductsEvent event,
    Emitter<ProductState> emit
  ) async {
    emit(ProductLoading());
    try {
      final products = await repository.fetchProducts();
      emit(ProductsLoaded(products));
      // Also update the categories state to ensure UI consistency
      emit(CategoriesLoaded(categories, selectedCategory));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
  
  Future<void> _onFilterProductsByCategory(
    FilterProductsByCategoryEvent event,
    Emitter<ProductState> emit
  ) async {
    if (event.category == selectedCategory) return;
    
    emit(ProductLoading());
    selectedCategory = event.category;
    
    try {
      final products = await repository.fetchProductsByCategory(event.category);
      emit(ProductsLoaded(products));
      // Important: Always emit updated category state after filtering
      emit(CategoriesLoaded(categories, selectedCategory));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
  
  Future<void> _onFetchCategories(
    FetchCategoriesEvent event,
    Emitter<ProductState> emit
  ) async {
    try {
      categories = await repository.fetchCategories();
      emit(CategoriesLoaded(categories, selectedCategory));
    } catch (e) {
      // Just keep the default categories if there's an error
      emit(CategoriesLoaded(categories, selectedCategory));
    }
  }
}
