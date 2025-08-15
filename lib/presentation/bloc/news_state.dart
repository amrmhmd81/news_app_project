
import 'package:equatable/equatable.dart';
import '../../domain/entities/news_article.dart';

abstract class NewsState extends Equatable{
  const NewsState();

  @override
  List<Object?> get props => [];
}

class NewsInitialState extends NewsState{}

class NewsLoadingState extends NewsState{}

class NewsLoadedState extends NewsState{
  final List<NewsArticle> articles;
  const NewsLoadedState({required this.articles});

  @override
  List<Object?> get props => [articles];
}

class NewsErrorState extends NewsState{
  final String message;
  const NewsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class NewsSearchState extends NewsState {
  final List<NewsArticle> articles;
  final String query;

  const NewsSearchState({required this.articles, required this.query});

  @override
  List<Object?> get props => [articles, query];
}
