import 'package:flutter/material.dart';
import 'package:pokemonapp/models/pokemon.dart';

class Stat extends StatelessWidget {
  final String label;
  final num value;

  const Stat({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 2,
          child: Text(label,
              style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .color!
                      .withOpacity(0.6))),
        ),
        Expanded(
          flex: 1,
          child: Text('$value'),
        ),
        const Expanded(
          child: LinearProgressIndicator(
            backgroundColor: Colors.red,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        )
      ],
    );
  }
}

class CardStatsPokemon extends StatelessWidget {
  final PokemonInfo pokemonInfo;
  const CardStatsPokemon({super.key, required this.pokemonInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildStats(pokemonInfo.stats),
        const SizedBox(height: 27),
        Text(
          'The effectiveness of each type on ${pokemonInfo.name}.',
          style: TextStyle(color: const Color(0xFF303943).withOpacity(0.6)),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildStats(List<Map<String, dynamic>> stats) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stat(label: 'Hp', value: stats[0]['base_stat']),
        const SizedBox(height: 14),
        Stat(label: 'Ataque', value: stats[1]['base_stat']),
        const SizedBox(height: 14),
        Stat(label: 'Defesa', value: stats[2]['base_stat']),
        const SizedBox(height: 14),
        Stat(label: 'Sp. Ata', value: stats[3]['base_stat']),
        const SizedBox(height: 14),
        Stat(label: 'Sp. Def', value: stats[4]['base_stat']),
        const SizedBox(height: 14),
        Stat(label: 'Velocidade', value: stats[5]['base_stat']),
        const SizedBox(height: 14),
        Stat(label: 'Total', value: stats[6]['base_stat']),
      ],
    );
  }
}
