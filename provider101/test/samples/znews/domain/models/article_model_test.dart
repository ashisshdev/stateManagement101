import 'package:flutter_test/flutter_test.dart';
import 'package:provider101/samples/znews/domain/Models/article.dart';
import 'package:provider101/samples/znews/domain/Models/author.dart';

void main() {
  const json1 = {
    "type_of": "article",
    "id": 1225642,
    "title": "Do commit dates on GitHub matter for job applications?",
    "description": "This is an anonymous post sent in by a member who does not want their name disclosed. Please be...",
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
  };

  Article article1 = const Article(
      id: 1225642,
      title: "Do commit dates on GitHub matter for job applications?",
      description: "This is an anonymous post sent in by a member who does not want their name disclosed. Please be...",
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
              "https://res.cloudinary.com/practicaldev/image/fetch/s--aYmQY6c1--/c_fill,f_auto,fl_progressive,h_640,q_auto,w_640/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/31047/af153cd6-9994-4a68-83f4-8ddf3e13f0bf.jpg"));

  Article article2 = const Article(
      id: 1225642,
      title: "Do commit dates on GitHub matter for job applications?",
      description: "This is an anonymous post sent in by a member who does not want their name disclosed. Please be...",
      readablePublishDate: "Oct 20",
      url: "https://dev.to/sloan/do-commit-dates-on-github-matter-for-job-applications-13a5",
      commentsCount: 8,
      publishedTimestamp: "2022-10-20T20:50:44Z",
      positiveReactionsCount: 12,
      readingTimeMinutes: 1,
      tags: ["anonymous", "hehe", "github"],
      author: Author(
          name: "Sloan",
          username: "sloan",
          twitterUsername: "theslothdev",
          githubUsername: "theslothdev",
          profileImage90:
              "https://res.cloudinary.com/practicaldev/image/fetch/s--KhA8jn82--/c_fill,f_auto,fl_progressive,h_90,q_auto,w_90/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/31047/af153cd6-9994-4a68-83f4-8ddf3e13f0bf.jpg",
          profileImage:
              "https://res.cloudinary.com/practicaldev/image/fetch/s--aYmQY6c1--/c_fill,f_auto,fl_progressive,h_640,"
              "q_auto,w_640/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/31047/af153cd6-9994-4a68-83f4-8ddf3e13f0bf.jpg"));

  test("Article from Json", () {
    var result = Article.fromJson(json1);
    expect(result, article1);
    expect(result, isNot(article2));
  });
}
