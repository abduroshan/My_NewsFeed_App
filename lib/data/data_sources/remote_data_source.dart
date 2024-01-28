import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_feed_app/data/models/article_model.dart';


class RemoteDataSource {

  Future<Response>getApiResponseData()async{
    Response r;
    Dio dio = Dio();
    r= await dio.get('https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=e9b2c288d60e4c06998a3b3cefc1f624');
    //print(r.data['articles']);
    return r;
  }

  Future<List<Article>> getArticleModelList() async {
    Response r = await getApiResponseData();
    List<dynamic> responseData = r.data['articles'];
    return responseData.map((e) => Article.fromJson(e)).toList();
  }

}