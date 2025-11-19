import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/profile_view_model.dart';

class ProfileViewPage extends StatefulWidget {
  final ProfileViewModel vm;
  const ProfileViewPage({super.key, required this.vm});

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  @override
  void initState() {
    super.initState();
    widget.vm.addListener(_onChange);
  }

  @override
  void dispose() {
    widget.vm.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final person = widget.vm.person;
    
    if (person == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Профіль'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/'), 
          ),
        ),
        body: const Center(child: Text('Профіль не знайдено')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Назад',
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),

        title: Text(person.name),
        actions: [
          IconButton(
            onPressed: () {
              context.go('/profile/${person.id}/edit');
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(person.name, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(person.position),
            const SizedBox(height: 12),
            const Text('Про себе:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(person.about),
          ],
        ),
      ),
    );
  }
}