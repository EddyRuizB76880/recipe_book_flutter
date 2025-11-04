import 'package:flutter/material.dart';
import 'package:recipe_book/api_service.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({super.key, this.idMeal = 0});

  final int idMeal;
  

  @override
  State<MealDetailsScreen> createState() {
    return _MealDetailsStateScreen();
  }
}

class _MealDetailsStateScreen extends State<MealDetailsScreen> {
  ApiService apiService = ApiService();

  late Future<Map<String, dynamic>> mealDetails;

  Future<Map<String,dynamic>> _loadMealDetails() async {
    final jsonData = await apiService.getMealById(widget.idMeal);
    print(jsonData);
    return jsonData;
  }

  @override
  void initState() {
    super.initState();
    mealDetails = _loadMealDetails();
  
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Text('Coming soon!')));
  }
}
