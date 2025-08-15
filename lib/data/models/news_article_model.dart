import 'package:news_app/domain/entities/news_article.dart';

class NewsArticleModel extends NewsArticle {
  const NewsArticleModel({
    required super.title,
    required super.description,
    required super.url,
    required super.publishedAt,
    super.author,
    super.source,
    super.urlToImage,
    super.content,
  });

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      author: json['author'] as String?,
      source: json['source'] != null
          ? SourceEntity(
              name: json['source']['name'] ?? '',
              id: json['source']['id'] as String?,
            )
          : null,
      urlToImage: json['urlToImage'] as String?,
      content: json['content'] as String?,
    );
  }
}
