import 'dart:convert';

import 'package:flutter/material.dart';

class AuthRequest {
  String email;
  String password;
  bool returnSecureToken;

  AuthRequest({
    @required this.email,
    @required this.password,
    this.returnSecureToken = true,
  });

  String toJson() => json.encode({
    'email': email,
    'password': password,
    'returnSecureToken': returnSecureToken
  });

}