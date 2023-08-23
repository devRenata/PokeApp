import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../pages/pokemon_details_page.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Layout responsivo
    return LayoutBuilder(
      builder: (context, constrains) {
        final itemHeight = constrains.maxHeight;

        return Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.amber.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Material(
              color: Colors.amber,
              child: InkWell(
                splashColor: Colors.white10,
                highlightColor: Colors.white10,
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
                child: Stack(
                  children: [
                    _pokeballDecorationCard(height: itemHeight)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Pokeball background card
Widget _pokeballDecorationCard({required double height}) {
  final pokeballSize = height * 0.75;

  return Positioned(
    bottom: -height * 0.15,
    right: -height * 0.15,
    child: Image.asset(
      'assets/images/pokeball.png',
      width: pokeballSize,
      height: pokeballSize,
      color: Colors.white.withOpacity(0.14),
    ),
  );
}

// return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PokemonDetailsPage(
//               pokemon: pokemon,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         color: Colors.blueGrey,
//         alignment: Alignment.center,
//         child: Text(pokemon.name),
//       ),
//     );