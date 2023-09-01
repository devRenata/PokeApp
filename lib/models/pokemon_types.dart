import 'package:flutter/material.dart';

enum PokemonTypes {
  grass,
  poison,
  fire,
  flying,
  water,
  bug,
  normal,
  electric,
  ground,
  fairy,
  fighting,
  psychic,
  rock,
  steel,
  ice,
  ghost,
  dragon,
  dark,
  monster,
  unknown,
}

extension PokemonTypesX on PokemonTypes {
  String getEnumValue(e) => e.toString().split('.').last;
  String get value => getEnumValue(this);

  static PokemonTypes parse(String rawValue) {
    final type = PokemonTypes.values.firstWhere(
      (element) => element.value.trim().toLowerCase() == rawValue.toLowerCase(),
      orElse: () => PokemonTypes.unknown,
    );
    return type;
  }

  Color get color {
    switch (this) {
      case PokemonTypes.grass:
        return const Color(0xFF78C850);

      case PokemonTypes.bug:
        return const Color(0xFF48D0B0);

      case PokemonTypes.fire:
        return const Color(0xFFFB6C6C);

      case PokemonTypes.water:
        return const Color(0xFF7AC7FF);

      case PokemonTypes.fighting:
        return const Color(0xFFFA6555);

      case PokemonTypes.normal:
        return const Color(0xFFA8A878);

      case PokemonTypes.electric:
        return const Color(0xFFFFCE4B);

      case PokemonTypes.psychic:
        return const Color(0xFFEE99AC);

      case PokemonTypes.poison:
        return const Color(0xFF9F5BBA);

      case PokemonTypes.ghost:
        return const Color(0xFF7C538C);

      case PokemonTypes.ground:
        return const Color(0xD0795548);

      case PokemonTypes.rock:
        return const Color(0xFFCA8179);

      case PokemonTypes.dark:
        return const Color(0xFF303943);

      case PokemonTypes.dragon:
        return const Color(0xD07038F8);

      case PokemonTypes.fairy:
        return const Color(0xFFF85888);

      case PokemonTypes.flying:
        return const Color(0xFFA890F0);

      case PokemonTypes.ice:
        return const Color(0xFF98D8D8);

      case PokemonTypes.steel:
        return const Color(0x64303943);
        
      default:
        return const Color(0xFF7AC7FF);
    }
  }
  
}

