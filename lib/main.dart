import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'repository/person_repository.dart';
import 'views/list_view.dart';
import 'views/profile_view.dart';
import 'views/edit_view.dart';
import 'viewmodels/profile_view_model.dart';
import 'package:get_storage/get_storage.dart';  
import 'services/github_service.dart';
import 'repository/github_repository.dart';
import 'viewmodels/github_view_model.dart';
import 'views/github_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Инициализируем хранилище (это очень быстро)
  await GetStorage.init();

  // 2. Создаем репозиторий (он сам загрузит данные внутри себя)
  final repo = PersonRepository();

  runApp(MyApp(repository: repo));
}

class MyApp extends StatelessWidget {
  final PersonRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       ChangeNotifierProvider.value(value: repository),
        Provider(create: (_) => GithubService(client: http.Client())),
        ChangeNotifierProvider(
            create: (context) =>
                GithubRepository(service: context.read<GithubService>())),
        ChangeNotifierProvider(
            create: (context) =>
                GithubViewModel(repository: context.read<GithubRepository>())),
      ],
      child: Builder(builder: (context) {
        final router = GoRouter(
          initialLocation: '/',
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const ListViewPage(),
            ),
            GoRoute(
              path: '/profile/:id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                final repo =
                    Provider.of<PersonRepository>(context, listen: false);
                final vm = ProfileViewModel(repository: repo, id: id);
                return ProfileViewPage(vm: vm);
              },
            ),
            GoRoute(
              path: '/profile/:id/edit',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                final repo =
                    Provider.of<PersonRepository>(context, listen: false);
                final vm = ProfileViewModel(repository: repo, id: id);
                return EditViewPage(vm: vm);
              },
            ),
            GoRoute(
              path: '/github',
              builder: (context, state) => const GithubViewPage(),
            ),
          ],
        );

        return MaterialApp.router(
          title: 'Resume Builder',
          theme: ThemeData(primarySwatch: Colors.blue),
          routerConfig: router,
        );
      }),
    );
  }
}
