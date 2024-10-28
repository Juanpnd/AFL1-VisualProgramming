import 'dart:convert';

import 'package:coba1/core/error/exceptions.dart';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../models/user_model.dart';

class UserRepository {
  final http.Client client;

  UserRepository({required this.client});

  Future<List<UserModel>> getUsers() async {
    try {
      final url =
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}');
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to fetch users');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
