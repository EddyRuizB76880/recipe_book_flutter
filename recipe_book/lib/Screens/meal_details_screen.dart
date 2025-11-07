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
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 96,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor.withAlpha(190),
                          Theme.of(context).primaryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Text(
                      mealDetails['strCategory'],
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 96,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor.withAlpha(190),
                          Theme.of(context).primaryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Text(
                      mealDetails['strArea'],
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            if (mealDetails['strSource'].length > 1)
              TextButton(
                onPressed: () async {
                  await launchUrl(Uri.parse(mealDetails['strSource']));
                },
                child: Text('Recipe taken from ${mealDetails['strSource']}'),
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
              if (mealDetails['strMeasure$index'].length > 1)
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
            for (final step in mealDetails['strInstructions'].split("\r\n"))
              if (step.length > 1)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    step,
                    style: TextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: RecipeBookAppBar(title: title),
      body: SafeArea(child: content),
    );
  }
}
