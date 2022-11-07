// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider101/samples/znews/domain/Models/article.dart';
import 'package:provider101/samples/znews/domain/Models/author.dart';
import 'package:provider101/samples/znews/presentation/controllers/articles_homepage_controller.dart';
import 'package:provider101/samples/znews/presentation/controllers/author_page_controller.dart';
import 'package:provider101/samples/znews/presentation/ui/pages/article%20page/article_page.dart';
import 'package:provider101/samples/znews/presentation/ui/widgets/article_card_shared.dart';

class AuthorPage extends StatelessWidget {
  final String authorName;

  const AuthorPage({Key? key, required this.authorName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthorPageController>(
        builder: (context, provider, child) {
          // provider.toastError != null
          //     ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.toastError)))
          //     : null;

          switch (provider.status) {
            case Status.loading:
              return const StatusStatesScaffold(widget: CircularProgressIndicator());
            case Status.error:
              return StatusStatesScaffold(widget: Text(provider.error));
            case Status.success:
              return AuthorPageBody(articles: provider.articles, author: provider.author);
            case Status.initial:
            default:
              return StatusStatesScaffold(
                  widget: TextButton(
                child: Text("Fetch details for $authorName"),
                onPressed: () {
                  provider.populateAuthorPage(username: authorName);
                },
              ));
          }
        },
      ),
    );
  }
}

class StatusStatesScaffold extends StatelessWidget {
  final Widget widget;

  const StatusStatesScaffold({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Author Details"),
      ),
      body: Center(
        child: widget,
      ),
    );
  }
}

class AuthorPageBody extends StatelessWidget {
  final Author author;
  final List<Article> articles;

  const AuthorPageBody({Key? key, required this.articles, required this.author}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(author.name.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Image.network(
                    articles[0].author!.profileImage ?? articles[0].author!.profileImage90!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ];
          },
          body: Column(
            children: [
              AuthorDetailsWidget(
                username: author.username!,
                twitter: author.twitterUsername,
                github: author.githubUsername,
              ),
              Expanded(
                child: AuthorArticlesList(
                  authorArticles: articles,
                ),
              )
            ],
          )),
    );
  }
}

class AuthorDetailsWidget extends StatelessWidget {
  final String username;
  final String? twitter;
  final String? github;

  const AuthorDetailsWidget({Key? key, required this.username, required this.twitter, required this.github})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person),
              Text("@$username!"),
            ],
          ),
          github != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(FontAwesomeIcons.github),
                    Text(github!),
                  ],
                )
              : const SizedBox(),
          twitter != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(FontAwesomeIcons.twitter),
                    Text(twitter!),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class AuthorArticlesList extends StatelessWidget {
  final List<Article> authorArticles;

  const AuthorArticlesList({Key? key, required this.authorArticles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: authorArticles.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ArticlePage(article: authorArticles.elementAt(index))));
              },
              child: AuthorPageListArticleCard(article: authorArticles[index]));
        });
  }
}

class AuthorPageListArticleCard extends StatelessWidget {
  final Article article;

  const AuthorPageListArticleCard({Key? key, required this.article}) : super(key: key);

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
          article.coverImage == null ? const SizedBox() : ArticleCoverImage(article.coverImage!),
          TitleAndDesc(title: article.title, subTitle: ""),
          const SizedBox(height: 8),
          TagsWidget(tags: article.tags),
          const SizedBox(height: 8),
          Engagement(comments: article.commentsCount, readingTime: article.readingTimeMinutes),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
