import 'package:get_storage/get_storage.dart';
import '../models/person.dart';

class PersonStorageService {
  final _box = GetStorage();
  static const String _key = 'persons_list';

  List<Person> loadPersons() {
    final List<dynamic>? storedList = _box.read(_key);

    if (storedList == null) {
      return []; 
    }
    return storedList.map((e) => Person.fromJson(e)).toList();
  }

  void savePersons(List<Person> persons) {
    final List<Map<String, dynamic>> jsonList = 
        persons.map((p) => p.toJson()).toList();
    
    _box.write(_key, jsonList);
  }
}