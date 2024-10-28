import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'data/repositories/user_repository.dart';
import 'services/user_service.dart';
import 'presentation/pages/home_page.dart';

void main() {
  final client = http.Client();
  final repository = UserRepository(client: client);
  final userService = UserService(repository: repository);

  runApp(MyApp(userService: userService));
}

class MyApp extends StatelessWidget {
  final UserService userService;

  const MyApp({
    super.key,
    required this.userService,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juan Daniel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(userService: userService),
    );
  }
}
