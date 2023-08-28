import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../pages/pokemon_details_page.dart';

class PokemonCard extends StatelessWidget {
  final PokemonList pokemonList;
  final PokemonInfo pokemonInfo;
  PokemonCard({Key? key, required this.pokemonList, required this.pokemonInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pokemonInfo == null) {
      return const CircularProgressIndicator();
    }

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
                //offset: const Offset(0, 8),
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
                        pokemonList: pokemonList,
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    _pokeballDecorationCard(height: itemHeight),
                    _pokemonOrderCard(order: pokemonInfo.order),
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

Widget _pokeballDecorationCard({required double height}) {
  final pokeballSize = height * 0.70;

  return Positioned(
    bottom: -height * 0.09,
    right: -height * 0.02,
    child: Image.asset(
      'assets/images/pokeball.png',
      width: pokeballSize,
      height: pokeballSize,
      color: Colors.white.withOpacity(0.14),
    ),
  );
}

Widget _pokemonOrderCard({required int order}) {
  final formattedOrder = '#${order.toString().padLeft(3, '0')}';

  return Positioned(
    top: 10,
    right: 15,
    child: Text(
      formattedOrder,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black12,
      ),
    ),
  );
}