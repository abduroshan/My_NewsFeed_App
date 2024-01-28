part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class FetchArticlesEvent extends NewsEvent{}

class SortEvent extends NewsEvent{}

class SearchAuthorEvent extends NewsEvent{
  final String author;
  SearchAuthorEvent({required this.author});
}

class SaveNewsArticle extends NewsEvent{
  final int index;
  Article article;
  SaveNewsArticle({required this.index,required this.article});
}
