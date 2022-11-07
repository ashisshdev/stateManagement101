import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:provider101/samples/znews/data/http/articles_remote_datasource.dart';
import 'package:provider101/samples/znews/utils/failures.dart';
import 'package:provider101/samples/znews/utils/urls.dart';

import '../../../mocks.mocks.dart';

class ArticlesRemoteFakeData {
  static List<Map<String, dynamic>> json1AllArticles = [
    {
      "type_of": "article",
      "id": 1237077,
      "title": "Meme Monday ",
      "description":
          "Welcome to another Meme Monday post! Today's cover image comes from last week's thread.  DEV is an...",
      "readable_publish_date": "Oct 31",
      "slug": "meme-monday-31h9",
      "path": "/ben/meme-monday-31h9",
      "url": "https://dev.to/ben/meme-monday-31h9",
      "comments_count": 34,
      "public_reactions_count": 24,
      "collection_id": null,
      "published_timestamp": "2022-10-31T14:32:53Z",
      "positive_reactions_count": 24,
      "cover_image":
          "https://res.cloudinary.com/practicaldev/image/fetch/s--Zh012fVw--/c_imagga_scale,f_auto,fl_progressive,h_420,q_auto,w_1000/https://dev-to-uploads.s3.amazonaws.com/uploads/articles/4fiwdic4kccwdcscwijs.png",
      "social_image":
          "https://res.cloudinary.com/practicaldev/image/fetch/s--VzOtwSom--/c_imagga_scale,f_auto,fl_progressive,h_500,q_auto,w_1000/https://dev-to-uploads.s3.amazonaws.com/uploads/articles/4fiwdic4kccwdcscwijs.png",
      "canonical_url": "https://dev.to/ben/meme-monday-31h9",
      "created_at": "2022-10-31T14:32:53Z",
      "edited_at": null,
      "crossposted_at": null,
      "published_at": "2022-10-31T14:32:53Z",
      "last_comment_at": "2022-11-01T11:40:59Z",
      "reading_time_minutes": 1,
      "tag_list": ["discuss", "watercooler", "jokes"],
      "tags": "discuss, watercooler, jokes",
      "user": {
        "name": "Ben Halpern",
        "username": "ben",
        "twitter_username": "bendhalpern",
        "github_username": "benhalpern",
        "user_id": 1,
        "website_url": "http://benhalpern.com",
        "profile_image":
            "https://res.cloudinary.com/practicaldev/image/fetch/s--nz-jndal--/c_fill,f_auto,fl_progressive,h_640,q_auto,w_640/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/1/f451a206-11c8-4e3d-8936-143d0a7e65bb.png",
        "profile_image_90":
            "https://res.cloudinary.com/practicaldev/image/fetch/s--Ea1OGrCb--/c_fill,f_auto,fl_progressive,h_90,q_auto,w_90/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/1/f451a206-11c8-4e3d-8936-143d0a7e65bb.png"
      },
      "flare_tag": {"name": "discuss", "bg_color_hex": "#1ad643", "text_color_hex": "#FFFFFF"}
    },
    {
      "type_of": "article",
      "id": 1220464,
      "title": "Two months Intern to an Amazonian !",
      "description":
          "Amazon has always been my dream company. From fighting to pass all the test cases in the online...",
      "readable_publish_date": "Oct 28",
      "slug": "two-months-intern-to-an-amazonian--bd7",
      "path": "/ritikasingh02/two-months-intern-to-an-amazonian--bd7",
      "url": "https://dev.to/ritikasingh02/two-months-intern-to-an-amazonian--bd7",
      "comments_count": 2,
      "public_reactions_count": 3,
      "collection_id": null,
      "published_timestamp": "2022-10-28T07:07:20Z",
      "positive_reactions_count": 3,
      "cover_image":
          "https://res.cloudinary.com/practicaldev/image/fetch/s--3ynzv73p--/c_imagga_scale,f_auto,fl_progressive,h_420,q_auto,w_1000/https://dev-to-uploads.s3.amazonaws.com/uploads/articles/1g2h0d2xy9ylh1us3i55.png",
      "social_image":
          "https://res.cloudinary.com/practicaldev/image/fetch/s--Fsl7Fl-0--/c_imagga_scale,f_auto,fl_progressive,h_500,q_auto,w_1000/https://dev-to-uploads.s3.amazonaws.com/uploads/articles/1g2h0d2xy9ylh1us3i55.png",
      "canonical_url": "https://dev.to/ritikasingh02/two-months-intern-to-an-amazonian--bd7",
      "created_at": "2022-10-15T10:06:22Z",
      "edited_at": null,
      "crossposted_at": null,
      "published_at": "2022-10-28T07:07:20Z",
      "last_comment_at": "2022-10-29T06:04:44Z",
      "reading_time_minutes": 2,
      "tag_list": ["amazon", "faang", "ads", "aws"],
      "tags": "amazon, faang, ads, aws",
      "user": {
        "name": "RITIKA SINGH",
        "username": "ritikasingh02",
        "twitter_username": null,
        "github_username": "RitikaSingh02",
        "user_id": 939145,
        "website_url": "https://linkedin.com/in/ritika-singh02",
        "profile_image":
            "https://res.cloudinary.com/practicaldev/image/fetch/s--walhar_s--/c_fill,f_auto,fl_progressive,h_640,q_auto,w_640/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/939145/2faaaa36-1988-47af-b0a7-9d55d93059fd.jpeg",
        "profile_image_90":
            "https://res.cloudinary.com/practicaldev/image/fetch/s--6e8FK2k7--/c_fill,f_auto,fl_progressive,h_90,q_auto,w_90/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/939145/2faaaa36-1988-47af-b0a7-9d55d93059fd.jpeg"
      }
    },
    {
      "type_of": "article",
      "id": 1230921,
      "title": "Nightmare on Dev Street: Terrifying Situations to Make Your Spine Tingle",
      "description":
          "As a developer, your worst fears may include losing all your production data, servers going down, and...",
      "readable_publish_date": "Oct 27",
      "slug": "nightmare-on-dev-street-terrifying-situations-to-make-your-spine-tingle-50le",
      "path": "/airbrake/nightmare-on-dev-street-terrifying-situations-to-make-your-spine-tingle-50le",
      "url": "https://dev.to/airbrake/nightmare-on-dev-street-terrifying-situations-to-make-your-spine-tingle-50le",
      "comments_count": 3,
      "public_reactions_count": 9,
      "collection_id": null,
      "published_timestamp": "2022-10-27T13:00:11Z",
      "positive_reactions_count": 9,
      "cover_image":
          "https://res.cloudinary.com/practicaldev/image/fetch/s--YH8dQ17H--/c_imagga_scale,f_auto,fl_progressive,h_420,q_auto,w_1000/https://dev-to-uploads.s3.amazonaws.com/uploads/articles/9xariou94oz1024rnz9i.png",
      "social_image":
          "https://res.cloudinary.com/practicaldev/image/fetch/s--Eent9snu--/c_imagga_scale,f_auto,fl_progressive,h_500,q_auto,w_1000/https://dev-to-uploads.s3.amazonaws.com/uploads/articles/9xariou94oz1024rnz9i.png",
      "canonical_url":
          "https://dev.to/airbrake/nightmare-on-dev-street-terrifying-situations-to-make-your-spine-tingle-50le",
      "created_at": "2022-10-26T15:01:21Z",
      "edited_at": null,
      "crossposted_at": null,
      "published_at": "2022-10-27T13:00:11Z",
      "last_comment_at": "2022-10-28T13:00:32Z",
      "reading_time_minutes": 4,
      "tag_list": ["programming", "opensource", "github", "productivity"],
      "tags": "programming, opensource, github, productivity",
      "user": {
        "name": "Airbrake.io",
        "username": "airbrake",
        "twitter_username": "airbrake",
        "github_username": null,
        "user_id": 39881,
        "website_url": "https://www.airbrake.io",
        "profile_image":
            "https://res.cloudinary.com/practicaldev/image/fetch/s--sTdrsQN2--/c_fill,f_auto,fl_progressive,h_640,q_auto,w_640/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/39881/b370bbc8-e2f4-47cf-b413-51d6f93f0799.png",
        "profile_image_90":
            "https://res.cloudinary.com/practicaldev/image/fetch/s--sApkN9im--/c_fill,f_auto,fl_progressive,h_90,q_auto,w_90/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/39881/b370bbc8-e2f4-47cf-b413-51d6f93f0799.png"
      }
    }
  ];

