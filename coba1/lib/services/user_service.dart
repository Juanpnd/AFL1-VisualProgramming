import '../data/repositories/user_repository.dart';
import '../data/models/user_model.dart';

class UserService {
  final UserRepository repository;

  UserService({required this.repository});

  Future<List<UserModel>> getUsers() async {
    return await repository.getUsers();
  }
}
