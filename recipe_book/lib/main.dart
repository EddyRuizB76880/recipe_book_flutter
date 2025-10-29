import 'package:flutter/material.dart';
import 'package:recipe_book/Screens/categories_screen.dart';
import 'package:recipe_book/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book.',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(206, 242, 79, 3),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Recipe Book!',
            style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(child: CategoriesScreen()),
      ),
    );
  }
}
