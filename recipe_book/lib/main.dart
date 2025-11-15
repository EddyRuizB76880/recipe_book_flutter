import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book/Screens/home_screen.dart';
import 'package:recipe_book/State/favorite_meals_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteMealsCubit(),
      child: MaterialApp(
        title: 'Recipe Book.',

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(235, 223, 36, 36),
          ),
        ),
        home: HomeScreen()
      ),
    );
  }
}
