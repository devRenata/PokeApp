import 'package:flutter/material.dart';

Widget buildPokeballDecoration({required double height}) {
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