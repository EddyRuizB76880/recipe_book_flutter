import 'package:flutter/material.dart';


class RecipeBookNavBar extends StatefulWidget {
  RecipeBookNavBar({super.key, required this.index, required this.onDestinationTapped});

  int index;
  final Function onDestinationTapped;

  @override
  State<RecipeBookNavBar> createState() {
    return _RecipeBookNavBarState();
  }
}

class _RecipeBookNavBarState extends State<RecipeBookNavBar>{
    final List<String> labels = ['Categories', 'My Favorite Meals', 'Search Recipe'];
    
    @override
    Widget build(BuildContext context) {  
    return NavigationBar(
      onDestinationSelected: (int index) {
        widget.onDestinationTapped(index, labels[index]);
      },
      indicatorColor: Theme.of(context).primaryColor.withAlpha(128),
      selectedIndex: widget.index,
      destinations: <Widget>[
        NavigationDestination(
          icon: Icon(Icons.restaurant),
          label: labels[0],
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite),
          label: labels[1],
        ),
        NavigationDestination(
          icon:  Icon(Icons.search),
          label: labels[2],
        ),
      ],
    
    );
  }

}
