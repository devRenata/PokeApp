import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemonapp/models/pokemon.dart';
import '../models/pokemon_types.dart';
import '../screens/pokemon_details_page.dart';

class PokemonCard extends StatelessWidget {
  final PokemonInfo pokemonInfo;

  const PokemonCard({Key? key, required this.pokemonInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = PokemonTypesX.parse(pokemonInfo.types[0].color);

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
                    _buildPokeballDecoration(height: itemHeight),
                    _buildPokemonOrder(order: pokemonInfo.number),
                    _buildPokemonImage(
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

Widget _buildPokeballDecoration({required double height}) {
  final pokeballSize = height * 0.75;
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

Widget _buildPokemonOrder({required int order}) {
  final formattedOrder = '#${order.toString().padLeft(3, '0')}';
  return Positioned(
    top: 12,
    right: 10,
    child: Text(
      formattedOrder,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black12,
      ),
    ),
  );
}

Widget _buildPokemonImage({required double height, required pokeInfo}) {
  final pokemonSize = height * 0.75;
  return Positioned(
    bottom: -1,
    right: 1.5,
    child: Hero(
      tag: '${pokeInfo.name} image',
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutQuint,
        padding: EdgeInsets.zero,
        child: CachedNetworkImage(
          imageUrl: pokeInfo.image,
          useOldImageOnUrlChange: true,
          maxWidthDiskCache: 700,
          maxHeightDiskCache: 700,
          fadeInDuration: const Duration(milliseconds: 120),
          fadeOutDuration: const Duration(milliseconds: 120),
          imageBuilder: (context, image) => Image(
            image: image,
            width: pokemonSize,
            height: pokemonSize,
            alignment: Alignment.bottomCenter,
            fit: BoxFit.contain,
          ),
          placeholder: (_, __) => Image(
            image: pokeInfo.image,
            width: pokemonSize,
            height: pokemonSize,
            alignment: Alignment.bottomCenter,
            color: Colors.black12,
            fit: BoxFit.contain,
          ),
        ),
      ),
    ),
  );
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
