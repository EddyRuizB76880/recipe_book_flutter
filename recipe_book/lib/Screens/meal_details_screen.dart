import 'package:flutter/material.dart';
import 'package:recipe_book/Models/meal_row_data.dart';
import 'package:recipe_book/Widgets/recipe_book_app_bar.dart';
import 'package:recipe_book/Widgets/favorite_icon.dart';
import 'package:recipe_book/Widgets/pill.dart';
import 'package:recipe_book/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({super.key, required this.idMeal});

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
  List<Widget> appBarActions = [];

  _loadMealDetails() async {
    final jsonData = await apiService.getMealById(widget.idMeal);

    setState(() {
      isLoading = false;
      mealDetails = jsonData['meals'][0];
      title = mealDetails['strMeal'];
      appBarActions.add(
        FavoriteIcon(
          meal: MealRowData(
            strMeal: title,
            idMeal: widget.idMeal,
            strMealThumb: mealDetails['strMealThumb'],
          ),
          tappable: true,
        ),
      );
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
              mealDetails['strMealThumb'] ??
                  'https://cdn-icons-png.freepik.com/512/1046/1046874.png',
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Pill(text: mealDetails['strArea']),
                  Pill(text: mealDetails['strCategory']),
                ],
              ),
            ),
            if (mealDetails['strSource'] != null &&
                mealDetails['strSource'].length > 1)
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse(mealDetails['strSource']));
                  },
                  child: Pill(text: 'Tap here to see the source.'),
                ),
              ),
            Text(
              'Ingredients',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            for (var index = 1; index <= 20; index++)
              if (mealDetails['strMeasure$index'] != null &&
                  mealDetails['strMeasure$index'].length > 1)
                Text(
                  '${mealDetails['strMeasure$index']} ${mealDetails['strIngredient$index']}',
                  textAlign: TextAlign.center,
                ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Steps',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Text(
              style: TextStyle(fontSize: 12),
              'Swipe cards up and down to move between steps',
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400, maxHeight: 200),

              child: CarouselView(
                itemExtent: double.infinity,
                scrollDirection: Axis.vertical,
                itemSnapping: true,
                shrinkExtent: 200,
                children: [
                  for (final step in mealDetails['strInstructions'].split(
                    "\r\n",
                  ))
                    if (step.length > 1)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            step,
                            style: TextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: RecipeBookAppBar(title: title, actions: appBarActions),
      body: SafeArea(child: content),
    );
  }
}
