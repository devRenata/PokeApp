import 'package:flutter/material.dart';
import 'package:pokemonapp/models/pokemon.dart';
import '/components/app_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonOverviewPage extends StatefulWidget {
  const PokemonOverviewPage({super.key});

  @override
  State<PokemonOverviewPage> createState() => _PokemonOverviewPageState();
}

class _PokemonOverviewPageState extends State<PokemonOverviewPage> {
  List<Pokemon> listaPokemons = [];

  Future<List> pageData() async {
    final response =
        await http.Client().get(Uri.parse("https://pokeapi.co/api/v2/pokemon"));
    if (response.statusCode == 200) {
      var meusDados = json.decode(response.body);
      List pokemons = meusDados['results'];

      debugPrint("Dados: $pokemons");
      pokemons.forEach((pokemon) {
        Pokemon p = Pokemon(
          id: pokemon['id'],
          name: pokemon['name'],
          url: pokemon['url'],
        );
        listaPokemons.add(p);
      });
      return listaPokemons;
    } else {
      throw Exception("Falha ao carregar os dados do aplicativo.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5FBFB),
      appBar: AppBar(title: Text('Pokedex')),
      body: Text('POKÉMONs'),
      endDrawer: const AppDrawer(),
    );
  }
}

// FutureBuilder(
//         initialData: const [],
//         future: pageData(),
//         builder: (context, snapshot) {},
//       ),

// Column(
//         children: [
//           Row(
//             children: const [Text('POKÉMONs')],
//           ),
//           GridView.builder(
//             gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//               maxCrossAxisExtent: 200,
//               childAspectRatio: 1,
//               crossAxisSpacing: 20,
//               mainAxisSpacing: 20,
//             ),
//             itemCount: meuteste.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 height: 50,
//                 width: 50,
//                 color: Colors.blue,
//               );
//             },
//           ),
//         ],
//       ),