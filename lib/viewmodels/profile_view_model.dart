// lib/viewmodels/profile_view_model.dart
import 'package:flutter/foundation.dart';
import '../models/person.dart';
import '../repository/person_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final PersonRepository repository;
  final String id;

  ProfileViewModel({required this.repository, required this.id});

  Person? get person => repository.getById(id);

  void update({String? name, String? position, String? about}) {
    repository.update(id, name: name, position: position, about: about);
    notifyListeners();
  }
}
