import 'package:flutter/material.dart';
import '../../../models/pokemon.dart';

class CardAboutPokemon extends StatelessWidget {
  final PokemonInfo pokemonInfo;

  const CardAboutPokemon({required this.pokemonInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAbout(
          pokemonInfo.species,
          pokemonInfo.abilities,
          pokemonInfo.height,
          pokemonInfo.weight,
          pokemonInfo.types,
        ),
      ],
    );
  }

  Widget _buildAbout(
    Map<String, dynamic> specie,
    List<String> abilities,
    double height,
    double weight,
    List<String> types,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.12),
            offset: const Offset(0, 8),
            blurRadius: 23,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Espécie'),
                SizedBox(height: 11),
                Text(
                  'specie', // converter map par text aqui
                  style: TextStyle(
                    height: 0.8,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Height'),
                SizedBox(height: 11),
                Text(
                  '9',
                  style: TextStyle(
                    height: 0.8,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Weight'),
                SizedBox(height: 11),
                Text(
                  '18',
                  style: TextStyle(
                    height: 0.8,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Abilidades'),
                SizedBox(height: 11),
                Text(
                  'voar, correr', // converter lista para text
                  style: TextStyle(
                    height: 0.8,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Tipos'),
                SizedBox(height: 11),
                Text(
                  'fogo, vento', // converter lista para text
                  style: TextStyle(
                    height: 0.8,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
