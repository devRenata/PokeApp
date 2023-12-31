import 'package:flutter/material.dart';

class PokeballBackground extends StatelessWidget {
  final Widget child;
  const PokeballBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const double mainAppbarPadding = 28;

    // Calculando tamanhos e margens
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final pokeballSize = MediaQuery.of(context).size.width * 0.664;
    final appBarHeight = AppBar().preferredSize.height;
    const iconButtonPadding = mainAppbarPadding;
    final iconSize = IconTheme.of(context).size ?? 0;

    final pokeballTopMargin =
        -(pokeballSize / 2 - safeAreaTop - appBarHeight / 2) + 20;
    final pokeballRightMargin =
        -(pokeballSize / 2 - iconButtonPadding - iconSize / 2) + 20;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: pokeballTopMargin,
            right: pokeballRightMargin,
            child: Image.asset(
              'assets/images/pokeball.png',
              width: pokeballSize,
              height: pokeballSize,
              color: const Color(0xFFF5F5F6),
            ),
          ),
          child,
        ],
      ),
    );
  }
}