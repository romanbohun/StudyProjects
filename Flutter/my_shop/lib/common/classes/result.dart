class Result<TSuccess, TFailure> {

  final TSuccess success;
  final TFailure failure;

  Result({
    this.success,
    this.failure,
  });
}