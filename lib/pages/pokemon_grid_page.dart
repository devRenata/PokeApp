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
  final String baseUrl = "https://pokeapi.co/api/v2/pokemon/";
  List<PokemonList> pokemonList = [];

  @override
  void initState() {
    super.initState();
    _fetchPokemonList();
  }

  // buscando a lista de todos os Pokémon da API
  Future<void> _fetchPokemonList() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("POKEMON RESULTS: $data");

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

  @override
  Widget build(BuildContext context) {
    return PokeballBackground(
      child: CustomScrollView(slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(28),
          sliver: _buildPokemonGrid(),
        ),
      ]),
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
          return PokemonCard(
              pokemonList: pokemonList[index]);
        },
      ),
    );
  }
}