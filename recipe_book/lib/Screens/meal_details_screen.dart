import 'package:flutter/material.dart';
import 'package:recipe_book/Widgets/app_bar.dart';
import 'package:recipe_book/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

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

  late Map<String, dynamic> mealDetails;
  bool isLoading = true;
  String title = 'Loading...';
  Widget content = const Center(child: CircularProgressIndicator());

  _loadMealDetails() async {
    final jsonData = await apiService.getMealById(widget.idMeal);

    setState(() {
      isLoading = false;
      mealDetails = jsonData['meals'][0];
      title = mealDetails['strMeal'];
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMealDetails();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: CircularProgressIndicator());

    if (!isLoading) {
      content = SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              mealDetails['strMealThumb'],
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Text('Ingredients', textAlign: TextAlign.center),
            for (var index = 1; index <= 20; index++)
              if (mealDetails['strMeasure$index'].length > 1)
                Text(
                  '${mealDetails['strMeasure$index']} ${mealDetails['strIngredient$index']}',
                  textAlign: TextAlign.center,
                ),
            Text('Steps', textAlign: TextAlign.center),
            for (final step in mealDetails['strInstructions'].split("\r\n"))
              if (step.length > 1) Text(step, textAlign: TextAlign.center),
            TextButton(
              onPressed: () async {
                await launchUrl(Uri.parse(mealDetails['strSource']));
              },
              child: Text('Recipe taken from ${mealDetails['strSource']}'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: RecipeBookAppBar(title: title,),
      body: SafeArea(child: content),
    );
  }
}
