class RequestHeader {
  int count;
  String next;
  String previous;

  RequestHeader({
    required this.count,
    required this.next,
    required this.previous,
  });
}

class PokemonList {
  String name;
  String url;

  PokemonList({
    required this.name,
    required this.url,
  });
}

class PokemonInfo {
  int id;
  String name;
  int baseExperience;
  int height;
  int weight;
  int order;
  String image;
  List<String> types;
  List<String> abilities;
  List<Map<String, dynamic>> stats;
  Map<String, dynamic> species;

  PokemonInfo({
    required this.id,
    required this.name,
    required this.baseExperience,
    required this.height,
    required this.order,
    required this.weight,
    required this.image,
    required this.types,
    required this.abilities,
    required this.stats,
    required this.species,
  });
}
