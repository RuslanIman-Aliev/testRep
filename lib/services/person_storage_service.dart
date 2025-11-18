import 'package:get_storage/get_storage.dart';
import '../models/person.dart';

class PersonStorageService {
  // Отримуємо доступ до сховища
  final _box = GetStorage();
  
  // Ключ, за яким будуть лежати дані
  static const String _key = 'persons_list';

  // ЗАВАНТАЖЕННЯ (Тепер це миттєво, без Future!)
  List<Person> loadPersons() {
    // Читаємо дані. Якщо їх немає - повертаємо null
    final List<dynamic>? storedList = _box.read(_key);

    if (storedList == null) {
      return []; // Якщо пусте - повертаємо пустий список
    }

    // Перетворюємо збережені JSON-дані назад у список Person
    return storedList.map((e) => Person.fromJson(e)).toList();
  }

  // ЗБЕРЕЖЕННЯ (Теж миттєво)
  void savePersons(List<Person> persons) {
    // Перетворюємо список об'єктів у список JSON (Map)
    final List<Map<String, dynamic>> jsonList = 
        persons.map((p) => p.toJson()).toList();
    
    // Записуємо в пам'ять
    _box.write(_key, jsonList);
  }
}