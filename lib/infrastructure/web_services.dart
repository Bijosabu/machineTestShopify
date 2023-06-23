import 'dart:convert';

import 'package:machinetestapiinteg/domain/productModel/product_model.dart';
import 'package:http/http.dart' as http;

class ApiCalls {
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http
          .get(Uri.parse('https://fakestoreapi.com/products?limit=10'));
      final data = jsonDecode(response.body) as List<dynamic>;
      List<ProductModel> products =
          data.map((json) => ProductModel.fromJson(json)).toList();
      print(products);
      return products;
    } catch (e) {
      throw e.toString();
    }
  }

  // Future<List<ProductModel>> fetchMoreProducts(String limit) async {
  //   try {
  //     final response = await http
  //         .get(Uri.parse('https://fakestoreapi.com/products?limit=$limit'));
  //     final data = jsonDecode(response.body) as List<dynamic>;
  //     List<ProductModel> products =
  //         data.map((json) => ProductModel.fromJson(json)).toList();
  //     return products;
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  // Future<ProductModel> fetchProductsById({required String id}) async {
  //   try {
  //     final response =
  //         await http.get(Uri.parse('https://fakestoreapi.com/products/$id'));
  //     final data = jsonDecode(response.body);
  //     final product = ProductModel.fromJson(data);
  //     return product;
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }
}
