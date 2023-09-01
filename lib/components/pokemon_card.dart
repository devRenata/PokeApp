import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../pages/pokemon_details_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonCard extends StatefulWidget {
  final PokemonList pokemonList;
  const PokemonCard({Key? key, required this.pokemonList}) : super(key: key);

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  @override
  void initState() {
    super.initState();
    _fetchPokemonInfo();
  }

  // buscando as informações do Pokémon associado ao card
  Future<PokemonInfo> _fetchPokemonInfo() async {
    final response = await http.get(Uri.parse(widget.pokemonList.url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final abilities = (data['abilities'] as List<dynamic>)
          .map((ability) => ability['ability']['name'] as String)
          .toList();

      final types = (data['types'] as List<dynamic>)
          .map((type) => type['type']['name'] as String)
          .toList();

      final stats = (data['stats'] as List<dynamic>)
          .map((stat) => {
                'name': stat['stat']['name'],
                'base_stat': stat['base_stat'],
              })
          .toList();

      return PokemonInfo(
        id: data['id'],
        name: data['name'],
        baseExperience: data['base_experience'],
        height: data['height'],
        order: data['order'],
        weight: data['weight'],
        image: data['sprites']['other']['official-artwork']['front_default'],
        species: data['species'] as Map<String, dynamic>,
        types: types,
        abilities: abilities,
        stats: stats,
      );
    } else {
      throw Exception('Falha ao buscar informações do Pokémon');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PokemonInfo>(
      future: _fetchPokemonInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white.withOpacity(.1),
            width: double.infinity,
            height: 200,
          );
        } else if (snapshot.hasError) {
          return const Text('Erro ao buscar informações do Pokémon');
        } else if (snapshot.hasData) {
          final pokemonInfo = snapshot.data!;

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
                              pokemonInfo: pokemonInfo,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          _buildPokeballDecoration(height: itemHeight),
                          _buildPokemonOrder(order: pokemonInfo.id),
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
        return const SizedBox.shrink();
      },
    );
  }
}

Widget _buildPokeballDecoration({required double height}) {
  final pokeballSize = height * 0.8;
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
    right: 12,
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
