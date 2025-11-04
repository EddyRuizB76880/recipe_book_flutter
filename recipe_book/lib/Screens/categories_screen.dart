import 'package:flutter/material.dart';
import 'package:recipe_book/Models/category.dart';
import 'package:recipe_book/Widgets/app_bar.dart';
import 'package:recipe_book/Widgets/category_item.dart';
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
    return FutureBuilder(
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

            return Scaffold(
              
              appBar: RecipeBookAppBar(),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Expanded(
                        child: GridView(
                          padding: EdgeInsets.all(24),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 30,
                          ),
                          children: [
                            for (final category in snapshot.data!)
                              CategoryItem(category: category),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }
}
