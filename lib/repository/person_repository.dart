import 'package:flutter/foundation.dart';
import '../models/person.dart';

class PersonRepository with ChangeNotifier {
  final List<Person> _items = [
    Person(
      id: '1',
      name: 'Іван Іванов',
      position: 'Junior  Developer',
      about: 'Прагну вчитись.',
    ),
    Person(
      id: '2',
      name: 'Марія Нестеренко',
      position: 'UI/UX Designer',
      about: 'Дизайн інтерфейсів',
    ),
    Person(
      id: '3',
      name: 'Іван Коваль',
      position: 'Frontend Developer',
      about: 'React, TypeScript та бажання вчити Flutter.',
    ),
  ];

  List<Person> getAll() => _items.map((p) => p).toList();

  Person? getById(String id) {
    try {
      return _items.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void update(String id, {String? name, String? position, String? about}) {
    final idx = _items.indexWhere((p) => p.id == id);
    if (idx == -1) return;
    final p = _items[idx];
    _items[idx] = p.copyWith(
      name: name ?? p.name,
      position: position ?? p.position,
      about: about ?? p.about,
    );
    notifyListeners();
  }

  void add(Person person) {
    _items.add(person);
    notifyListeners();
  }

  Person duplicate(String id) {
    final existing = getById(id);
    if (existing == null) {
      throw Exception('Person with id $id not found');
    }

    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    final newPerson = Person(
      id: newId,
      name: existing.name,
      position: existing.position,
      about: existing.about,
    );

    _items.add(newPerson);
    notifyListeners();
    return newPerson;
  }
}
