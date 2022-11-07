import 'package:flutter/material.dart';
import 'package:provider101/samples/znews/domain/Models/article.dart';
import 'package:provider101/samples/znews/presentation/ui/widgets/article_card_shared.dart';

class ArticlePage extends StatelessWidget {
  final Article article;

  const ArticlePage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Article Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article.coverImage == null ? const SizedBox() : ArticleCoverImage(article.coverImage!),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                article.title,
                textAlign: TextAlign.left,
                textScaleFactor: 1.8,
              ),
            ),
            // TitleAndDesc(title: article.title, subTitle: ""),
            TagsWidget(tags: article.tags),
            const SizedBox(height: 8),
            AuthorTile(author: article.author!, date: article.readablePublishDate),
            const SizedBox(height: 8),
            Engagement(comments: article.commentsCount, readingTime: article.readingTimeMinutes),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                article.description,
                textScaleFactor: 1.4,
              ),
            ),
            InkWell(
              onTap: () {
                /// open article in browser
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Colors.black87, style: BorderStyle.solid)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Read "),
                    Icon(Icons.read_more),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
