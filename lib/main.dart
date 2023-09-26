import 'package:flutter/material.dart';
import 'package:pokemonapp/pages/home/widgets/home_background.dart';
import 'pages/home/pokemon_grid_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poke App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.grey,
          secondary: Colors.blue,
        ),
        fontFamily: 'CircularStd',
      ),
      home: const PokeballBackground(
        child: PokemonGridPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
