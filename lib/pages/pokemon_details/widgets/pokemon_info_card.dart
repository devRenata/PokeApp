import 'package:flutter/material.dart';
import 'package:pokemonapp/models/pokemon.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'card_about_pokemon.dart';
import 'card_stats_pokemon.dart';

class PokemonInfoCard extends StatefulWidget {
  final PokemonInfo pokemonInfo;
  const PokemonInfoCard({Key? key, required this.pokemonInfo}) : super(key: key);
  static const double minCardHeightFraction = .54; // altura mínima do card de 54%

  @override
  State<PokemonInfoCard> createState() => _PokemonInfoCardState();
}

class _PokemonInfoCardState extends State<PokemonInfoCard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
      panel: TabBar(controller: _tabController, tabs: [
        Tab(
          text: 'Sobre',
          child: CardAboutPokemon(pokemonInfo: widget.pokemonInfo),
        ),
        Tab(
          text: 'Status',
          child: CardStatsPokemon(pokemonInfo: widget.pokemonInfo),
        ),
        Tab(
          text: 'Evolução',
          child: const Align(
            alignment: Alignment.topCenter,
            child: Text('Em desenvolvimento...'),
          ),
        ),
        Tab(
          text: 'Movimentos',
          child: const Align(
            alignment: Alignment.topCenter,
            child: Text('Em desenvolvimento...'),
          ),
        ),
      ]),
    );
  }
}
