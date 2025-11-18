import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'repository/person_repository.dart';
import 'views/list_view.dart';
import 'views/profile_view.dart';
import 'views/edit_view.dart';
import 'viewmodels/profile_view_model.dart';

import 'services/github_service.dart';
import 'repository/github_repository.dart';
import 'viewmodels/github_view_model.dart';
import 'views/github_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PersonRepository()),
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
