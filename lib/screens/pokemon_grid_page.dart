import 'package:flutter/material.dart';
import 'package:pokemonapp/components/pokeball_background.dart';
import 'package:pokemonapp/components/pokemon_card.dart';
import 'package:pokemonapp/models/pokemon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonGridPage extends StatefulWidget {
  const PokemonGridPage({Key? key}) : super(key: key);

  @override
  State<PokemonGridPage> createState() => _PokemonGridPageState();
}

class _PokemonGridPageState extends State<PokemonGridPage> {
  final String baseUrl = "https://pokeapi.glitch.me/v1/pokemon/";
  ScrollController _scrollController = ScrollController();
  List<Pokemon> pokemonList = [];

  @override
  void initState() {
    super.initState();
    _fetchPokemonList();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchPokemonList();
      }
    });
  }

  Future<void> _fetchPokemonList() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      final resultsList = data['results'] as List<dynamic>;
      resultsList.forEach((pokeList) async {
        final url = pokeList['url'];
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          var pokemonData = json.decode(response.body);

          final abilities =
              (pokemonData['abilities'] as List<dynamic>).map((ability) {
            final abilityMap = ability['ability'] as Map<String, dynamic>;
            return {
              'name': abilityMap['name'] as String,
            };
          }).toList();

          setState(() {
            pokemonList.add(Pokemon(
              number: pokemonData['number'],
              name: pokemonData['name'],
              species: pokemonData['species'],
              types: List<String>.from(pokemonData['types']),
              abilities: abilities,
              eggGroups: List<String>.from(pokemonData['eggGroups']),
              gender: List<double>.from(pokemonData['gender']),
              height: pokemonData['height'],
              weight: pokemonData['weight'],
              image: pokemonData['sprite'],
              description: pokemonData['description'],
            ));
          });
        }
      });
    } else {
      print('Falha na requisição de Pokémon: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PokeballBackground(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(28),
            sliver: _buildPokemonGrid(),
          ),
        ],
      ),
    );
  }

  _buildPokemonGrid() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      delegate: SliverChildBuilderDelegate(
        childCount: pokemonList.length,
        (BuildContext context, index) {
          return PokemonCard(pokemon: pokemonList[index]);
        },
      ),
    );
  }
}
