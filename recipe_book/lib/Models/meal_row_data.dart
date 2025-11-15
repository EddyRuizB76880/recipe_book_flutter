class MealRowData {
  MealRowData({
    required this.strMeal,
    this.strMealThumb,
    required this.idMeal,
  });
  final String strMeal;
  final String? strMealThumb;
  final int idMeal;

  static List<MealRowData> fromJsonToMealList(Map<String, dynamic> jsonData){
    final List<MealRowData> meals = [];
   
    if (jsonData['meals'] == null) return [];

    for (final entry in jsonData['meals']) {
      meals.add(
        MealRowData(
          strMeal: entry['strMeal'],
          strMealThumb: entry['strMealThumb'],
          idMeal: int.parse(entry['idMeal']),
        ),
      );
    }
    return meals;
  }
}
