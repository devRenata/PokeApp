import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget buildPokemonImage({required double height, required pokeInfo}) {
  final pokemonSize = height * 0.75;
  if (pokeInfo.image == null) {
    return const SizedBox();
  } else {
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
