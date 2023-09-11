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
  ScrollController _scrollController = ScrollController();
  List<PokemonList> pokemonList = [];
  bool _isLoading = false;
  int offset = 0;
  int limit = 20;

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

  // buscando a lista de todos os Pokémon da API
  Future<void> _fetchPokemonList() async {
    if (_isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final response =
        await http.get(Uri.parse('$baseUrl?offset=$offset&limit=$limit'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      final resultsList = data['results'] as List<dynamic>;
      resultsList.forEach((pokeList) {
        pokemonList.add(PokemonList(
          name: pokeList['name'],
          url: pokeList['url'],
        ));
      });

      setState(() {
        offset += limit;
        _isLoading = false;
      });
    } else {
      print('Falha na requisição da Lista de Pokémon: ${response.statusCode}');
      setState(() {
        _isLoading = false;
      });
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
          return PokemonCard(pokemonList: pokemonList[index]);
        },
      ),
    );
  }
}
