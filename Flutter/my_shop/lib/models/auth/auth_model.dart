import 'dart:convert';

import 'package:flutter/foundation.dart';

class AuthModel {
  final String token;
  final DateTime expiryDate;
  final String userId;

  AuthModel({
    @required this.token,
    @required this.expiryDate,
    @required this.userId,
  });

  AuthModel.empty() :
        token = '',
        expiryDate = DateTime.now(),
        userId = '';

  AuthModel.fromJson(Map<String, dynamic> json) :
        token = json['token'],
        expiryDate = DateTime.parse(json['expireDate']) ,
        userId = json['userId'];

  String toJson() => json.encode({
    'token': token,
    'expireDate': expiryDate.toIso8601String(),
    'userID': userId,
  });

}