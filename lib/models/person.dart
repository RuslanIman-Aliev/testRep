class Person {
  final String id;
  String name;
  String position;
  String about;

  Person({
    required this.id,
    required this.name,
    required this.position,
    required this.about,
  });

  Person copyWith({String? name, String? position, String? about}) {
    return Person(
      id: id,
      name: name ?? this.name,
      position: position ?? this.position,
      about: about ?? this.about,
    );
  }
}
