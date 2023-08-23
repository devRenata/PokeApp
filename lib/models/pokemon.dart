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

class Pokemon {
  String name;
  String url;

  Pokemon({
    required this.name,
    required this.url,
  });
}