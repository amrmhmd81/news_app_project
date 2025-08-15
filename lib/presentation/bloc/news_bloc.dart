import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/domain/usecases/get_news_articles_usecase.dart';
import 'package:news_app/domain/entities/news_article.dart';
import 'package:news_app/presentation/bloc/news_event.dart';
import 'package:news_app/presentation/bloc/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsArticlesUsecase getNewsArticlesUsecase;
  List<NewsArticle> _allArticles = [];

  NewsBloc({required this.getNewsArticlesUsecase}) : super(NewsInitialState()) {
    on<GetNewsArticlesEvent>((event, emit) async {
      //loading
      emit(NewsLoadingState());
      try {
        final articles = await getNewsArticlesUsecase.call();
        _allArticles = articles; //we will use it in search
        //success
        emit(NewsLoadedState(articles: articles));
      } catch (e) {
        //error
        emit(NewsErrorState(message: e.toString()));
      }
    });

    on<SearchNewsArticlesEvent>((event, emit) {
      if (event.query.isEmpty) {
        emit(NewsLoadedState(articles: _allArticles));
      } else {
        final filteredArticles = _allArticles.where((article) {
          return article.title.toLowerCase().contains(event.query.toLowerCase()) ||
                 article.description.toLowerCase().contains(event.query.toLowerCase());
        }).toList();
        
        emit(NewsSearchState(articles: filteredArticles, query: event.query));
      }
    });
  }
}
