// lib/views/add_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/person.dart';
import '../repository/person_repository.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _aboutController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _positionController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  void _savePerson() {
    if (_nameController.text.isEmpty) return;

    final newId = DateTime.now().millisecondsSinceEpoch.toString();

    final newPerson = Person(
      id: newId,
      name: _nameController.text,
      position: _positionController.text,
      about: _aboutController.text,
    );

    Provider.of<PersonRepository>(context, listen: false).add(newPerson);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Додати резюме'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Ім'я та Прізвище"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _positionController,
              decoration: const InputDecoration(labelText: "Посада"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _aboutController,
              decoration: const InputDecoration(labelText: "Про себе"),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _savePerson,
              child: const Text("Зберегти"),
            ),
          ],
        ),
      ),
    );
  }
}