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
  List<PokemonList> pokemonList = [];
  List<PokemonInfo> pokemonData = [];
  bool _isLoading = false;
  int offset = 0; // número da página
  int limit = 20; // número de pokemons por página, padrão de 20

  // if dentro do future builder
  // conectstate.done
  // adicionar medidas em altura e peso -> dividir por 10
  // unidades em: altura metro e peso em kg

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchPokemonList();
      }
    });
  }

  Future<void> _fetchPokemonInfo(String url) async {
    // Informações associadas a cada Pokémon
    return http.get(Uri.parse(url)).then((response) {
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
          image: data['sprites']['other']['official-artwork']['front_default'],
          species: data['species'] as Map<String, dynamic>,
          types: types,
          abilities: abilities,
          stats: stats,
        );

        pokemonData.add(pokemonInfo);
      } else {
        throw Exception('Falha ao buscar informações do Pokémon');
      }
    });
  }

  // Buscando os dados da API
  Future<List<PokemonInfo>> _fetchPokemonList() async {
    if (_isLoading) {
      return pokemonData;
    }
    _isLoading = true;
    // Future.wait(futures);
    // Lista de todos os Pokémon
    return http
        .get(Uri.parse('$baseUrl?offset=$offset&limit=$limit'))
        .then((responseList) {
      if (responseList.statusCode == 200) {
        var data = json.decode(responseList.body);

        final resultsList = data['results'] as List<dynamic>;
        final List<Future> resultFutures = [];
        for (var i = 0; i < resultsList.length; i++) {
          var poke = resultsList[i];

          pokemonList.add(PokemonList(
            name: poke['name'],
            url: poke['url'],
          ));

          final url = poke['url'] as String;
          resultFutures.add(_fetchPokemonInfo(url));
        }

        return Future.wait(resultFutures).then((f) {
          offset += limit;
          _isLoading = false;
          return pokemonData;
        });
      } else {
        print(
            'Falha na requisição da Lista de Pokémon: ${responseList.statusCode}');
        _isLoading = false;
        return pokemonData;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: const [],
      future: _fetchPokemonList(),
      builder: (context, snapshot) {
        if ((snapshot.hasData) &&
            (snapshot.connectionState == ConnectionState.done)) {
          List listPokemon = snapshot.data as List;
          var newsListSliver = SliverPadding(
            padding: const EdgeInsets.all(28),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
          );
          return CustomScrollView(
            controller: _scrollController,
            slivers: [newsListSliver],
          );
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