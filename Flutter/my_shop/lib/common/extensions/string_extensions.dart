extension UrlToken on String {

  String addToken(String token) {
    return this + '?auth=$token';
  }

  String addFilterByCreator(String creatorId) {
    return this + 'orderBy="creatorId"&equalTo="$creatorId"';
  }

}