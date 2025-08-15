import 'package:dio/dio.dart';
import '../models/news_article_model.dart';
import 'news_data_source.dart';

class NewsDataSourceImpl implements NewsDataSource{
  final Dio dio;
  
  final String apiKey = 'ed51fc6c0a9e4bc5bc6f342c16a0669f';
  final String baseURL = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=ed51fc6c0a9e4bc5bc6f342c16a0669f';

  NewsDataSourceImpl(this.dio);

  @override
  Future<List<NewsArticleModel>> getNewsArticles() async{
    
    try{
      final response = await dio.get(
        baseURL,
        queryParameters: {
          'country' : 'us',
          'apiKey' : apiKey,
        }
      );

      if (response.statusCode == 200){
        final List<dynamic> articlesJson = response.data['articles'];
        return articlesJson.map((json) => NewsArticleModel.fromJson(json)).toList();
      }
      else{
        throw Exception('failed to load new articles');
      }
    } catch(e) {
      throw Exception('failed to connect to the server');
    }

  }

  
}