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

  @override
  void initState() {
    super.initState();
    fetchPokemonList();
  }

  // buscando a lista de Pokémon da API
  Future<void> fetchPokemonList() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("POKEMON RESULTS: $data");

      final resultsList = data['results'] as List<dynamic>;
      resultsList.forEach((pokemon) {
        pokemonList.add(PokemonList(
          name: pokemon['name'],
          url: pokemon['url'],
        ));
      });
    } else {
      print('Falha na requisição da Lista de Pokémon: ${response.statusCode}');
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
                  final pokemon = pokemonList[index];
                  return PokemonCard(pokemonList: pokemon);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
