import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider101/samples/weather/data/http/http_helper/app_exceptions.dart';
import 'package:provider101/samples/weather/data/http/http_helper/base_http.dart';

import '../../../../mocks.dart';
import '../../../../mocks.mocks.dart';

/// What is the purpose of base_http || Server ?
/// It provides a easy to use set of functions for communicating with the internet.
/// It is basically a boundary class.
/// Its only functions are receiving inputs and make calls and return results OR errors.
/// To test this class we need some pre-made results covering all the cases i.e. 200, 400s and 500s

void main() {
  late MockHttpClient mockHttpClient;
  late Server sut;
  BaseWeatherServerTestMockData baseHttpTestMockData = BaseWeatherServerTestMockData();

  setUp(() {
    mockHttpClient = MockHttpClient();
    sut = Server(client: mockHttpClient);
  });

  /// all success cases
  group(("testing response 200"), () {
    test(
      'test 1 with dummy data of Goa',
      () async {
        // arrange
        when(mockHttpClient.get(baseHttpTestMockData.getUriUrl(city: "goa")))
            .thenAnswer((_) => handleResponse(baseHttpTestMockData.goaResponse));
        // act
        final result = await sut.get(city: "goa");
        // assert
        expect(result, baseHttpTestMockData.goaResponse);
        verify(mockHttpClient.get(baseHttpTestMockData.getUriUrl(city: "goa"))).called(1);
      },
    );
    test(
      'test 1 with dummy data of Delhi',
      () async {
        // arrange
        when(mockHttpClient.get(baseHttpTestMockData.getUriUrl(city: "delhi")))
            .thenAnswer((_) => handleResponse(baseHttpTestMockData.delhiResponse));
        // act
        final result = await sut.get(city: "delhi");
        // assert
        expect(result, baseHttpTestMockData.delhiResponse);

        verify(mockHttpClient.get(baseHttpTestMockData.getUriUrl(city: "delhi"))).called(1);
      },
    );
  });

  /// all server error code cases
  group(("testing response 4XX"), () {
    test(
      'response code 401',
      () async {
        when(mockHttpClient.get(baseHttpTestMockData.getUriUrl(city: "city")))
            .thenAnswer((invocation) => handleResponse(baseHttpTestMockData.error401Response));
        expect(() async => await sut.get(city: "city"), throwsA(isInstanceOf<ApiKeyException>()));
        verify(mockHttpClient.get(baseHttpTestMockData.getUriUrl(city: "city"))).called(1);
      },
    );

    test(
      'response code 404',
      () async {
        when(mockHttpClient.get(baseHttpTestMockData.getUriUrl(city: "city")))
            .thenAnswer((invocation) => handleResponse(baseHttpTestMockData.error404Response));
        expect(() async => await sut.get(city: "city"), throwsA(isInstanceOf<IncorrectQueryException>()));
        verify(mockHttpClient.get(baseHttpTestMockData.getUriUrl(city: "city"))).called(1);
      },
    );

    test(
      'response code 429',
      () async {
        when(mockHttpClient.get(baseHttpTestMockData.getUriUrl(city: "city")))
            .thenAnswer((invocation) => handleResponse(baseHttpTestMockData.error429Response));
        expect(() async => await sut.get(city: 'city'), throwsA(isInstanceOf<FupLimitException>()));
        verify(mockHttpClient.get(baseHttpTestMockData.getUriUrl(city: "city"))).called(1);
      },
    );

    test(
      'response code 500',
      () async {
        when(mockHttpClient.get(baseHttpTestMockData.getUriUrl(city: "city")))
            .thenAnswer((invocation) => handleResponse(baseHttpTestMockData.error500Response));
        expect(() async => await sut.get(city: "city"), throwsA(isInstanceOf<ApiNotRespondingException>()));
        verify(mockHttpClient.get(baseHttpTestMockData.getUriUrl(city: "city"))).called(1);
      },
    );
  });

  /// all exceptions (app level exception)
  group(("testing exceptions"), () {
    test(
      'Socket/No-Connection Exception',
      () async {
        when(mockHttpClient.get(baseHttpTestMockData.getUriUrl(city: "city")))
            .thenThrow(NoConnectionException(code: 401, url: "url"));
        expect(() async => await sut.get(city: "city"), throwsA(isInstanceOf<NoConnectionException>()));
        verify(mockHttpClient.get(baseHttpTestMockData.getUriUrl(city: "city"))).called(1);
      },
    );
    test(
      'Invalid api format exception',
      () async {
        // arrange
        when(mockHttpClient.get(baseHttpTestMockData.getUriUrl(city: "city")))
            .thenThrow(InvalidFormatException(code: 404, url: "url"));
        expect(() async => await sut.get(city: "city"), throwsA(isInstanceOf<InvalidFormatException>()));
        verify(mockHttpClient.get(baseHttpTestMockData.getUriUrl(city: "city"))).called(1);
      },
    );
  });

  test(
    'Unknown Exception',
    () async {
      // arrange
      when(mockHttpClient.get(baseHttpTestMockData.getUriUrl(city: "city")))
          .thenThrow(UnknownException(code: 0, url: "url"));
      expect(() async => await sut.get(city: "city"), throwsA(isInstanceOf<UnknownException>()));
      verify(mockHttpClient.get(baseHttpTestMockData.getUriUrl(city: "city"))).called(1);
    },
  );
}
