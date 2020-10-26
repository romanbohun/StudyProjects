import 'package:flutter/material.dart';

import '../../common/errors/p_error.dart';

class Result<TData> {

  final TData data;
  final bool success;
  final PError failure;

  Result({
    @required this.success,
    this.data,
    this.failure,
  });

  Result.successful({TData data}) :
      success = true,
      data = data,
      failure = null;
}