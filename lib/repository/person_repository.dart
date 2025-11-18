import 'package:flutter/material.dart';
import '../models/person.dart';
import '../services/person_storage_service.dart';

class PersonRepository with ChangeNotifier {
  // Підключаємо наш новий сервіс
  final PersonStorageService _storage = PersonStorageService();
  
  List<Person> _items = [];

  // КОНСТРУКТОР
  PersonRepository() {
    _loadData();
  }

  // Завантаження даних (без async!)
  void _loadData() {
    final savedData = _storage.loadPersons();

    if (savedData.isNotEmpty) {
      _items = savedData;
    } else {
      // Якщо це перший запуск - створюємо тестового
      _items = [
        Person(id: '1', name: 'Тестовий GetStorage', position: 'Web', about: 'Працює швидко!')
      ];
      // І відразу зберігаємо
      _storage.savePersons(_items);
    }
  }

  // --- МЕТОДИ УПРАВЛІННЯ ---

  List<Person> getAll() => _items;

  Person? getById(String id) {
    try {
      return _items.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  // Додавання
  void add(Person person) {
    _items.add(person);
    _storage.savePersons(_items); // Миттєве збереження
    notifyListeners();
  }

  // Оновлення
  void update(String id, {String? name, String? position, String? about}) {
    final index = _items.indexWhere((p) => p.id == id);
    if (index != -1) {
      _items[index] = _items[index].copyWith(
        name: name, position: position, about: about
      );
      _storage.savePersons(_items); // Миттєве збереження
      notifyListeners();
    }
  }

  // Дублювання
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
    _storage.savePersons(_items); // Миттєве збереження
    notifyListeners();
    return newPerson; // Повертаємо об'єкт відразу, без Future
  }
}