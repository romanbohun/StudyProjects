import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:my_shop/models/auth/auth_model.dart';
import '../common/classes/result.dart';
import '../models/auth/auth_response.dart';
import '../persistence/auth_storage_service.dart';

import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final _authService = AuthService();
  final _authStorageService = AuthStorageService();

  AuthModel _authModel;
  Timer _authTimer;

  bool get isAuth {
    return _authModel?.token != null;
  }

  String get token {
    if (_authModel?.expiryDate != null &&
        _authModel.expiryDate.isAfter(DateTime.now()) &&
        _authModel?.token != null) {
      return _authModel?.token;
    }
    return null;
  }

  String get userId {
    return _authModel?.userId;
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

  void logout() {
    _authModel = null;
    _authTimer?.cancel();
    _authStorageService.add(AuthModel.empty());
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    _authModel = await _authStorageService.get();
    if (_authModel == null) {
      return false;
    }
    if (_authModel.expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    notifyListeners();
    _autoLogout();
    return true;
  }

  void _setParameters(Result<AuthResponse> result) {
    _authModel = AuthModel(
      token: result.data.idToken,
      expiryDate: DateTime.now().add(Duration(seconds: int.parse(result.data.expiresIn))),
      userId: result.data.localId,
    );
    _authStorageService.add(_authModel);
    _autoLogout();
    notifyListeners();
  }

  void _autoLogout() {
    _authTimer?.cancel();
    final timeToExpiry = _authModel?.expiryDate?.difference(DateTime.now())?.inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

}