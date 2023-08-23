import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../pages/pokemon_details_page.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetailsPage(
              pokemon: pokemon,
            ),
          ),
        );
      },
      child: Container(
        color: Colors.blueGrey,
        alignment: Alignment.center,
        child: Text(pokemon.name),
      ),
    );
  }
}
