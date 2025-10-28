import 'package:flutter/material.dart';
import 'package:recipe_book/Models/category.dart';

class CategoryRow extends StatelessWidget{
  const CategoryRow({super.key, required this.category});
  final Category category;

  @override
  Widget build(context){
    return Row(children: [
      Image.network(category!.strCategoryThumb, width: 250, height: 250,),
      Text(category!.strCategory),
    ],);
  }
}