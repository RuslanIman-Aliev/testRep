import 'package:flutter/foundation.dart';
import '../models/github_user.dart';
import '../services/github_service.dart';

class GithubRepository with ChangeNotifier {
  final GithubService service;
  GithubUser? _cached;

  GithubRepository({required this.service});

  GithubUser? get cached => _cached;

  Future<GithubUser?> getUser(String username) async {
    final user = await service.fetchUser(username);
    if (user != null) {
      _cached = user;
      notifyListeners();
    }
    return user;
  }
}
