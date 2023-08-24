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
  int baseExperience;
  int height;
  bool isDefault;
  int order;
  int weigth;

  PokemonInfo({
    required this.id,
    required this.baseExperience,
    required this.height,
    required this.isDefault,
    required this.order,
    required this.weigth,
  });
}
