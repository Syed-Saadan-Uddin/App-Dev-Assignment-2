import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product_model.dart';

class ProductRepository {
  final String baseUrl = 'https://fakestoreapi.com';
  
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
  
  Future<List<Product>> fetchProductsByCategory(String category) async {
    if (category.toLowerCase() == 'all') {
      return fetchProducts();
    }
    
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/category/$category')
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products by category: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products by category: $e');
    }
  }
  
  Future<List<String>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/categories')
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<String> categories = data.map((item) => item.toString()).toList();
        categories.insert(0, 'all'); 
        return categories;
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }
}
