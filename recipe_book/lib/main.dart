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
          seedColor: const Color.fromARGB(206, 243, 62, 2),
        ),
      ),
      home: Scaffold(
        
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: CategoriesScreen(),
      ),
    );
  }
}
