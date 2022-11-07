import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:provider101/samples/znews/data/http/articles_remote_datasource.dart';
import 'package:provider101/samples/znews/data/local/articles_local_datasource.dart';
import 'package:provider101/samples/znews/domain/Models/cache_data.dart';
import 'package:provider101/samples/znews/utils/failures.dart';
import 'package:provider101/samples/znews/utils/urls.dart';

abstract class ArticlesRepo {
  /// Local DB Functions
  Future<bool> localSaveArticles({required String key, required CacheData cacheData});

  Future<Either<Failure, CacheData>> localRetrieveArticles({required String key});

  Future<bool> localHasArticle({required String key});

  Future<bool> localClearCache();

  /// Remote Service Functions
  Future<Either<Failure, CacheData>> remoteFetchArticlesAll();

  Future<Either<Failure, CacheData>> remoteFetchArticleById({required String id});

  Future<Either<Failure, CacheData>> remoteFetchArticlesAuthor({required String username});
}

/// Made a big Blunder
/// A repositories only job is to separate the services from the (controllers) i.e business logic
/// suppose we are using hive and in future decides to switch to sqflite, then we can easily do that without ever
/// touching the core businessLogic
/// because all the changing happens in the repository and it returns data to controller from different services
/// repository also does the modelling of data and error handling
/// I made the mistake of implementing the logic inside the repository and that backFired with unknown errors and
/// strange bugs

class ArticlesRepoImpl implements ArticlesRepo {
  final ArticlesRemote articlesRemote;
  final ArticlesLocalDB articlesLocalDB;

  ArticlesRepoImpl({required this.articlesRemote, required this.articlesLocalDB});

  /// Local DB Functions
  @override
  Future<bool> localSaveArticles({required String key, required CacheData cacheData}) async {
    try {
      return await articlesLocalDB.saveArticle(key: key, data: cacheData.toJson());
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<Failure, CacheData>> localRetrieveArticles({required String key}) async {
    try {
      var result = await articlesLocalDB.retrieveAllArticles(key: key);
      if (result != null) {
        return Right(CacheData.fromJson(result));
      } else {
        return const Left(DatabaseFailure("No Cached Data Available."));
      }
    } catch (e) {
      // return Left(e as Failure);
      return const Left(DatabaseFailure("No Cached Data Available."));
    }
  }

  @override
  Future<bool> localHasArticle({required String key}) async {
    try {
      var result = await articlesLocalDB.hasArticle(key: key);
      return result;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> localClearCache() async {
    try {
      var result = await articlesLocalDB.clearAllArticles();
      return result;
    } catch (e) {
      return false;
    }
  }

  /// Remote Service Functions
  @override
  Future<Either<Failure, CacheData>> remoteFetchArticlesAll() async {
    try {
      var result = await articlesRemote.getAllArticles(url: Urls.allArticles);
      if (result.statusCode == 200) {
        return Right(CacheData(articles: jsonEncode(jsonDecode(result.body)), age: DateTime.now()));
      } else {
        return const Left(ServerFailure("Unknown Error reaching Server."));
      }
    } catch (e) {
      return const Left(ServerFailure("Unknown Error reaching Server."));
    }
  }

  @override
  Future<Either<Failure, CacheData>> remoteFetchArticlesAuthor({required String username}) async {
    try {
      var result = await articlesRemote.getArticlesByAuthor(url: Urls.author(username));
      if (result.statusCode == 200) {
        return Right(CacheData(articles: jsonEncode(jsonDecode(result.body)), age: DateTime.now()));
      } else {
        return const Left(ServerFailure("Unknown Error reaching Server."));
      }
    } catch (e) {
      return const Left(ServerFailure("Unknown Error reaching Server."));
    }
  }

  @override
  Future<Either<Failure, CacheData>> remoteFetchArticleById({required String id}) async {
    try {
      var result = await articlesRemote.getArticlesByAuthor(url: Urls.specificArticle(id));
      if (result.statusCode == 200) {
        return Right(CacheData(articles: jsonEncode(jsonDecode(result.body)), age: DateTime.now()));
      } else {
        return const Left(ServerFailure("Unknown Error reaching Server."));
      }
    } catch (e) {
      return const Left(ServerFailure("Unknown Error reaching Server."));
    }
  }
}
