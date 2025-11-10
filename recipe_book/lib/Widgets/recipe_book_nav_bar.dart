import 'package:flutter/material.dart';


class RecipeBookNavBar extends StatefulWidget {
  RecipeBookNavBar({super.key, required this.index, required this.onDestinationTapped});

  int index;
  Function onDestinationTapped;

  @override
  State<RecipeBookNavBar> createState() {
    return _RecipeBookNavBarState();
  }
}

class _RecipeBookNavBarState extends State<RecipeBookNavBar>{
    
    
    @override
    Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        widget.onDestinationTapped(index);
      },
      indicatorColor: Theme.of(context).primaryColor.withAlpha(128),
      selectedIndex: widget.index,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.restaurant),
          label: 'Categories',
        ),
        NavigationDestination(
          icon: Badge(child: Icon(Icons.calendar_month_outlined)),
          label: 'My daily menu',
        ),
      ],
    
    );
  }

}
