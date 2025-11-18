import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/github_user.dart';

class GithubService {
  final http.Client client;

  GithubService({http.Client? client}) : client = client ?? http.Client();

  Future<GithubUser?> fetchUser(String username) async {
    final url = Uri.parse('https://api.github.com/users/$username');
    final resp = await client.get(url);
    if (resp.statusCode == 200) {
      final json = jsonDecode(resp.body) as Map<String, dynamic>;
      return GithubUser.fromJson(json);
    }
    return null;
  }
}
