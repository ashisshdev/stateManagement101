import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:provider101/samples/znews/data/http/http_helper/base_server.dart';
import 'package:provider101/samples/znews/utils/failures.dart';
import 'package:provider101/samples/znews/utils/urls.dart';

import '../../../../mocks.mocks.dart';

class BaseHttpTestMockData {
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

  static List<Map<String, dynamic>> json2ArticlesByAuthor = [
    {
      "type_of": "article",
      "id": 1234082,
      "title": "What's important when reviewing a team member's code?",
      "description":
          "This is an anonymous post sent in by a member who does not want their name disclosed. Please be...",
      "readable_publish_date": "Oct 28",
      "slug": "whats-important-when-reviewing-a-team-members-code-3n5e",
      "path": "/sloan/whats-important-when-reviewing-a-team-members-code-3n5e",
      "url": "https://dev.to/sloan/whats-important-when-reviewing-a-team-members-code-3n5e",
      "comments_count": 9,
      "public_reactions_count": 17,
      "collection_id": null,
      "published_timestamp": "2022-10-28T16:43:51Z",
      "positive_reactions_count": 17,
      "cover_image": null,
      "social_image": "https://dev.to/social_previews/article/1234082.png",
      "canonical_url": "https://dev.to/sloan/whats-important-when-reviewing-a-team-members-code-3n5e",
      "created_at": "2022-10-28T16:43:39Z",
      "edited_at": null,
      "crossposted_at": null,
      "published_at": "2022-10-28T16:43:51Z",
      "last_comment_at": "2022-11-01T22:31:49Z",
      "reading_time_minutes": 1,
      "tag_list": ["anonymous", "discuss"],
      "tags": "anonymous, discuss",
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
      "id": 1229345,
      "title": "Engineering Managers - What Do You Like About Your Job?",
      "description":
          "This is an anonymous question sent in by a member who does not want their name disclosed. Please be...",
      "readable_publish_date": "Oct 25",
      "slug": "engineering-managers-what-do-you-like-about-your-job-pc6",
      "path": "/sloan/engineering-managers-what-do-you-like-about-your-job-pc6",
      "url": "https://dev.to/sloan/engineering-managers-what-do-you-like-about-your-job-pc6",
      "comments_count": 2,
      "public_reactions_count": 7,
      "collection_id": null,
      "published_timestamp": "2022-10-25T13:15:13Z",
      "positive_reactions_count": 7,
      "cover_image": null,
      "social_image": "https://dev.to/social_previews/article/1229345.png",
      "canonical_url": "https://dev.to/sloan/engineering-managers-what-do-you-like-about-your-job-pc6",
      "created_at": "2022-10-25T13:15:00Z",
      "edited_at": null,
      "crossposted_at": null,
      "published_at": "2022-10-25T13:15:13Z",
      "last_comment_at": "2022-10-25T19:00:49Z",
      "reading_time_minutes": 1,
      "tag_list": ["discuss", "anonymous", "career"],
      "tags": "discuss, anonymous, career",
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
      "flare_tag": {"name": "discuss", "bg_color_hex": "#1ad643", "text_color_hex": "#FFFFFF"}
    },
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
    }
  ];

  Response goodResponse2 = Response(jsonEncode(json2ArticlesByAuthor), 200);

  Response badResponse1 = Response(jsonEncode({"error": "someError101"}), 400);

  Response badResponse2 = Response(jsonEncode({"error": "Resource Not Found."}), 400);
}

void main() {
  late MockHttpClient mockHttpClient;
  late BaseHttp sut;

  final BaseHttpTestMockData mockData = BaseHttpTestMockData();

  setUp(() {
    mockHttpClient = MockHttpClient();
    sut = BaseHttp(client: mockHttpClient);
  });

  group("Testing success scenarios", () {
    test(
      "Success data 1 - Json List of all Articles",
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.allArticles)))
            .thenAnswer((realInvocation) => Future.value(mockData.goodResponse1));

        // act
        var result = await sut.get(Urls.allArticles);

        // assert
        expect(result, equals(mockData.goodResponse1));
      },
    );

    test(
      "Success data 1 - Json List of all Articles by a specific Author",
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.author("username"))))
            .thenAnswer((realInvocation) => Future.value(mockData.goodResponse2));

        // act
        var result = await sut.get(Urls.author("username"));

        // assert
        expect(result, equals(mockData.goodResponse2));
      },
    );

    print("News Articles Base Http Test");
    print("Testing Success Scenarios Group");
    print("unable to test specific id articles : due to lack of proper mockData");
  });

  group("Testing error scenarios", () {
    test(
      "Failure Type 1 , Server Failure => 1 - statusCode == 400",
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.allArticles)))
            .thenAnswer((realInvocation) async => Future.value(mockData.badResponse1));

        // assert
        expect(() => sut.get(Urls.allArticles), throwsA(isA<ServerFailure>()));
      },
    );

    test(
      "Failure Type 1 , Server Failure => 2 - FormatException",
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.author("username")))).thenThrow(const FormatException());

        // act
        // assert
        expect(sut.get(Urls.author("username")), throwsA(isA<ServerFailure>()));
      },
    );

    test(
      "Failure Type 2 , Platform Failure => 1 - Socket Exception",
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.allArticles))).thenThrow(const SocketException("message"));

        // act
        // assert
        expect(sut.get(Urls.allArticles), throwsA(isA<ConnectionFailure>()));
      },
    );

    test(
      "Failure Type 2 , Platform Failure => 2 - Timeout Exception",
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.specificArticle("12345")))).thenThrow(TimeoutException("message"));

        // act
        // assert
        expect(sut.get(Urls.specificArticle("12345")), throwsA(isA<ConnectionFailure>()));
      },
    );
  });
}