  Response goodResponse1 = Response(jsonEncode(json1AllArticles), 200);
}

void main() {
  late ArticlesRemote sut;
  late MockBaseHttp mockBaseHttp;
  final ArticlesRemoteFakeData fakeData = ArticlesRemoteFakeData();

  setUp(() {
    mockBaseHttp = MockBaseHttp();
    sut = ArticlesRemoteImpl(server: mockBaseHttp);
  });

  test(
    "Success Cases ",
    () async {
      when(mockBaseHttp.get(Urls.allArticles)).thenAnswer((realInvocation) => Future.value(fakeData.goodResponse1));
      when(mockBaseHttp.get(Urls.author("username")))
          .thenAnswer((realInvocation) => Future.value(fakeData.goodResponse1));
      when(mockBaseHttp.get(Urls.specificArticle("12345")))
          .thenAnswer((realInvocation) => Future.value(fakeData.goodResponse1));
      expect(await sut.getAllArticles(url: Urls.allArticles), fakeData.goodResponse1);
      expect(await sut.getArticlesByAuthor(url: Urls.author("username")), fakeData.goodResponse1);
      expect(await sut.getArticleById(url: Urls.specificArticle("12345")), fakeData.goodResponse1);
    },
  );

  test(
    "Failure Cases 1 - Server Errors",
    () async {
      when(mockBaseHttp.get(Urls.allArticles)).thenThrow(const ServerFailure("message"));
      when(mockBaseHttp.get(Urls.author("username"))).thenThrow(const ServerFailure("message"));
      when(mockBaseHttp.get(Urls.specificArticle("12345"))).thenThrow(const ServerFailure("message"));
      expect(() => sut.getAllArticles(url: Urls.allArticles), throwsA(isA<ServerFailure>()));
      expect(() => sut.getArticlesByAuthor(url: Urls.author("username")), throwsA(isA<ServerFailure>()));
      expect(() => sut.getArticleById(url: Urls.specificArticle("12345")), throwsA(isA<ServerFailure>()));
    },
  );

  test(
    "Failure Cases 2 - Connection Errors",
    () async {
      when(mockBaseHttp.get(Urls.allArticles)).thenThrow(const ConnectionFailure("message"));
      when(mockBaseHttp.get(Urls.author("username"))).thenThrow(const ConnectionFailure("message"));
      when(mockBaseHttp.get(Urls.specificArticle("12345"))).thenThrow(const ConnectionFailure("message"));
      expect(() => sut.getAllArticles(url: Urls.allArticles), throwsA(isA<ConnectionFailure>()));
      expect(() => sut.getArticlesByAuthor(url: Urls.author("username")), throwsA(isA<ConnectionFailure>()));
      expect(() => sut.getArticleById(url: Urls.specificArticle("12345")), throwsA(isA<ConnectionFailure>()));
    },
  );
}
