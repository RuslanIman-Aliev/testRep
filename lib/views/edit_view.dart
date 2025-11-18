import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/profile_view_model.dart';
import '../widgets/simple_text_field.dart';

class EditViewPage extends StatefulWidget {
  final ProfileViewModel vm;
  const EditViewPage({super.key, required this.vm});

  @override
  State<EditViewPage> createState() => _EditViewPageState();
}

class _EditViewPageState extends State<EditViewPage> {
  late TextEditingController nameCtrl;
  late TextEditingController posCtrl;
  late TextEditingController aboutCtrl;

  @override
  void initState() {
    super.initState();
    final p = widget.vm.person;
    nameCtrl = TextEditingController(text: p?.name ?? '');
    posCtrl = TextEditingController(text: p?.position ?? '');
    aboutCtrl = TextEditingController(text: p?.about ?? '');
    widget.vm.addListener(_onVm);
  }

  @override
  void dispose() {
    widget.vm.removeListener(_onVm);
    nameCtrl.dispose();
    posCtrl.dispose();
    aboutCtrl.dispose();
    super.dispose();
  }

  void _onVm() => setState(() {});

  void save() {
    widget.vm.update(
      name: nameCtrl.text,
      position: posCtrl.text,
      about: aboutCtrl.text,
    );
    final id = widget.vm.person?.id;
    if (id != null) context.go('/profile/$id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Редагування')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SimpleTextField(controller: nameCtrl, label: 'Імʼя'),
            const SizedBox(height: 12),
            SimpleTextField(controller: posCtrl, label: 'Посада'),
            const SizedBox(height: 12),
            SimpleTextField(controller: aboutCtrl, label: 'Про себе', maxLines: 4),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: save, child: const Text('Зберегти')),
          ],
        ),
      ),
    );
  }
}
