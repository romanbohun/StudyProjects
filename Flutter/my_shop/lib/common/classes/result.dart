import '../../common/errors/p_error.dart';

class Result<TSuccess> {

  final TSuccess success;
  final PError failure;

  Result({
    this.success,
    this.failure,
  });
}