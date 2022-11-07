import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:provider101/samples/counter/counter_provider.dart';
import 'package:provider101/samples/weather/data/http/http_helper/base_http.dart';
import 'package:provider101/samples/weather/data/http/weather_api.dart';
import 'package:provider101/samples/weather/domain/repository/weather_repo.dart';
import 'package:provider101/samples/znews/data/http/articles_remote_datasource.dart';
import 'package:provider101/samples/znews/data/http/http_helper/base_server.dart';
import 'package:provider101/samples/znews/data/local/articles_local_datasource.dart';
import 'package:provider101/samples/znews/data/local/database_helper/base_hive.dart';
import 'package:provider101/samples/znews/domain/Repositories/articles_repo.dart';
import 'package:provider101/samples/znews/presentation/controllers/article_page_controller.dart';
import 'package:provider101/samples/znews/presentation/controllers/articles_homepage_controller.dart';

import 'samples/weather/presentation/controllers/weather_provider.dart';
import 'samples/znews/presentation/controllers/author_page_controller.dart';

final locator = GetIt.instance;

void init() async {
  /// using top to bottom approach

  /// data
  // external package
  locator.registerLazySingleton(() => http.Client());

  // http base client
  // server as in weather project
  locator.registerLazySingleton<Server>(() => Server(client: locator()));
  // server as in znews project
  locator.registerLazySingleton<BaseHttp>(() => BaseHttp(client: locator()));

  // remote data sources
  locator.registerLazySingleton<WeatherApiService>(() => WeatherApiServiceImpl(server: locator()));
  locator.registerLazySingleton<ArticlesRemote>(() => ArticlesRemoteImpl(server: locator()));

  // local dataSources
  locator.registerLazySingleton<LocalDataBaseHelper>(() => LocalDataBaseHelperHiveImpl());
  await locator<LocalDataBaseHelper>().init();

  /// initialising hive db
  locator.registerLazySingleton<ArticlesLocalDB>(() => ArticlesLocalDBImpl(localDataBaseHelper: locator()));

  /// domain
  // repositories
  // weather
  locator.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(apiService: locator()));
  // news
  locator.registerLazySingleton<ArticlesRepo>(
      () => ArticlesRepoImpl(articlesRemote: locator(), articlesLocalDB: locator()));

  /// presentation
  // controllers as factories
  locator.registerFactory(() => CounterProvider());
  locator.registerFactory(() => WeatherProvider(weatherDataRepo: locator()));
  locator.registerFactory(() => ArticlesHomePageController(articlesRepo: locator()));
  locator.registerFactory(() => AuthorPageController(articlesRepo: locator()));
  locator.registerFactory(() => ArticlePageController(articlesRepo: locator()));
}
