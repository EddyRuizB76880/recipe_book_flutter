import 'package:flutter/material.dart';

class RecipeBookAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RecipeBookAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(context) {
    return AppBar(
      title: Text(
        'My Recipe Book!',
        style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
