import 'package:flutter/material.dart';
import 'package:pokemonapp/models/pokemon.dart';
import 'package:pokemonapp/pages/pokemon_details/widgets/details_background.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../models/pokemon_types.dart';
import 'card_about_pokemon.dart';
import 'card_stats_pokemon.dart';

class PokemonInfoCard extends StatefulWidget {
  final PokemonInfo pokemonInfo;
  const PokemonInfoCard({Key? key, required this.pokemonInfo})
      : super(key: key);
  static const double minCardHeightFraction =
      .54; // altura mínima do card de 54%

  @override
  State<PokemonInfoCard> createState() => _PokemonInfoCardState();
}

class _PokemonInfoCardState extends State<PokemonInfoCard>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final safeArea = MediaQuery.of(context).padding;
    final appBarHeight = AppBar().preferredSize.height;
    final cardMinHeight = screenHeight * PokemonInfoCard.minCardHeightFraction;
    final cardMaxHeight = screenHeight - appBarHeight - safeArea.top;

    return SlidingUpPanel(
      minHeight: cardMinHeight,
      maxHeight: cardMaxHeight,
      body: DetailsBackground(pokemonInfo: widget.pokemonInfo),
      panel: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(-8),
              child: TabBar(
                indicator: BoxDecoration(),
                indicatorColor: Colors.white,
                unselectedLabelColor: Colors.black54,
                tabs: [
                  Tab(
                    child: Text(
                      'About',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Stats',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Evolution',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Moves',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              CardAboutPokemon(pokemonInfo: widget.pokemonInfo),
              const Center(
                  child: Text('Em desenvolvimento...',
                      style: TextStyle(fontSize: 18))),
              const Center(
                  child: Text('Em desenvolvimento...',
                      style: TextStyle(fontSize: 18))),
              const Center(
                  child: Text('Em desenvolvimento...',
                      style: TextStyle(fontSize: 18))),
            ],
          ),
        ),
      ),
    );
  }
}
