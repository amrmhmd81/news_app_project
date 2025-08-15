import '../../domain/entities/news_article.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_data_source.dart';

class NewsRepositoryImpl implements NewsRepository{
  final NewsDataSource newsDataSource;

  NewsRepositoryImpl(this.newsDataSource);
  
  @override
  Future<List<NewsArticle>> getNewsArticles() async {
    final articlesModels = await newsDataSource.getNewsArticles();
    return articlesModels;
  }

  
}