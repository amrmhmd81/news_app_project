import '../models/news_article_model.dart';

abstract class NewsDataSource {
  
  Future<List<NewsArticleModel>> getNewsArticles();

}