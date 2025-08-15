import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable{

  const NewsEvent();

  @override
  List<Object?> get props => [];

}

class GetNewsArticlesEvent extends NewsEvent{
  const GetNewsArticlesEvent();
}

class SearchNewsArticlesEvent extends NewsEvent {
  final String query;

  const SearchNewsArticlesEvent({required this.query});

  @override
  List<Object?> get props => [query];
}