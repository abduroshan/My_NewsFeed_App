part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState{}

class NewsLoadedState extends NewsState{
  List<Article> articleList;
  NewsLoadedState({required this.articleList});
}

class NewsSortedState extends NewsState{
  List<Article> articleList;
  NewsSortedState({required this.articleList});
}

class NewsFailedState extends NewsState{}

class NewsSearchNotFoundState extends NewsState{}

