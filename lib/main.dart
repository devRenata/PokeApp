import 'package:flutter/material.dart';
import 'package:pokemonapp/components/pokeball_background.dart';
import '/pages/pokemon_overview_page.dart';

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
        child: PokemonOverviewPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
