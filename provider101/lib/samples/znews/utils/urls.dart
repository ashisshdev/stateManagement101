class Urls {
  static const String baseUrl = 'https://dev.to/api';

  /// Articles
  static const String allArticles = '$baseUrl/articles';

  static String specificArticle(String id) => '$allArticles/$id';

  static String author(String username) => "$allArticles?username=$username";
}
