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
  String? height;
  String? weight;
  int? order;
  String? image;
  List<String> types;
  List<String>? abilities;
  List<Map<String, dynamic>>? stats;
  Map<String, dynamic>? species;

  PokemonInfo({
    required this.id,
    required this.name,
    this.height,
    this.order,
    this.weight,
    this.image,
    required this.types,
    this.abilities,
    this.stats,
    this.species,
  });
}
