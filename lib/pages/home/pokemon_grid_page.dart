import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pokemonapp/pages/home/widgets/pokemon_card.dart';
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
  final ScrollController _scrollController = ScrollController();
  List<PokemonList> lista = [];
  List<PokemonInfo> listaPokemonInfo = [];
  List<PokemonList> pokemonList = [];
  List<PokemonInfo> pokemonData = [];
  //final bool _isLoading = false;
  int offset = 0; // número da página
  int limit = 20; // número de pokemons por página, padrão de 20

  @override
  void initState() {
    super.initState();

    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     _fetchPokemonList();
    //   }
    // });
  }

  Future<PokemonInfo> _fetchPokemonInfo(String url) async {
    final response = await http.Client().get(Uri.parse(url));
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

      final pokemonInfo = PokemonInfo(
        id: data['id'],
        name: data['name'],
        height:
            data['height'],
        order: data['order'],
        weight: data['width'],
        image: data['sprites']['other']['official-artwork']['front_default'],
        species: data['species'] as Map<String, dynamic>,
        types: types,
        abilities: abilities,
        stats: stats,
      );

      return pokemonInfo;
    } else {
      throw Exception('Falha ao buscar informações do Pokémon');
    }
  }

  Future<List<PokemonInfo>> _fetchPokemonList() async {
    final response =
        await http.Client().get(Uri.parse('$baseUrl?offset=$offset&limit=20'));
    if (response.statusCode == 200) {
      var meusDados = json.decode(response.body);
      List pokemons = meusDados['results'];
      for (var pokemon in pokemons) {
        PokemonInfo pokemoninfotemp = await _fetchPokemonInfo(pokemon['url']);
        listaPokemonInfo.add(pokemoninfotemp);
      }
    }
    return listaPokemonInfo;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: const [],
      future: _fetchPokemonList(),
      builder: (context, snapshot) {
        debugPrint("Estado da conexão: ${snapshot.connectionState}");
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            debugPrint("Snapshot2:${snapshot.data}");
            List<PokemonInfo> listPokemon = snapshot.data as List<PokemonInfo>;
            return CustomScrollView(
              //controller: _scrollController,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(28),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    delegate: SliverChildBuilderDelegate(
                      childCount: listPokemon.length,
                      (BuildContext context, index) {
                        return PokemonCard(pokemonInfo: listPokemon[index]);
                      },
                    ),
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: Text(
                'Erro na busca de dados',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFB6C6C),
            ),
          );
        }
      },
    );
  }
}
