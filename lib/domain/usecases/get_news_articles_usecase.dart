import '../entities/news_article.dart';
import '../repositories/news_repository.dart';

class GetNewsArticlesUsecase {
  final NewsRepository repository;

  GetNewsArticlesUsecase(this.repository);

  Future<List<NewsArticle>> call() async{
    return repository.getNewsArticles();
  }
}