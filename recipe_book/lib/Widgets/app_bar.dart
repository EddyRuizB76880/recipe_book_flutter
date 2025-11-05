import 'package:flutter/material.dart';

class RecipeBookAppBar extends StatelessWidget implements PreferredSizeWidget {
  RecipeBookAppBar({super.key, this.title = 'My recipe book!'});

  String title;

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
