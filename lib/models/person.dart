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

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] as String,
      name: json['name'] as String,
      position: json['position'] as String,
      about: json['about'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'about': about,
    };
  }

  Person copyWith({String? name, String? position, String? about}) {
    return Person(
      id: id,
      name: name ?? this.name,
      position: position ?? this.position,
      about: about ?? this.about,
    );
  }
}