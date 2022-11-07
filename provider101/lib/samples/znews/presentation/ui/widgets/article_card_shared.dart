import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider101/samples/znews/presentation/controllers/author_page_controller.dart';
import 'package:provider101/samples/znews/presentation/ui/pages/author%20page/author_page.dart';

import '../../../domain/Models/author.dart';
import 'cache_image.dart';

class ArticleCoverImage extends StatelessWidget {
  final String url;

  const ArticleCoverImage(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: AppCachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        height: 220,
        width: double.infinity,
      ),
    );
  }
}

class AuthorTile extends StatelessWidget {
  final Author author;
  final String date;

  const AuthorTile({Key? key, required this.author, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          Provider.of<AuthorPageController>(context, listen: false).populateAuthorPage(username: author.username!);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthorPage(authorName: author.username!)));
        },
        leading:
            CircleAvatar(foregroundImage: NetworkImage(author.profileImage.toString()), backgroundColor: Colors.red),
        title: Text(author.name),
        subtitle: Text(date));
  }
}

class TagsWidget extends StatelessWidget {
  final List<String> tags;

  const TagsWidget({Key? key, required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.all(10), child: Row(children: [for (var tag in tags) Text("  #$tag")]));
  }
}

class TitleAndDesc extends StatelessWidget {
  final String title;
  final String subTitle;

  const TitleAndDesc({Key? key, required this.title, required this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title, textScaleFactor: 1.5),
        subtitle: Text(subTitle, textScaleFactor: 1.2, maxLines: 3, overflow: TextOverflow.ellipsis));
  }
}

class Engagement extends StatelessWidget {
  final int comments;
  final int readingTime;

  const Engagement({Key? key, required this.comments, required this.readingTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CustomIconWidget(title: "Reading Time", count: readingTime, iconData: Icons.timer),
        CustomIconWidget(title: "Comments", count: comments, iconData: Icons.comment)
      ]),
    );
  }
}

class CustomIconWidget extends StatelessWidget {
  final String title;
  final int count;
  final IconData iconData;

  const CustomIconWidget({Key? key, required this.title, required this.count, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [Icon(iconData), const SizedBox(width: 2), Text("$count $title")]);
  }
}
