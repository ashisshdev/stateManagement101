import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:provider101/samples/znews/domain/Models/article.dart';
import 'package:provider101/samples/znews/domain/Models/author.dart';
import 'package:provider101/samples/znews/domain/Models/cache_data.dart';
import 'package:provider101/samples/znews/domain/Repositories/articles_repo.dart';
import 'package:provider101/samples/znews/utils/urls.dart';

import 'articles_homepage_controller.dart';

class AuthorPageController extends ChangeNotifier {
  final ArticlesRepo articlesRepo;

  AuthorPageController({required this.articlesRepo});

  late Author _author;

  Author get author => _author;

  List<Article> _articles = [];

  List<Article> get articles => _articles;

  Status _status = Status.initial;

  Status get status => _status;

  late String _error;

  String get error => _error;

  late String _toast;

  String get toast => _toast;

  List<Article> _cachedArticles = [];

  populateAuthorPage({required String username}) async {
    _cachedArticles = [];
    _status = Status.loading;
    _toast = "Wait..";
    notifyListeners();

    bool isCacheDataAvailable = await articlesRepo.localHasArticle(key: Urls.author(username));

    fetchNewData() async {
      var freshData = await articlesRepo.remoteFetchArticlesAuthor(username: username);
      freshData.fold((failure) {
        if (_cachedArticles.isNotEmpty) {
          _status = Status.success;
          _toast = "Unable to fetch latest Articles";
          _articles = _cachedArticles;
          _author = _cachedArticles[0].author!;
          notifyListeners();
        } else {
          _status = Status.error;
          _error = failure.message;
          _toast = "oops";
          notifyListeners();
        }
      }, (successCacheDataModel) async {
        var isLatestDataCached = await articlesRepo.localSaveArticles(
            key: Urls.author(username),
            cacheData: CacheData(articles: successCacheDataModel.articles, age: DateTime.now()));
        _cachedArticles =
            List<Article>.from(jsonDecode(successCacheDataModel.articles).map((x) => Article.fromJson(x)));
        if (isLatestDataCached) {
          _status = Status.success;
          _toast = "yay";
          _articles = _cachedArticles;
          _author = _cachedArticles[0].author!;
          notifyListeners();
        } else {
          _status = Status.success;
          _toast = "Error caching data.";
          _articles = _cachedArticles;
          _author = _cachedArticles[0].author!;
          notifyListeners();
        }
      });
    }

    ///
    if (isCacheDataAvailable) {
      var cacheData = await articlesRepo.localRetrieveArticles(key: Urls.author(username));
      cacheData.fold((failure) {
        fetchNewData();
      }, (successData) {
        _cachedArticles = List<Article>.from(jsonDecode(successData.articles).map((x) => Article.fromJson(x)));
        if (successData.isValid) {
          _status = Status.success;
          _articles = _cachedArticles;
          _author = _cachedArticles[0].author!;
          _toast = "yay";
          notifyListeners();
        } else {
          fetchNewData();
        }
      });
    } else {
      fetchNewData();
    }
  }
}
