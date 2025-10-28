class Category {
  const Category({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  final int idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;

  static List<Category> fromJsonToCategories(Map<String, dynamic> jsonData) {
    final List<Category> categories = [];
    for (final entry in jsonData['categories']) {
      print(entry['idCategory'].runtimeType);
      categories.add(
        Category(
          idCategory: int.parse(entry['idCategory']),
          strCategory: entry['strCategory'],
          strCategoryThumb: entry['strCategoryThumb'],
          strCategoryDescription: entry['strCategoryDescription'],
        ),
      );
    }

    return categories;
  }
}
