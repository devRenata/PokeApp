import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/pokemon.dart';
import '../../../models/pokemon_types.dart';

class DetailsBackground extends StatelessWidget {
  const DetailsBackground({super.key, required this.pokemonInfo});
  final PokemonInfo pokemonInfo;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final itemHeight = constrains.maxHeight;
        return Stack(
          children: [
            _buildColorBackground(),
            _buildDottedDecoration(),
            _buildAppBarPokeballDecoraion(context),
            _buildButtonReturnToHome(context),
            _buildImagePokemon(itemHeight, context),
            _buildName(),
            _buildOrder(),
            ..._buildTypes(),
          ],
        );
      },
    );
  }

  Widget _buildColorBackground() {
    final backgroundColor = PokemonTypesX.parse(pokemonInfo.types[0]).color;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      constraints: const BoxConstraints.expand(),
      color: backgroundColor,
    );
  }

  Widget _buildDottedDecoration() {
    return Positioned(
      top: 120,
      right: 10,
      child: Image.asset(
        'assets/images/dotted.png',
        width: 78,
        height: 39,
        color: Colors.white24,
      ),
    );
  }

  Widget _buildAppBarPokeballDecoraion(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final pokeSize = screenSize.width * .7;
    final pokeballTopMargin = (pokeSize / 2 - 20);
    final pokeballRightMargin = (screenSize.width - pokeSize) / 2;

    return Positioned(
      top: pokeballTopMargin,
      right: pokeballRightMargin,
      child: IgnorePointer(
        child: Image.asset(
          'assets/images/pokeball.png',
          width: pokeSize,
          height: pokeSize,
          color: Colors.white24,
        ),
      ),
    );
  }

  Widget _buildButtonReturnToHome(BuildContext context) {
    return Positioned(
      top: 15,
      left: 20,
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 26,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildImagePokemon(double height, BuildContext context) {
    final pokemonSize = height * .35;
    final screenSize = MediaQuery.of(context).size;
    final pokemonImageRightMargin = (screenSize.width - pokemonSize) / 2;
    final pokemonTopMargin = (pokemonSize / 2 - 38);

    if (pokemonInfo.image == null) {
      return const SizedBox();
    } else {
      return Positioned(
        top: pokemonTopMargin,
        right: pokemonImageRightMargin,
        child: Hero(
          tag: '${pokemonInfo.image}',
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutQuint,
            padding: EdgeInsets.zero,
            child: CachedNetworkImage(
              imageUrl: pokemonInfo.image as String,
              useOldImageOnUrlChange: true,
              maxWidthDiskCache: 700,
              maxHeightDiskCache: 700,
              fadeInDuration: const Duration(milliseconds: 250),
              fadeOutDuration: const Duration(milliseconds: 120),
              imageBuilder: (context, image) => Image(
                image: image,
                width: pokemonSize,
                height: pokemonSize,
                alignment: Alignment.bottomCenter,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildName() {
    return Positioned(
      top: 55,
      left: 30,
      child: Text(
        pokemonInfo.name[0].toUpperCase() + pokemonInfo.name.substring(1),
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildOrder() {
    final formattedOrder = '#${pokemonInfo.order.toString().padLeft(3, '0')}';
    return Positioned(
      top: 60,
      right: 30,
      child: Text(
        formattedOrder,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  List<Widget> _buildTypes() {
    return [
      Positioned(
        top: 100,
        left: 30,
        child: Row(
          children: pokemonInfo.types.take(2).map((type) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    color: const Color(0xFFF5F5F6).withOpacity(.2),
                  ),
                  child: Text(
                    type,
                    textScaleFactor: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      height: .8,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ];
  }
}
