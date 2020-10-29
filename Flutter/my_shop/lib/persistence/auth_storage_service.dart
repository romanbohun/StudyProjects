import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../persistence/storage_service.dart';
import '../models/auth/auth_model.dart';

class AuthStorageService implements StorageService<AuthModel> {
  final String _key = "auth_info";

  @override
  void add(AuthModel value) async {
    final preference = await SharedPreferences.getInstance();
    preference.setString(_key, value?.toJson());
  }

  @override
  Future<AuthModel> get() async {
    final preference = await SharedPreferences.getInstance();
    if (!preference.containsKey(_key)) {
      return null;
    }
    final data = json.decode(preference.getString(_key));
    return AuthModel.fromJson(data);
  }

}