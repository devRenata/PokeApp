import 'package:flutter/material.dart';
import '../../../models/pokemon.dart';
import '../../../models/pokemon_types.dart';
import '../../pokemon_details/pokemon_details_page.dart';
import '../pokemon_grid_page.dart';
import 'build_card_image.dart';
import 'build_card_order.dart';
import 'build_card_pokeball.dart';

class PokemonCard extends StatelessWidget {
  final PokemonInfo pokemonInfo;

  const PokemonCard({
    Key? key,
    required this.pokemonInfo,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
        final backgroundColor = PokemonTypesX.parse(pokemonInfo.types[0]).color;

        return LayoutBuilder(
          builder: (context, constrains) {
            final itemHeight = constrains.maxHeight;
            return Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: backgroundColor.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Material(
                  color: backgroundColor,
                  child: InkWell(
                    splashColor: Colors.white10,
                    highlightColor: Colors.white10,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PokemonDetailsPage(
                            pokemonInfo: pokemonInfo,
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        buildPokeballDecoration(height: itemHeight),
                        buildPokemonOrder(order: pokemonInfo.id),
                        buildPokemonImage(
                            height: itemHeight, pokeInfo: pokemonInfo),
                        _CardContent(pokemonInfo),
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

class _CardContent extends StatelessWidget {
  final PokemonInfo pokemonInfo;
  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  const _CardContent(this.pokemonInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Hero(
              tag: '${pokemonInfo.name} name',
              child: Text(
                capitalize(pokemonInfo.name),
                style: const TextStyle(
                    fontSize: 16,
                    height: .7,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            ..._buildTypes(context, pokemonInfo.types),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTypes(BuildContext context, types) {
    return pokemonInfo.types
        .take(2)
        .map(
          (type) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: ShapeDecoration(
                  shape: const StadiumBorder(),
                  color: const Color(0xFFF5F5F6).withOpacity(.2),
                ),
                child: Wrap(
                  children: [
                    Text(
                      type,
                      textScaleFactor: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        height: .8,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      '',
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontSize: 12,
                        height: .8,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .toList();
  }
}
