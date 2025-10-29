import 'dart:convert';

import 'package:dio/dio.dart';
class ApiService {
  static final ApiService _apiService = ApiService._internal();
  final _dio = Dio();

  factory ApiService() {
    return _apiService;
  }
  
  ApiService._internal();

  getCategories() async {
    final response = await _dio.get('https://www.themealdb.com/api/json/v1/1/categories.php');
    return jsonDecode(response.toString());
  }

  getMealDetails(){}

  getRandomMeal(){}

  getMealsByCategory (String category) async {
    final response = await _dio.get('https://www.themealdb.com/api/json/v1/1/filter.php?c=$category');
    return jsonDecode(response.toString());;
  }

  getMealsByArea(){}

  getMealsByIngredient(){}
}