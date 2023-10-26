import 'package:flutter/material.dart';
import '../../../models/pokemon.dart';

class CardAboutPokemon extends StatelessWidget {
  final PokemonInfo pokemonInfo;

  const CardAboutPokemon({required this.pokemonInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return _buildAbout(
      pokemonInfo.species,
      pokemonInfo.abilities,
      pokemonInfo.height,
      pokemonInfo.weight,
      pokemonInfo.types,
    );
  }

  Widget _buildAbout(
    Map<String, dynamic>? specie,
    List<String>? abilities,
    int? height,
    String? weight,
    List<String>? types,
  ) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Height',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                (height != null && height is String)
                    ? height as String
                    : "Desconhecido",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
              height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Weight',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 11),
              Text(
                weight ?? "Desconhecido",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
              height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Abilities',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                abilities?.join(", ") ?? "Nenhuma",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
              height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Types',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                types?.join(", ") ?? "Nenhum",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
