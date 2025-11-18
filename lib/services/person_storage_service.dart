import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/person.dart';

class PersonStorageService {
  static const _key = 'persons_data';

  // ЗБЕРЕЖЕННЯ
  Future<void> savePersons(List<Person> persons) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(persons.map((p) => p.toJson()).toList());
    
    // print("💾 [DEBUG] Пытаюсь сохранить: $jsonString");
    final success = await prefs.setString(_key, jsonString);
    
    if (success) {
      print("✅ [DEBUG] Успішно збережено в пам'ять!");
    } else {
      print("❌ [DEBUG] Помилка збереження SharedPreferences!");
    }
  }

  // ЗАВАНТАЖЕННЯ
  Future<List<Person>> loadPersons() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Перевіряємо, чи є ключ взагалі
    if (!prefs.containsKey(_key)) {
      print("📂 [DEBUG] Ключ '$_key' не знайдено (це перший запуск або дані стерті).");
      return [];
    }

    final String? jsonString = prefs.getString(_key);
    if (jsonString == null || jsonString.isEmpty) {
      print("📂 [DEBUG] Дані пусті.");
      return [];
    }

    print("📂 [DEBUG] Прочитано з пам'яті: $jsonString");
    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Person.fromJson(json)).toList();
    } catch (e) {
      print("❌ [DEBUG] Помилка парсингу JSON: $e");
      return [];
    }
  }

  // МЕТОД, ЩОБ ПОДИВИТИСЯ "ФАЙЛ"
  Future<void> debugPrintStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    print("\n--- 🔍 ВМІСТ СХОВИЩА ---");
    print(data ?? "ПУСТО / NULL");
    print("------------------------\n");
  }
  
  // ОЧИСТКА (для тестів)
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    print("🗑️ [DEBUG] Сховище очищено.");
  }
}