import 'package:flutter_test/flutter_test.dart';
import 'package:provider101/samples/znews/domain/Models/author.dart';

void main() {
  const authorJson = {
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
  };

  Author author1 = const Author(
      name: "Sloan",
      username: "sloan",
      twitterUsername: "theslothdev",
      githubUsername: "theslothdev",
      profileImage90:
          "https://res.cloudinary.com/practicaldev/image/fetch/s--KhA8jn82--/c_fill,f_auto,fl_progressive,h_90,q_auto,w_90/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/31047/af153cd6-9994-4a68-83f4-8ddf3e13f0bf.jpg",
      profileImage:
          "https://res.cloudinary.com/practicaldev/image/fetch/s--aYmQY6c1--/c_fill,f_auto,fl_progressive,h_640,q_auto,"
          "w_640/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/31047/af153cd6-9994-4a68-83f4-8ddf3e13f0bf.jpg");

  Author author2 = const Author(
      name: "Sloan",
      username: "sloan",
      githubUsername: "theslothdev",
      profileImage90:
          "https://res.cloudinary.com/practicaldev/image/fetch/s--KhA8jn82--/c_fill,f_auto,fl_progressive,h_90,q_auto,w_90/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/31047/af153cd6-9994-4a68-83f4-8ddf3e13f0bf.jpg",
      profileImage:
          "https://res.cloudinary.com/practicaldev/image/fetch/s--aYmQY6c1--/c_fill,f_auto,fl_progressive,h_640,q_auto,"
          "w_640/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/31047/af153cd6-9994-4a68-83f4-8ddf3e13f0bf.jpg");

  test(
    "author from json method",
    () async {
      expect(Author.fromJson(authorJson), author1);
      expect(Author.fromJson(authorJson), isNot(author2));
    },
  );
}
