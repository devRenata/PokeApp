import 'package:flutter/material.dart';
import '../../models/pokemon.dart';

class PokemonDetailsPage extends StatelessWidget {
  final PokemonInfo pokemonInfo;
  const PokemonDetailsPage({
    Key? key,
    required this.pokemonInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokémon detalhes')),
      body: _buildPokemonDetails(pokemonInfo),
    );
  }

  Widget _buildPokemonDetails(PokemonInfo data) {
    return Column(
      children: [
        Image.network(
          data.image,
          height: 300,
          width: 300,
        ),
        Text('name: ${data.name}'),
        Text('heigth: ${data.height}'),
        Text('weigth: ${data.weight}'),
      ],
    );
  }
}
