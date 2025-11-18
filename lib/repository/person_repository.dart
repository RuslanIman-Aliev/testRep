import 'package:flutter/material.dart';
import '../models/person.dart';
import '../services/person_storage_service.dart';

class PersonRepository with ChangeNotifier {
  final PersonStorageService _storage = PersonStorageService();
  List<Person> _items = [];

  // КОНСТРУКТОР ТЕПЕР ПУСТИЙ! Ми не запускаємо логіку тут.
  PersonRepository();

  List<Person> getAll() => _items;

  // ЦЕЙ МЕТОД МИ ВИКЛИЧЕМО В MAIN.DART
  Future<void> loadData() async {
    print("🔄 СТАРТ ЗАВАНТАЖЕННЯ...");
    try {
      final savedData = await _storage.loadPersons();
      
      if (savedData.isNotEmpty) {
        _items = savedData;
        print("✅ ЗАВАНТАЖЕНО ${savedData.length} ЗАПИСІВ З ПАМ'ЯТІ");
      } else {
        print("⚠️ ПАМ'ЯТЬ ПУСТА. СТВОРЮЮ ТЕСТОВІ ДАНІ.");
        _items = [
          Person(id: '1', name: 'Тестовий Іван', position: 'Dev', about: 'Data test'),
        ];
        // Відразу зберігаємо, щоб файл фізично створився
        await _storage.savePersons(_items);
      }
    } catch (e) {
      print("❌ ПОМИЛКА ЗАВАНТАЖЕННЯ: $e");
    }
    notifyListeners();
  }

  // --- Всі методи зміни даних ОБОВ'ЯЗКОВО зі збереженням ---

  Future<void> add(Person person) async {
    _items.add(person);
    notifyListeners(); 
    await _storage.savePersons(_items);
    print("💾 ДОДАНО ТА ЗБЕРЕЖЕНО: ${person.name}");
  }

  Future<Person> duplicate(String id) async {
    final existing = _items.firstWhere((p) => p.id == id);
    final newPerson = existing.copyWith(
      // генеруємо новий ID
    ); // (тут ваш код дублювання, головне new ID)
    
    // Якщо у вас в моделі немає методу для зміни ID через copyWith, створіть новий об'єкт вручну:
    final realNewPerson = Person(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: existing.name, 
        position: existing.position, 
        about: existing.about
    );

    _items.add(realNewPerson);
    notifyListeners();
    await _storage.savePersons(_items);
    return realNewPerson;
  }
  Person? getById(String id) {
    try {
      return _items.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
  // Оновлення (Update)
  Future<void> update(String id, {String? name, String? position, String? about}) async {
    final index = _items.indexWhere((p) => p.id == id);
    if (index != -1) {
        _items[index] = _items[index].copyWith(
            name: name, position: position, about: about
        );
        notifyListeners();
        await _storage.savePersons(_items);
        print("💾 ОНОВЛЕНО ТА ЗБЕРЕЖЕНО ID: $id");
    }
  }
}