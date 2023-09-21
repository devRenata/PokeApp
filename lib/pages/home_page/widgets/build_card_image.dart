import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget buildPokemonImage({required double height, required pokeInfo}) {
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