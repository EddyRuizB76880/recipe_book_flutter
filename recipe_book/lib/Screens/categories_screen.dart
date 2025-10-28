import 'package:flutter/material.dart';
import 'package:recipe_book/Models/category.dart';
import 'package:recipe_book/Widgets/category_row.dart';
import 'package:recipe_book/api_service.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() {
    return _CategoriesScreenState();
  }
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<List<Category>> categories;

  ApiService apiService = ApiService();

  Future<List<Category>> _loadCategories() async {
    final jsonData = await apiService.getCategories();
    return Category.fromJsonToCategories(jsonData);
  }

  @override
  void initState() {
    super.initState();
    categories = _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: categories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No categories available.'));
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) =>
                  CategoryRow(category: snapshot.data![index]),
            );
          },
        ),
      ),
    );
  }
}
