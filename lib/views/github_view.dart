import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/github_view_model.dart';

class GithubViewPage extends StatefulWidget {
  const GithubViewPage({super.key});

  @override
  State<GithubViewPage> createState() => _GithubViewPageState();
}

class _GithubViewPageState extends State<GithubViewPage> {
  final _controller = TextEditingController(text: 'RuslanIman-Aliev');

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<GithubViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('GitHub stats')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'GitHub username'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
                onPressed: () => vm.load(_controller.text.trim()),
                child: const Text('Load')),
            const SizedBox(height: 16),
            if (vm.loading) const CircularProgressIndicator(),
            if (vm.error != null) Text(vm.error!, style: const TextStyle(color: Colors.red)),
            if (vm.user != null) _buildInfo(vm),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(GithubViewModel vm) {
    final u = vm.user!;
    return Card(
      margin: const EdgeInsets.only(top:12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            if (u.avatarUrl != null)
              Image.network(u.avatarUrl!, height: 80),
            const SizedBox(height:8),
            Text(u.name ?? u.login, style: const TextStyle(fontSize:18, fontWeight: FontWeight.bold)),
            if (u.bio != null) Text(u.bio!),
            const SizedBox(height:8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _stat('Repos', u.publicRepos.toString()),
                _stat('Followers', u.followers.toString()),
                _stat('Following', u.following.toString()),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _stat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize:16, fontWeight: FontWeight.bold)),
        Text(label),
      ],
    );
  }
}
