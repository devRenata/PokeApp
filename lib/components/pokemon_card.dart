import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/pokemon.dart';
import '../pages/pokemon_details_page.dart';

class PokemonCard extends StatelessWidget {
  final PokemonList pokemonList;

  const PokemonCard({Key? key, required this.pokemonList}) : super(key: key);

  Future<void> fetchPokemonInfo() async {
    final response = await http.get(Uri.parse(pokemonList.url.toString()));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("POKEMON INFORMAÇÕES: $data");

      final pokeInfo = data[]
    }
  }

  @override
  Widget build(BuildContext context) {
    // Layout responsivo
    return LayoutBuilder(
      builder: (context, constrains) {
        final itemHeight = constrains.maxHeight;
        final itemWidth = constrains.maxWidth;

        return Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.amber.withOpacity(0.4),
                blurRadius: 15,
                //offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Material(
              color: Colors.amber,
              child: InkWell(
                splashColor: Colors.white10,
                highlightColor: Colors.white10,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PokemonDetailsPage(
                        pokemonList: pokemonList,
                      ),
                    ),
                  );
                },
                // inserir LAYOUTBUILDER AQUI
                child: Stack(
                  children: [
                    _pokeballDecorationCard(height: itemHeight),
                    _pokemonOrderCard(height: itemHeight),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _pokeballDecorationCard({required double height}) {
  final pokeballSize = height * 0.70;

  return Positioned(
    bottom: -height * 0.09,
    right: -height * 0.02,
    child: Image.asset(
      'assets/images/pokeball.png',
      width: pokeballSize,
      height: pokeballSize,
      color: Colors.white.withOpacity(0.14),
    ),
  );
}

Widget _pokemonOrderCard({required double height}) {
  return Positioned(
    top: 10,
    right: 15,
    child: Text(
      '#008',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black12,
      ),
    ),
  );
}



// return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PokemonDetailsPage(
//               pokemon: pokemon,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         color: Colors.blueGrey,
//         alignment: Alignment.center,
//         child: Text(pokemon.name),
//       ),
//     );