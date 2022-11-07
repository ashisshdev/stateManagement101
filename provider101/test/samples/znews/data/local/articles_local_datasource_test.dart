import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mockito/mockito.dart';
import 'package:provider101/samples/znews/data/local/articles_local_datasource.dart';
import 'package:provider101/samples/znews/utils/failures.dart';

import '../../../mocks.mocks.dart';

class ArticlesLocalDBMockData {
  final String dummyKey = "Key";
  final Map<String, String> data = {"data": "something data"};
}

void main() {
  late ArticlesLocalDB sut;
  late MockLocalDataBaseHelper mockLocalDataBaseHelper;

  final ArticlesLocalDBMockData mockData = ArticlesLocalDBMockData();

  setUp(() {
    mockLocalDataBaseHelper = MockLocalDataBaseHelper();
    sut = ArticlesLocalDBImpl(localDataBaseHelper: mockLocalDataBaseHelper);
  });

  group("success cases", () {
    test(
      "local save articles",
      () async {
        when(mockLocalDataBaseHelper.set(mockData.dummyKey, mockData.data))
            .thenAnswer((realInvocation) async => await Future.value(true));
        expect(await sut.saveArticle(key: mockData.dummyKey, data: mockData.data), true);
      },
    );

    test(
      "local check if articles available",
      () async {
        when(mockLocalDataBaseHelper.has(mockData.dummyKey)).thenReturn(true);
        expect(await sut.hasArticle(key: mockData.dummyKey), true);
      },
    );

    test(
      "local retrieve articles",
      () async {
        when(mockLocalDataBaseHelper.get(mockData.dummyKey))
            .thenAnswer((realInvocation) async => await Future.value(dynamic));
        expect(await sut.retrieveAllArticles(key: mockData.dummyKey), dynamic);
      },
    );

    test(
      "local remove article(s)",
      () async {
        when(mockLocalDataBaseHelper.remove(mockData.dummyKey)).thenAnswer((realInvocation) async {
          return;
        });
        expect(await sut.deleteArticle(key: mockData.dummyKey), null);
      },
    );

    test(
      "local clear all articles",
      () async {
        when(mockLocalDataBaseHelper.clear()).thenAnswer((_) async {
          return;
        });
        expect(await sut.clearAllArticles(), null);
      },
    );
  });

  group("failure cases", () {
    test(
      "local save articles",
      () async {
        when(mockLocalDataBaseHelper.set(mockData.dummyKey, mockData.data))
            .thenThrow(HiveError("Unable to cache data"));

        expect(() async => await sut.saveArticle(key: mockData.dummyKey, data: mockData.data),
            throwsA(isInstanceOf<DatabaseFailure>()));
      },
    );

    test(
      "local check if articles available",
      () async {
        when(mockLocalDataBaseHelper.has(mockData.dummyKey)).thenThrow(HiveError("message"));
        expect(() async => await sut.hasArticle(key: mockData.dummyKey), throwsA(isA<DatabaseFailure>()));
      },
    );

    test(
      "local retrieve articles",
      () async {
        when(mockLocalDataBaseHelper.get(mockData.dummyKey)).thenThrow(HiveError("message"));
        expect(() async => await sut.retrieveAllArticles(key: mockData.dummyKey), throwsA(isA<DatabaseFailure>()));
      },
    );

    test(
      "local remove article(s)",
      () async {
        when(mockLocalDataBaseHelper.remove(mockData.dummyKey)).thenThrow(HiveError(""));
        expect(() async => await sut.deleteArticle(key: mockData.dummyKey), throwsA(isA<DatabaseFailure>()));
      },
    );

    test(
      "local clear all articles",
      () async {
        when(mockLocalDataBaseHelper.clear()).thenThrow(HiveError("message"));
        expect(() async => await sut.clearAllArticles(), throwsA(isInstanceOf<DatabaseFailure>()));
      },
    );
  });
}
