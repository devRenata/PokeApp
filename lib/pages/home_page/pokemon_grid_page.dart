import 'package:flutter/material.dart';
import 'package:pokemonapp/pages/home_page/widgets/home_background.dart';
import 'package:pokemonapp/pages/home_page/widgets/pokemon_card.dart';
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
  ScrollController _scrollController = ScrollController();
  List<PokemonList> pokemonList = [];
  bool _isLoading = false;
  int offset = 0;
  int limit = 20;

  @override
  void initState() {
    super.initState();
    //_fetchPokemonList();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchPokemonList();
      }
    });
  }

  // Buscando os dados da API
  Future<void> _fetchPokemonList() async {
    if (_isLoading) {
      return;
    }
    _isLoading = true;

    // Lista de todos os Pokémon
    final responseList =
        await http.get(Uri.parse('$baseUrl?offset=$offset&limit=$limit'));

    if (responseList.statusCode == 200) {
      var data = json.decode(responseList.body);

      final resultsList = data['results'] as List<dynamic>;
      resultsList.forEach(
        (pokeList) async {
          pokemonList.add(PokemonList(
            name: pokeList['name'],
            url: pokeList['url'],
          ));

          final url = pokeList['url'] as String;

          // Informações associadas a cada Pokémon
          final response = await http.get(Uri.parse(url));
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
              height: data['height'],
              order: data['order'],
              weight: data['weight'],
              image: data['sprites']['other']['official-artwork']
                  ['front_default'],
              species: data['species'] as Map<String, dynamic>,
              types: types,
              abilities: abilities,
              stats: stats,
            );
          } else {
            throw Exception('Falha ao buscar informações do Pokémon');
          }
        },
      );

      setState(() {
        offset += limit;
        _isLoading = false;
      });
    } else {
      print(
          'Falha na requisição da Lista de Pokémon: ${responseList.statusCode}');
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PokeballBackground(
      child: CustomScrollView(
        cacheExtent: 4000,
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
          return PokemonCard(hbhbhj);
        },
      ),
    );
  }
}
