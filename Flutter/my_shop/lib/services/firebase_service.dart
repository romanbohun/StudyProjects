import 'package:http/http.dart' as http;

import '../common/classes/result.dart';
import '../common/errors/p_error.dart';

class FirebaseService {
  final baseUrl = 'https://myshop-fd2c2.firebaseio.com';

  Result errorRequestResult(http.Response response) {
    return Result(success: null, failure: PError(message: response.reasonPhrase.toString()));
  }

}
