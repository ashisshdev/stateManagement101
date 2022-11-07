import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider101/dependency_injection.dart';
import 'package:provider101/samples/znews/domain/Models/article.dart';
import 'package:provider101/samples/znews/presentation/controllers/article_page_controller.dart';
import 'package:provider101/samples/znews/presentation/ui/pages/article%20page/article_page.dart';
import 'package:provider101/samples/znews/presentation/ui/widgets/article_card_shared.dart';

import '../../../controllers/articles_homepage_controller.dart';

class ArticlesHomePage extends StatelessWidget {
  const ArticlesHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Znews"),
      ),
      body: Consumer<ArticlesHomePageController>(
        builder: (context, articlesProvider, child) {
          switch (articlesProvider.status) {
            case Status.loading:
              return const Center(
                  child: CircularProgressIndicator(
                key: Key("circular progress indicator"),
              ));
            case Status.error:
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(articlesProvider.error),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        locator<ArticlesHomePageController>().fetchAllArticles();
                      },
                      child: const Text("Retry.")),
                ],
              ));
            case Status.success:
              return SuccessArticlesWidget(
                articles: articlesProvider.articles,
              );
            case Status.initial:
            default:
              return Center(
                child: TextButton(
                    onPressed: () {
                      locator<ArticlesHomePageController>().fetchAllArticles();
                    },
                    child: const Text("Fetch Articles")),
              );
          }
        },
      ),
    );
  }
}

class SuccessArticlesWidget extends StatelessWidget {
  final List<Article> articles;

  const SuccessArticlesWidget({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return HomepageListArticleCard(article: articles[index]);
        });
  }
}

class HomepageListArticleCard extends StatelessWidget {
  final Article article;

  const HomepageListArticleCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Colors.black54),
      ),
      child: Column(
        children: [
          AuthorTile(author: article.author!, date: article.readablePublishDate),
          InkWell(
            onTap: () {
              Provider.of<ArticlePageController>(context, listen: false).fetchTheArticle(id: article.id.toString());
              // locator<ArticlePageController>().fetchTheArticle(id: article.id.toString());
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ArticlePage(article: article)));
            },
            child: Column(
              children: [
                article.coverImage == null ? const SizedBox() : ArticleCoverImage(article.coverImage!),
                TitleAndDesc(title: article.title, subTitle: ""),
              ],
            ),
          )
        ],
      ),
    );
  }
}
