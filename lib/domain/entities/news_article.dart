import 'package:equatable/equatable.dart';

class NewsArticle extends Equatable{

  final SourceEntity? source;
  final String? author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;

  const NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    required this.publishedAt,
    this.source,
    this.author,
    this.urlToImage,
    this.content,
  });

  @override
  List<Object?> get props => [source, author, title, description, url, urlToImage, publishedAt, content];
}

class SourceEntity extends Equatable{

  final String name;
  final String? id;

  const SourceEntity({required this.name, this.id});

  @override
  List<Object?> get props => [name, id];
  
}