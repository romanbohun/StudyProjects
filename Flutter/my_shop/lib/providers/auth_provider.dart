import 'package:flutter/widgets.dart';
import 'package:my_shop/common/classes/result.dart';
import 'package:my_shop/models/auth/auth_response.dart';

import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final _authService = AuthService();

  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<Result> signUp(String email, String password) async {
    return _authService.signUp(email, password);
  }

  Future<Result> signIn(String email, String password) async {
    return _authService.signIn(email, password);
  }

}