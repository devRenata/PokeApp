import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonDetailsPage extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonDetailsPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokémon detalhes')),
      body: FutureBuilder(
        future: http.get(Uri.parse(pokemon.url.toString())),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final data = json.decode(snapshot.data!.body);
            return Column(
              children: [
                Image.network(data['sprites']['front_default']),
                Text('name: ${data['name']}'),
                Text('heigth: ${data['heigth']}'),
                Text('weigth: ${data['weigth']}'),
              ],
            );
          }
        },
      ),
    );
  }
}

