import 'package:flutter/material.dart';
import '../../../domain/entities/news_article.dart';
import 'news_card_widget.dart';
import 'empty_state_widget.dart';

class NewsListWidget extends StatelessWidget {
  final List<NewsArticle> articles;

  const NewsListWidget({
    super.key,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      return const EmptyStateWidget(
        title: 'لا توجد أخبار',
        message: 'لا توجد أخبار متاحة حالياً',
        icon: Icons.article_outlined,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: NewsCardWidget(article: article),
        );
      },
    );
  }
}
