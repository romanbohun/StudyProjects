import 'package:http/http.dart' as http;

import '../common/classes/result.dart';
import '../common/errors/p_error.dart';

class FirebaseService {
  final baseUrl = 'https://myshop-fd2c2.firebaseio.com';
  final webApiKey = 'AIzaSyCUuo67yGH1z22U2LFh7pFwdoKVXHbpmdE';
  final String token;

  FirebaseService({
    this.token
  });

  Result<T> errorRequestResult<T>(http.Response response) {
    return Result(success: false, failure: PError(message: response.reasonPhrase.toString()));
  }

  Result<T> overallRequestError<T>(Error error) {
    return Result(success: false, failure: PError(message: 'Something went wrong during the request. Please try again later!'));
  }

}