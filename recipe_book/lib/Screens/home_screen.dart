import 'package:flutter/material.dart';
import 'package:recipe_book/Screens/calendar_screen.dart';
import 'package:recipe_book/Screens/categories_screen.dart';
import 'package:recipe_book/Screens/search_screen.dart';
import 'package:recipe_book/Widgets/recipe_book_app_bar.dart';
import 'package:recipe_book/Widgets/recipe_book_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  String appBarTitle = 'My Recipe Book!';

  onDestinationTapped(int destIndex, String destLabel) {
    setState(() {
      index = destIndex;
      appBarTitle = destLabel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeBookAppBar(title: appBarTitle),
      bottomNavigationBar: RecipeBookNavBar(
        index: index,
        onDestinationTapped: onDestinationTapped,
      ),
      body: [CategoriesScreen(), CalendarScreen(), SearchScreen()][index],
    );
  }
}
