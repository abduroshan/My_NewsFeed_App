import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_feed_app/data/data_sources/remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/article_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    RemoteDataSource remoteDataSource = RemoteDataSource();

    on<FetchArticlesEvent>((event, emit) async{
      emit(NewsLoadingState());
      try{
        List<Article> articles = await remoteDataSource.getArticleModelList();
        emit(NewsLoadedState(articleList: articles));
      }
      catch(e){
        emit(NewsFailedState());
      }
    });

    on<SortEvent>((event, emit) async{
      emit(NewsLoadingState());
      try{
        List<Article> articles = await remoteDataSource.getArticleModelList();
        articles.sort((a, b) => a.author.toLowerCase().compareTo(b.author.toLowerCase()));
        emit(NewsLoadedState(articleList: articles));
      }
      catch(e){
        emit(NewsFailedState());
      }
    });

    on<SearchAuthorEvent>((event, emit) async{
      emit(NewsLoadingState());
      try{
        List<Article> articles = await remoteDataSource.getArticleModelList();

        String searchTerm = event.author.toLowerCase();
        articles = articles.where((article) => article.author.toLowerCase().contains(searchTerm)).toList();
        if (articles.length>0) {
          emit(NewsLoadedState(articleList: articles));
        }
        else{
          emit(NewsSearchNotFoundState());
        }
      }
      catch(e){
        emit(NewsFailedState());
      }
    });


    on<SaveNewsArticle>((event, emit) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();

    });



  }
}
