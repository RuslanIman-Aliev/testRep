import 'package:flutter/material.dart';
import '../models/person.dart';
import '../services/person_storage_service.dart';

class PersonRepository with ChangeNotifier {
  final PersonStorageService _storage = PersonStorageService();
  
  List<Person> _items = [];

  PersonRepository() {
    _loadData();
  }

  void _loadData() {
    final savedData = _storage.loadPersons();

    if (savedData.isNotEmpty) {
      _items = savedData;
    } else {
      _items = [
        Person(id: '1', name: 'Тестовий GetStorage', position: 'Web', about: 'Працює швидко!')
      ];
      _storage.savePersons(_items);
    }
  }


  List<Person> getAll() => _items;

  Person? getById(String id) {
    try {
      return _items.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void add(Person person) {
    _items.add(person);
    _storage.savePersons(_items);
    notifyListeners();
  }

  void update(String id, {String? name, String? position, String? about}) {
    final index = _items.indexWhere((p) => p.id == id);
    if (index != -1) {
      _items[index] = _items[index].copyWith(
        name: name, position: position, about: about
      );
      _storage.savePersons(_items);
      notifyListeners();
    }
  }

  Person duplicate(String id) {
    final existing = getById(id);
    if (existing == null) throw Exception('Not found');

    final newPerson = Person(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: existing.name,
      position: existing.position,
      about: existing.about,
    );

    _items.add(newPerson);
    _storage.savePersons(_items); 
    return newPerson; 
  }
}