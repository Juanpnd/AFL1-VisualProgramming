// lib/presentation/pages/home_page.dart

import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../../services/user_service.dart';
import '../widgets/user_card.dart';

class HomePage extends StatefulWidget {
  final UserService userService;

  const HomePage({
    Key? key,
    required this.userService,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<UserModel>> _usersFuture;
  List<UserModel> _users = [];
  bool _isSortedByName = false;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    setState(() {
      _usersFuture = widget.userService.getUsers();
      _usersFuture.then((users) {
        setState(() {
          _users = users;
        });
      });
    });
  }

  void _sortUsersByName() {
    setState(() {
      _isSortedByName = !_isSortedByName;
      _users.sort((a, b) => _isSortedByName
          ? a.name.compareTo(b.name)
          : b.name.compareTo(a.name));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Directory'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadUsers,
            tooltip: 'Refresh data',
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _sortUsersByName,
            tooltip: 'Sort by name',
          ),
        ],
      ),
      body: FutureBuilder<List<UserModel>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadUsers,
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                _loadUsers();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    final user = _users[index];
                    return UserCard(
                      user: user,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Selected user: ${user.name}'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
