import 'package:flutter/foundation.dart';
import '../models/github_user.dart';
import '../repository/github_repository.dart';

class GithubViewModel extends ChangeNotifier {
  final GithubRepository repository;

  GithubUser? user;
  bool loading = false;
  String? error;

  GithubViewModel({required this.repository});

  Future<void> load(String username) async {
    loading = true;
    error = null;
    user = null;
    notifyListeners();

    try {
      final u = await repository.getUser(username);
      if (u == null) error = 'User not found or network error';
      user = u;
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
