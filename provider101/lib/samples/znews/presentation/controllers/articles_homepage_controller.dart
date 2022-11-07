import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider101/samples/znews/domain/Models/article.dart';
import 'package:provider101/samples/znews/domain/Models/cache_data.dart';
import 'package:provider101/samples/znews/domain/Repositories/articles_repo.dart';
import 'package:provider101/samples/znews/utils/urls.dart';

class ArticlesHomePageController extends ChangeNotifier {
  final ArticlesRepo articlesRepo;

  ArticlesHomePageController({required this.articlesRepo}) {
    /// as soon as this provider is initialised by the service locator
    /// this function will trigger
//    fetchAllArticles();
  }

  List<Article> _articles = [];

  List<Article> get articles => _articles;

  Status _status = Status.initial;

  Status get status => _status;

  late String _error;

  String get error => _error;

  late String _toast;

  String get toast => _toast;

  String inTheArticleHomePage = "In the Articles Home Page Controller";

  List<Article> _cachedArticles = [];

  fetchAllArticles() async {
    print("fetch all articles method start");

    _status = Status.loading;
    _toast = "wait..";
    notifyListeners();

    bool isCacheDataAvailable = await articlesRepo.localHasArticle(key: Urls.allArticles);

    fetchNewData() async {
      print("fetching new data now");

      var freshData = await articlesRepo.remoteFetchArticlesAll();
      freshData.fold((failure) {
        print("failed fetching new data");

        if (_cachedArticles.isNotEmpty) {
          print("updating with invalid old cached data");

          _status = Status.success;
          _articles = _cachedArticles;
          _toast = "Unable to fetch latest Articles";
          notifyListeners();
        } else {
          print("Only chance of showing error to user");

          _status = Status.success;
          _error = failure.message;
          _toast = "Unable to fetch latest Articles";
          notifyListeners();
        }
      }, (successCacheDataModel) async {
        print("yup received data from internet successfully");

        var isLatestDataCached = await articlesRepo.localSaveArticles(
            key: Urls.allArticles, cacheData: CacheData(articles: successCacheDataModel.articles, age: DateTime.now()));
        _cachedArticles =
            List<Article>.from(jsonDecode(successCacheDataModel.articles).map((x) => Article.fromJson(x)));
        if (isLatestDataCached) {
          print("latest data is cached , updating ui now");

          _status = Status.success;
          _articles = _cachedArticles;
          _toast = "yay";
          notifyListeners();
        } else {
          print("latest data is not cached , still updating ui now");

          _status = Status.success;
          _articles = _cachedArticles;
          _toast = "Error Caching Data";
          notifyListeners();
        }
      });
    }

    ///
    if (isCacheDataAvailable) {
      print("Yes cached data available");
      var cacheData = await articlesRepo.localRetrieveArticles(key: Urls.allArticles);
      cacheData.fold((failure) {
        print("Error fetching cached data");
        fetchNewData();
      }, (successData) {
        print("successfully cached cached data");
        _cachedArticles = List<Article>.from(jsonDecode(successData.articles).map((x) => Article.fromJson(x)));
        if (successData.isValid) {
          print("Data is valid updating widgets now");
          _status = Status.success;
          _articles = _cachedArticles;
          _toast = "yay";
          notifyListeners();
        } else {
          print("cached Data is not valid updating widgets now");
          fetchNewData();
        }
      });
    } else {
      print("no cached data available");
      fetchNewData();
    }
  }
}

enum Status { initial, loading, success, error }
