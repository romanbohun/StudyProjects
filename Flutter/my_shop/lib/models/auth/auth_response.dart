import 'dart:convert';

import 'package:flutter/material.dart';

class AuthResponse {
  String idToken;
  String email;
  String refreshToken;
  String expiresIn;
  String localId;
  bool registered;

  AuthResponse({
    this.idToken,
    this.email,
    this.refreshToken,
    this.expiresIn,
    this.localId,
    this.registered
  });

  AuthResponse.fromJson(Map<String, dynamic> json) :
        idToken = json['idToken'],
        email = json['email'],
        refreshToken = json['refreshToken'],
        expiresIn = json['expiresIn'],
        localId = json['localId'],
        registered = json['registered'];

}