import 'dart:math';
import 'package:flutter/material.dart';

import '../../../models/pokemon.dart';
import '../../../models/pokemon_types.dart';

class _BoxDecoration extends StatelessWidget {
  static const Size size = Size.square(1440);
  const _BoxDecoration();

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi * 5 / 12,
      alignment: Alignment.center,
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: const Alignment(-.2, -.2),
            end: const Alignment(1.5, -.3),
            colors: [
              Colors.white.withOpacity(.3),
              Colors.white.withOpacity(0),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsBackground extends StatelessWidget {
  const DetailsBackground({super.key, required this.pokemonInfo});
  final PokemonInfo pokemonInfo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildColorBackground(),
        _buildBoxDecoration(),
        _buildDottedDecoration(),
        _buildAppBarPokeballDecoraion(context),
      ],
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

  Widget _buildBoxDecoration() {
    return Positioned(
      top: -_BoxDecoration.size.height * .4,
      left: -_BoxDecoration.size.width * .4,
      child: const _BoxDecoration(),
    );
  }

  Widget _buildDottedDecoration() {
    const Size size = Size(57, 31);
    return Positioned(
      top: 4,
      right: 72,
      child: Image.asset(
        'assets/images/dotted.png',
        width: size.width,
        height: size.height,
      ),
    );
  }

  Widget _buildAppBarPokeballDecoraion(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final safeAreaTop = MediaQuery.of(context).padding.top;

    final pokeSize = screenSize.width * .5;
    final appBarHeight = AppBar().preferredSize.height;
    const iconButtonPadding = 5; // MUDAR DEPOIS
    final iconSize = IconTheme.of(context).size ?? 0;

    final pokeballTopMargin = -(pokeSize / 2 - safeAreaTop - appBarHeight / 2);
    final pokeballRightMargin = -(pokeSize / 2 - iconButtonPadding - iconSize / 2);

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
}
