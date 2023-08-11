import 'package:flutter/material.dart';
import '/components/app_drawer.dart';

class PokemonOverviewPage extends StatelessWidget {
  const PokemonOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5FBFB),
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Row(
            children: const [Text('POKÉMONs')],
          ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            // itemCount: pokemonsList.lengt,
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                width: 50,
                color: Colors.blue,
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
    );
  }
}
