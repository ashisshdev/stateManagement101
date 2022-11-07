import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:provider101/samples/znews/domain/Models/article.dart';
import 'package:provider101/samples/znews/domain/Models/author.dart';
import 'package:provider101/samples/znews/domain/Models/cache_data.dart';
import 'package:provider101/samples/znews/domain/Repositories/articles_repo.dart';
import 'package:provider101/samples/znews/utils/failures.dart';
import 'package:provider101/samples/znews/utils/urls.dart';

import '../../../mocks.mocks.dart';

void main() {
  DateTime dateTime = DateTime.now();

  // To test local DB functions
  String key = "key";
  const data = {"data": "Some data"};
  CacheData cacheData = CacheData(articles: data, age: dateTime);
  var cacheDataJson = {"articles": data, "age": dateTime.toString()};

  // To test remote DB functions
  List<Map<String, dynamic>> json1AllArticles = [
    {
      "type_of": "article",
      "id": 1225642,
      "title": "Do commit dates on GitHub matter for job applications?",
      "description":
          "This is an anonymous post sent in by a member who does not want their name disclosed. Please be...",
      "readable_publish_date": "Oct 20",
      "slug": "do-commit-dates-on-github-matter-for-job-applications-13a5",
      "path": "/sloan/do-commit-dates-on-github-matter-for-job-applications-13a5",
      "url": "https://dev.to/sloan/do-commit-dates-on-github-matter-for-job-applications-13a5",
      "comments_count": 8,
      "public_reactions_count": 12,
      "collection_id": null,
      "published_timestamp": "2022-10-20T20:50:44Z",
      "positive_reactions_count": 12,
      "cover_image": null,
      "social_image": "https://dev.to/social_previews/article/1225642.png",
      "canonical_url": "https://dev.to/sloan/do-commit-dates-on-github-matter-for-job-applications-13a5",
      "created_at": "2022-10-20T20:50:23Z",
      "edited_at": null,
      "crossposted_at": null,
      "published_at": "2022-10-20T20:50:44Z",
      "last_comment_at": "2022-10-21T19:28:22Z",
      "reading_time_minutes": 1,
      "tag_list": ["anonymous", "discuss", "github"],
      "tags": "anonymous, discuss, github",
      "user": {
        "name": "Sloan",
        "username": "sloan",
        "twitter_username": "theslothdev",
        "github_username": "theslothdev",
        "user_id": 31047,
        "website_url": "https://dev.to/t/anonymous",
        "profile_image":
            "https://res.cloudinary.com/practicaldev/image/fetch/s--aYmQY6c1--/c_fill,f_auto,fl_progressive,h_640,q_auto,w_640/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/31047/af153cd6-9994-4a68-83f4-8ddf3e13f0bf.jpg",
        "profile_image_90":
            "https://res.cloudinary.com/practicaldev/image/fetch/s--KhA8jn82--/c_fill,f_auto,fl_progressive,h_90,q_auto,w_90/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/31047/af153cd6-9994-4a68-83f4-8ddf3e13f0bf.jpg"
      },
      "flare_tag": {"name": "anonymous", "bg_color_hex": "#00A9AF", "text_color_hex": "#FFFFFF"}
    },
    {
      "type_of": "article",
      "id": 9991917,
      "title": "Do commit dates on GitHub matter for job applications?",
      "description":
          "This is an anonymous post sent in by a member who does not want their name disclosed. Please be...",
      "readable_publish_date": "Oct 20",
      "slug": "do-commit-dates-on-github-matter-for-job-applications-13a5",
      "path": "/sloan/do-commit-dates-on-github-matter-for-job-applications-13a5",
      "url": "https://dev.to/sloan/do-commit-dates-on-github-matter-for-job-applications-13a5",
      "comments_count": 8,
      "public_reactions_count": 12,
      "collection_id": null,
      "published_timestamp": "2022-10-20T20:50:44Z",
      "positive_reactions_count": 12,
      "cover_image": null,
      "social_image": "https://dev.to/social_previews/article/1225642.png",
      "canonical_url": "https://dev.to/sloan/do-commit-dates-on-github-matter-for-job-applications-13a5",
      "created_at": "2022-10-20T20:50:23Z",
      "edited_at": null,
      "crossposted_at": null,
      "published_at": "2022-10-20T20:50:44Z",
      "last_comment_at": "2022-10-21T19:28:22Z",
      "reading_time_minutes": 1,
      "tag_list": ["anonymous", "discuss", "github"],
      "tags": "anonymous, discuss, github",
      "user": {
        "name": "Sloan",
        "username": "sloan",
        "twitter_username": "theslothdev",
        "github_username": "theslothdev",
        "user_id": 31047,
        "website_url": "https://dev.to/t/anonymous",
        "profile_image":
            "https://res.cloudinary.com/practicaldev/image/fetch/s--aYmQY6c1--/c_fill,f_auto,fl_progressive,h_640,q_auto,w_640/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/31047/af153cd6-9994-4a68-83f4-8ddf3e13f0bf.jpg",
        "profile_image_90":
            "https://res.cloudinary.com/practicaldev/image/fetch/s--KhA8jn82--/c_fill,f_auto,fl_progressive,h_90,q_auto,w_90/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/31047/af153cd6-9994-4a68-83f4-8ddf3e13f0bf.jpg"
      },
      "flare_tag": {"name": "anonymous", "bg_color_hex": "#00A9AF", "text_color_hex": "#FFFFFF"}
    }
  ];

  final List<Article> articlesList = [
    const Article(
        id: 1225642,
        title: "Do commit dates on GitHub matter for job applications?",
        description:
            "This is an anonymous post sent in by a member who does not want their name disclosed. Please be...",
        readablePublishDate: "Oct 20",
        url: "https://dev.to/sloan/do-commit-dates-on-github-matter-for-job-applications-13a5",
        commentsCount: 8,
        publishedTimestamp: "2022-10-20T20:50:44Z",
        positiveReactionsCount: 12,
        readingTimeMinutes: 1,
        tags: ["anonymous", "discuss", "github"],
        author: Author(
            name: "Sloan",
            username: "sloan",
            twitterUsername: "theslothdev",
            githubUsername: "theslothdev",
            profileImage90:
                "https://res.cloudinary.com/practicaldev/image/fetch/s--KhA8jn82--/c_fill,f_auto,fl_progressive,h_90,q_auto,w_90/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/31047/af153cd6-9994-4a68-83f4-8ddf3e13f0bf.jpg",
            profileImage:
                "https://res.cloudinary.com/practicaldev/image/fetch/s--aYmQY6c1--/c_fill,f_auto,fl_progressive,h_640,"
                "q_auto,w_640/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/31047/af153cd6-9994-4a68-83f4-8ddf3e13f0bf.jpg")),
    const Article(
        id: 9991917,
        title: "Do commit dates on GitHub matter for job applications?",
        description:
            "This is an anonymous post sent in by a member who does not want their name disclosed. Please be...",
        readablePublishDate: "Oct 20",
        url: "https://dev.to/sloan/do-commit-dates-on-github-matter-for-job-applications-13a5",
        commentsCount: 8,
        publishedTimestamp: "2022-10-20T20:50:44Z",
        positiveReactionsCount: 12,
        readingTimeMinutes: 1,
        tags: ["anonymous", "discuss", "github"],
        author: Author(
            name: "Sloan",
            username: "sloan",
            twitterUsername: "theslothdev",
            githubUsername: "theslothdev",
            profileImage90:
                "https://res.cloudinary.com/practicaldev/image/fetch/s--KhA8jn82--/c_fill,f_auto,fl_progressive,h_90,q_auto,w_90/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/31047/af153cd6-9994-4a68-83f4-8ddf3e13f0bf.jpg",
            profileImage:
                "https://res.cloudinary.com/practicaldev/image/fetch/s--aYmQY6c1--/c_fill,f_auto,fl_progressive,h_640,q_auto,w_640/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/31047/af153cd6-9994-4a68-83f4-8ddf3e13f0bf.jpg"))
  ];

  CacheData cacheData2 = CacheData(articles: json1AllArticles, age: dateTime);

  var goodResponse = Response(jsonEncode(json1AllArticles), 200);
  var badResponse = Response(jsonEncode({"error": "Lmao Not Found"}), 404);

  late ArticlesRepo sut;
  late MockArticlesLocalDB mockArticlesLocalDB;
  late MockArticlesRemote mockArticlesRemote;

  setUp(() {
    mockArticlesRemote = MockArticlesRemote();
    mockArticlesLocalDB = MockArticlesLocalDB();
    sut = ArticlesRepoImpl(articlesRemote: mockArticlesRemote, articlesLocalDB: mockArticlesLocalDB);
  });

  group("local db methods success", () {
    test(
      "localDB saveArticle",
      () async {
        when(mockArticlesLocalDB.saveArticle(key: key, data: cacheDataJson))
            .thenAnswer((_) async => await Future.value(true));
        expect(await sut.localSaveArticles(key: key, cacheData: cacheData), true);
      },
    );

    test(
      "localDB has article?",
      () async {
        when(mockArticlesLocalDB.hasArticle(key: key)).thenAnswer((_) async => await Future.value(true));
        expect(await sut.localHasArticle(key: key), true);
      },
    );

    test(
      "localDB retrieve article",
      () async {
        when(mockArticlesLocalDB.retrieveAllArticles(key: key))
            .thenAnswer((_) async => await Future.value(cacheDataJson));
        var result = await sut.localRetrieveArticles(key: key);
        result.fold((l) {
          return;
        }, (r) {
          expect(r, equals(cacheData));
        });
      },
    );

    test(
      "localDB clear cache",
      () async {
        when(mockArticlesLocalDB.clearAllArticles()).thenAnswer((_) async => await Future.value(true));
        expect(await sut.localClearCache(), true);
      },
    );
  });

  group("local db methods failures", () {
    test(
      "localDB saveArticle",
      () async {
        when(mockArticlesLocalDB.saveArticle(key: key, data: cacheDataJson))
            .thenAnswer((_) async => await Future.value(false));
        expect(await sut.localSaveArticles(key: key, cacheData: cacheData), false);
      },
    );

    test(
      "localDB has article?",
      () async {
        when(mockArticlesLocalDB.hasArticle(key: key)).thenAnswer((_) async => await Future.value(false));
        expect(await sut.localHasArticle(key: key), false);
      },
    );

    test(
      "localDB retrieve article",
      () async {
        when(mockArticlesLocalDB.retrieveAllArticles(key: key)).thenThrow(const DatabaseFailure("message"));
        var result = await sut.localRetrieveArticles(key: key);
        result.fold((l) {
          print(l);
          expect(l, equals(const DatabaseFailure("No Cached Data Available.")));
          expect(l, isInstanceOf<DatabaseFailure>());
        }, (r) {
          return;
        });
      },
    );

    test(
      "localDB clear cache",
      () async {
        when(mockArticlesLocalDB.clearAllArticles()).thenThrow(const DatabaseFailure("message"));
        expect(await sut.localClearCache(), false);
      },
    );
  });

  group("remote DB methods success", () {
    test(
      "fetch All Articles Method",
      () async {
        when(mockArticlesRemote.getAllArticles(url: Urls.allArticles))
            .thenAnswer((_) async => await Future.value(goodResponse));

        var result = await sut.remoteFetchArticlesAll();

        result.fold((failure) {
          return;
        }, (success) {
          expect(success, isInstanceOf<CacheData>());
        });
      },
    );

    test(
      "fetch All Articles of a User Method",
      () async {
        when(mockArticlesRemote.getArticlesByAuthor(url: Urls.author("username")))
            .thenAnswer((_) async => await Future.value(goodResponse));

        var result = await sut.remoteFetchArticlesAuthor(username: "username");

        result.fold((failure) {
          return;
        }, (success) {
          expect(success, isInstanceOf<CacheData>());
        });
      },
    );

    test(
      "fetch a specific Article Method",
      () async {
        when(mockArticlesRemote.getArticleById(url: Urls.specificArticle("id")))
            .thenAnswer((_) async => await Future.value(goodResponse));

        var result = await sut.remoteFetchArticleById(id: "id");

        result.fold((failure) {
          return;
        }, (success) {
          expect(success, isInstanceOf<CacheData>());
        });
      },
    );
  });

  group("remote DB methods failures", () {
    test(
      "fetch All Articles Method",
      () async {
        when(mockArticlesRemote.getAllArticles(url: Urls.allArticles))
            .thenAnswer((_) async => await Future.value(badResponse));

        var result = await sut.remoteFetchArticlesAll();

        result.fold((failure) {
          expect(failure, isInstanceOf<ServerFailure>());
        }, (success) {
          return;
        });
      },
    );

    test(
      "fetch All Articles of a User Method",
      () async {
        when(mockArticlesRemote.getArticlesByAuthor(url: Urls.author("username")))
            .thenThrow(const ServerFailure("message"));

        var result = await sut.remoteFetchArticlesAuthor(username: "username");

        result.fold((failure) {
          expect(failure, isInstanceOf<ServerFailure>());
        }, (success) {
          return;
        });
      },
    );

    test(
      "fetch a specific Article Method",
      () async {
        when(mockArticlesRemote.getArticleById(url: Urls.specificArticle("id")))
            .thenAnswer((_) async => await Future.value(badResponse));

        var result = await sut.remoteFetchArticleById(id: "id");

        result.fold((failure) {
          expect(failure, isInstanceOf<ServerFailure>());
        }, (success) {
          return;
        });
      },
    );
  });
}
