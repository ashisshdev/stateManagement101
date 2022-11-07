import 'package:provider101/samples/znews/data/local/database_helper/base_hive.dart';
import 'package:provider101/samples/znews/utils/failures.dart';

abstract class ArticlesLocalDB {
  Future<bool> saveArticle({required String key, required dynamic data});

  Future<dynamic> retrieveAllArticles({required String key});

  Future<bool> hasArticle({required String key});

  Future deleteArticle({required String key});

  Future clearAllArticles();
}

class ArticlesLocalDBImpl extends ArticlesLocalDB {
  final LocalDataBaseHelper localDataBaseHelper;
  ArticlesLocalDBImpl({required this.localDataBaseHelper});

  @override
  Future<bool> saveArticle({required String key, required dynamic data}) async {
    try {
      await localDataBaseHelper.set(key, data);
      return true;
    } catch (e) {
      throw const DatabaseFailure("Unable to cache data");
    }
  }

  @override
  Future<bool> hasArticle({required String key}) async {
    try {
      return localDataBaseHelper.has(key);
    } catch (e) {
      throw const DatabaseFailure("Unable to check data");
    }
  }

  @override
  Future<dynamic> retrieveAllArticles({required String key}) async {
    try {
      return await localDataBaseHelper.get(key);
    } catch (e) {
      throw const DatabaseFailure("Unable to fetch data");
    }
  }

  @override
  Future deleteArticle({required String key}) async {
    try {
      await localDataBaseHelper.remove(key);
    } catch (e) {
      throw const DatabaseFailure("Unable to delete data");
    }
  }

  @override
  Future clearAllArticles() async {
    try {
      await localDataBaseHelper.clear();
      return;
    } catch (e) {
      throw const DatabaseFailure("Unable to clear cache");
    }
  }
}
