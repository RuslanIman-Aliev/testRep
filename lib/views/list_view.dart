import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../repository/person_repository.dart';
import '../models/person.dart';
import 'add_view.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<PersonRepository>(context);
    final items = repo.getAll();

    return Scaffold(
      appBar: AppBar(title: const Text('Список резюме')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final Person p = items[index];
          return ListTile(
            title: Text(p.name),
            subtitle: Text(p.position),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: 'Дублювати',
                  icon: const Icon(Icons.copy),
                  onPressed: () async{
                    final newPerson = await repo.duplicate(p.id);
                    
                    // Перевіряємо, чи екран ще активний перед навігацією
                    if (context.mounted) {
                      context.go('/profile/${newPerson.id}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Резюме дубльовано')),
                      );
                    }
                  },
                ),
                IconButton(
                  tooltip: 'Переглянути',
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () => context.go('/profile/${p.id}'),
                ),
              ],
            ),
            onTap: () {
              context.go('/profile/${p.id}');
            },
          );
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddView()),
          );
        },
      ),
    );
  }
}
