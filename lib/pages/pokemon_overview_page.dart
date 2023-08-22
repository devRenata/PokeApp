import 'package:flutter/material.dart';
import 'package:pokemonapp/components/pokeball_background.dart';
import 'package:pokemonapp/models/pokemon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokemonapp/pages/pokemon_details_page.dart';

class PokemonOverviewPage extends StatefulWidget {
  const PokemonOverviewPage({super.key});

  @override
  State<PokemonOverviewPage> createState() => _PokemonOverviewPageState();
}

class _PokemonOverviewPageState extends State<PokemonOverviewPage> {
  // List<Pokemon> listaPokemons = [];
  // Future<List> pageData() async {
  //   final response =
  //       await http.Client().get(Uri.parse("https://pokeapi.co/api/v2/pokemon"));
  //   if (response.statusCode == 200) {
  //     var meusDados = json.decode(response.body);
  //     List pokemons = meusDados['results'];

  //     debugPrint("Dados: $pokemons");
  //     pokemons.forEach((pokemon) {
  //       Pokemon p = Pokemon(
  //         id: pokemon['id'],
  //         name: pokemon['name'],
  //         url: pokemon['url'],
  //       );
  //       listaPokemons.add(p
  //     });
  //     return listaPokemons;
  //   } else {
  //     throw Exception("Falha ao carregar os dados do aplicativo.");
  //   }
  // }

  final String baseUrl = "https://pokeapi.co/api/v2/pokemon/";
  List<Pokemon> pokemonList = [];

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

      if(data['results'] is List) {
        final resultsList = data['results'] as List<dynamic>;
        resultsList.forEach((pokemon) {
          pokemonList.add(Pokemon(
            name: pokemon['name'],
            url: pokemon['url']
          ));
        });
      }
    } else {
      print('Falha na requisição: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PokeballBackground(
      child: Stack(
        children: [
          CustomScrollView(
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PokemonDetailsPage(
                                pokemon: pokemon,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.blueGrey,
                          alignment: Alignment.center,
                          child: Text(pokemon.name),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
