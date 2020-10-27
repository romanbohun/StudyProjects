import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/models/auth/auth_response.dart';

import '../common/errors/p_error.dart';
import '../common/classes/result.dart';
import '../services/firebase_service.dart';
import '../models/auth/auth_request.dart';

class AuthService extends FirebaseService {
  String _authUrl(String action) {
    return 'https://identitytoolkit.googleapis.com/v1/accounts:$action?key=$webApiKey';
  }

  String _signUpUrl() {
    return _authUrl('signUp');
  }

  String _signInUrl() {
    return _authUrl('signInWithPassword');
  }

  @override
  Result<T> errorRequestResult<T>(http.Response response) {
    final responseData = json.decode(response.body);
    final errorMessage = responseData['error']['message'];
    var message = 'Authentication failed';

    switch(errorMessage) {
      case 'EMAIL_EXISTS':
        message = 'This email address is already in use!';
        break;
      case 'INVALID_EMAIL':
        message = 'This is not a valid email address!';
        break;
      case 'WEAK_PASSWORD':
        message = 'This password is too weak!';
        break;
      case 'EMAIL_NOT_FOUND':
        message = 'Could not find a user with that email.';
        break;
      case 'INVALID_PASSWORD':
        message = 'Invalid password';
    }
    return Result(success: false, failure: PError(message: message));
  }

  @override
  Result<T> overallRequestError<T>(Error error) {
    return Result(success: false, failure: PError(message: 'Could not authenticate you. Please try again later.'));
  }

  Future<Result<AuthResponse>> signUp(String email, String password) async {
    try {
      final authRequest = AuthRequest(email: email, password: password);
      final response = await http.post(
          _signUpUrl(),
          body: authRequest.toJson()
      );
      if (response.statusCode != 200) {
        // A user-oriented error message should be provided here
        return errorRequestResult(response);
      }
      final authData = AuthResponse.fromJson(json.decode(response.body));
      return Result.successful(data: authData);
    } catch (error) {
      return overallRequestError(error);
    }
  }

  Future<Result<AuthResponse>> signIn(String email, String password) async {
    try {
      final authRequest = AuthRequest(email: email, password: password);
      final response = await http.post(
          _signInUrl(),
          body: authRequest.toJson()
      );
      if (response.statusCode != 200) {
        // A user-oriented error message should be provided here
        return errorRequestResult(response);
      }
      final authData = AuthResponse.fromJson(json.decode(response.body));
      return Result.successful(data: authData);
    } catch (error) {
      return overallRequestError(error);
    }
  }

}