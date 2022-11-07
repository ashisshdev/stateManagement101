import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:provider101/samples/znews/domain/Models/article.dart';
import 'package:provider101/samples/znews/domain/Models/cache_data.dart';
import 'package:provider101/samples/znews/domain/Repositories/articles_repo.dart';
import 'package:provider101/samples/znews/utils/urls.dart';

import 'articles_homepage_controller.dart';

class ArticlePageController extends ChangeNotifier {
  final ArticlesRepo articlesRepo;

  ArticlePageController({required this.articlesRepo});

  late Article _article;

  Article get article => _article;

  Status _status = Status.initial;

  Status get status => _status;

  late String _error;

  String get error => _error;

  late String _toast;

  String get toast => _toast;

  List<Article> _cachedArticles = [];

  fetchTheArticle({required String id}) async {
    _cachedArticles = [];
    _status = Status.loading;
    _toast = "Wait..";
    notifyListeners();

    bool isCacheDataAvailable = await articlesRepo.localHasArticle(key: Urls.specificArticle(id));

    fetchNewData() async {
      var freshData = await articlesRepo.remoteFetchArticleById(id: id);
      freshData.fold((failure) {
        if (_cachedArticles.isNotEmpty) {
          _status = Status.success;
          _toast = "Unable to fetch latest Articles";
          _article = _cachedArticles[0];
          notifyListeners();
        } else {
          _status = Status.error;
          _error = failure.message;
          _toast = "oops";
          notifyListeners();
        }
      }, (successCacheDataModel) async {
        var isLatestDataCached = await articlesRepo.localSaveArticles(
            key: Urls.specificArticle(id),
            cacheData: CacheData(articles: successCacheDataModel.articles, age: DateTime.now()));
        _cachedArticles =
            List<Article>.from([jsonDecode(successCacheDataModel.articles)].map((x) => Article.fromJson(x)));

        if (isLatestDataCached) {
          _status = Status.success;
          _toast = "yay";
          _article = _cachedArticles[0];
          notifyListeners();
        } else {
          _status = Status.success;
          _toast = "Error caching data.";
          _article = _cachedArticles[0];
          notifyListeners();
        }
      });
    }

    ///
    if (isCacheDataAvailable) {
      var cacheData = await articlesRepo.localRetrieveArticles(key: Urls.specificArticle(id));
      cacheData.fold((failure) {
        fetchNewData();
      }, (successData) {
//        _cachedArticles = List<Article>.from(Article.fromJson(successData.articles));
        _cachedArticles = List<Article>.from([jsonDecode(successData.articles)].map((x) => Article.fromJson(x)));
        if (successData.isValid) {
          _status = Status.success;
          _article = _cachedArticles[0];
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
