import 'package:flutter/material.dart';
import 'package:pokemonapp/components/pokeball_background.dart';
import 'package:pokemonapp/components/pokemon_card.dart';
import 'package:pokemonapp/models/pokemon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonOverviewPage extends StatefulWidget {
  const PokemonOverviewPage({Key? key}) : super(key: key);

  @override
  State<PokemonOverviewPage> createState() => _PokemonOverviewPageState();
}

class _PokemonOverviewPageState extends State<PokemonOverviewPage> {
  final String baseUrl = "https://pokeapi.co/api/v2/pokemon/";
  List<PokemonList> pokemonList = [];
  List<PokemonInfo> pokemonInfoList = [];

  @override
  void initState() {
    super.initState();
    _fetchPokemonData();
  }

  Future<void> _fetchPokemonData() async {
    await _fetchPokemonList();
    await _fetchPokemonInfo();
  }

  // buscando a lista de todos os Pokémon da API
  Future<void> _fetchPokemonList() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // print("POKEMON RESULTS: $data");

      final resultsList = data['results'] as List<dynamic>;
      resultsList.forEach((pokeList) {
        pokemonList.add(PokemonList(
          name: pokeList['name'],
          url: pokeList['url'],
        ));
      });
    } else {
      print('Falha na requisição da Lista de Pokémon: ${response.statusCode}');
    }
  }

  // buscando as informações de cada Pokémon
  Future<void> _fetchPokemonInfo() async {
    for (final pokemonListItem in pokemonList) {
      final response = await http.get(Uri.parse(pokemonListItem.url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("POKEMON INFORMAÇÕES: $data");

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

        pokemonInfoList.add(PokemonInfo(
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
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PokeballBackground(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(28),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              delegate: SliverChildBuilderDelegate(
                childCount: pokemonList.length,
                (BuildContext context, int index) {
                  final pokemonL = pokemonList[index];
                  final pokemonI = pokemonInfoList[index];
                  return PokemonCard(pokemonList: pokemonL, pokemonInfo: pokemonI);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
