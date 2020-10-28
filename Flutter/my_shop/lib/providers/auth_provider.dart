import 'package:flutter/widgets.dart';
import 'package:my_shop/common/classes/result.dart';
import 'package:my_shop/models/auth/auth_response.dart';

import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final _authService = AuthService();

  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return false;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<Result<AuthResponse>> signUp(String email, String password) async {
    final result = await _authService.signUp(email, password);
    if (result.success) {
      _setParameters(result);
    }
    return result;
  }

  Future<Result<AuthResponse>> signIn(String email, String password) async {
    final result = await _authService.signIn(email, password);
    if (result.success) {
      _setParameters(result);
    }
    return result;
  }

  void _setParameters(Result<AuthResponse> result) {
    _token = result.data.idToken;
    _expiryDate = DateTime.now().add(Duration(seconds: int.parse(result.data.expiresIn)));
    _userId = result.data.localId;
    notifyListeners();
  }

}