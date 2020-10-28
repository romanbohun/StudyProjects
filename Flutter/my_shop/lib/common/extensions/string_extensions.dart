extension UrlToken on String {

  String addToken(String token) {
    return this + '?auth=$token';
  }

}