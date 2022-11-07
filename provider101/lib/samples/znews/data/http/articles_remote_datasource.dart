import 'package:http/http.dart' as http;

import 'http_helper/base_server.dart';

abstract class ArticlesRemote {
  Future<http.Response> getAllArticles({required String url});

  Future<http.Response> getArticleById({required String url});

  Future<http.Response> getArticlesByAuthor({required String url});
}

class ArticlesRemoteImpl extends ArticlesRemote {
  final BaseHttp server;
  ArticlesRemoteImpl({required this.server});

  @override
  Future<http.Response> getAllArticles({required String url}) async {
    return await server.get(url);
  }

  @override
  Future<http.Response> getArticleById({required String url}) async {
    return await server.get(url);
  }

  @override
  Future<http.Response> getArticlesByAuthor({required String url}) async {
    return await server.get(url);
  }
}
