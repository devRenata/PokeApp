import 'package:flutter/material.dart';
import '../../models/pokemon.dart';
import 'widgets/pokemon_info_card.dart';

class PokemonDetailsPage extends StatelessWidget {
  final PokemonInfo pokemonInfo;
  const PokemonDetailsPage({
    Key? key,
    required this.pokemonInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildPokemonDetails(pokemonInfo);
  }

  Widget _buildPokemonDetails(PokemonInfo data) {
    return Scaffold(
      body: Stack(
        children: [
          PokemonInfoCard(pokemonInfo: pokemonInfo),
        ],
      ),
    );
  }
}
