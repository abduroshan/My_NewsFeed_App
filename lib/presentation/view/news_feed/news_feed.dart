import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_feed_app/data/data_sources/remote_data_source.dart';
import 'package:news_feed_app/presentation/bloc/news/news_bloc.dart';
import 'package:news_feed_app/presentation/view/content/content_view.dart';
import 'package:news_feed_app/presentation/view/news_feed/widgets/news_box.dart';
import 'package:news_feed_app/presentation/view/news_feed/widgets/popup_dialog.dart';
import 'package:news_feed_app/presentation/view/profile/profile_page.dart';
import 'package:news_feed_app/presentation/view/saved_list/saved_list_page.dart';
import 'package:news_feed_app/presentation/view/settings/settings_view.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  bool themeStatus = true;
  RemoteDataSource remoteDataSource = RemoteDataSource();

  @override
  void initState() {
    BlocProvider.of<NewsBloc>(context).add(FetchArticlesEvent());
  }

  void toggleThemeStatus() {
    if (themeStatus == true) {
      setState(() {
        themeStatus = false;
        themeStatus = themeStatus;
        print(themeStatus);
      });
    } else {
      setState(() {
        themeStatus = true;
        themeStatus = themeStatus;
        print(themeStatus);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeStatus ? Colors.black : Colors.white,

      body: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
        if (state is NewsLoadingState) {
          return SafeArea(
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.yellow,
                    ),
                  ],
                )),
          );
        } else if (state is NewsLoadedState) {
          return SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 130.0),
                  child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.articleList.length,
                      itemBuilder: (context, index) {
                        return NewsBoxWidget(
                          titleColor:
                          themeStatus ? Colors.white : Color(0xff423b3b),
                          authorColor:
                          themeStatus ? Color(0xfff5c125) : Colors.black,
                          containerColor:
                          themeStatus ? Color(0xff262525) : Colors.yellow,
                          descriptionColor:
                          themeStatus ? Colors.white : Colors.black,
                          descriptionTextColor:
                          themeStatus ? Colors.white : Colors.black,
                          author: state.articleList[index].author,
                          title: state.articleList[index].title,
                          description: state.articleList[index].description,
                          url: state.articleList[index].url,
                          urlToImage: state.articleList[index].urlToImage,
                          publishedAt: state.articleList[index].publishedAt,
                          content: state.articleList[index].content,
                          viewClick: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation,
                                    secondaryAnimation) =>
                                    ContentView(themeStatus: themeStatus,
                                        title:state.articleList[index].title,
                                        description: state.articleList[index].description,
                                        url: state.articleList[index].url,
                                        imgUrl: state.articleList[index].urlToImage,
                                        content: state.articleList[index].content,
                                        author: state.articleList[index].author),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0.0, 0.0),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }),
                ),
                Positioned(
                  top: 5,
                  left: 5,
                  right: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.article,
                            color: themeStatus ? Colors.yellow : Colors.black,
                          ),
                          Text('ARTICLES',
                            style: TextStyle(
                              color: themeStatus ? Colors.yellow : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.orange : Colors
                                  .lightGreenAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  ShowPopupDialog(context);
                                },
                                icon: Icon(
                                  Icons.search,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),

                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.orange : Colors
                                  .lightGreenAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  toggleThemeStatus();
                                },
                                icon: Icon(
                                  themeStatus ? Icons.dark_mode : Icons.sunny,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),


                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.orange : Colors
                                  .lightGreenAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<NewsBloc>(context).add(
                                      SortEvent());
                                },
                                icon: Icon(
                                  Icons.sort_by_alpha,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),


                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.orange : Colors
                                  .lightGreenAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<NewsBloc>(context).add(
                                      FetchArticlesEvent());
                                },
                                icon: Icon(
                                  Icons.refresh,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),

                          SizedBox(width: 2,),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.pink : Colors.lime,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                          ProfileView(themeStatus: themeStatus),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0.0, 0.0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.person,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),

                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.pink : Colors.lime,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                          SavedListPage(
                                              themeStatus: themeStatus),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0.0, 0.0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.list,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),

                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.pink : Colors.lime,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                          SettingsView(
                                              themeStatus: themeStatus),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0.0, 0.0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.settings,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is NewsFailedState) {
          return SafeArea(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 30,
                      ),
                      Text(
                        'Connection Interrupted',
                        style: TextStyle(
                          color: themeStatus ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 5,
                  right: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.article,
                            color: themeStatus ? Colors.yellow : Colors.black,
                          ),
                          Text('ARTICLES',
                            style: TextStyle(
                              color: themeStatus ? Colors.yellow : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.orange : Colors
                                  .lightGreenAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  ShowPopupDialog(context);
                                },
                                icon: Icon(
                                  Icons.search,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),

                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.orange : Colors
                                  .lightGreenAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  toggleThemeStatus();
                                },
                                icon: Icon(
                                  themeStatus ? Icons.dark_mode : Icons.sunny,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),


                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.orange : Colors
                                  .lightGreenAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<NewsBloc>(context).add(
                                      SortEvent());
                                },
                                icon: Icon(
                                  Icons.sort_by_alpha,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),


                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.orange : Colors
                                  .lightGreenAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<NewsBloc>(context).add(
                                      FetchArticlesEvent());
                                },
                                icon: Icon(
                                  Icons.refresh,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),

                          SizedBox(width: 2,),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.pink : Colors.lime,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                          ProfileView(themeStatus: themeStatus),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0.0, 0.0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.person,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),

                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.pink : Colors.lime,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                          SavedListPage(
                                              themeStatus: themeStatus),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0.0, 0.0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.list,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),

                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.pink : Colors.lime,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                          SettingsView(
                                              themeStatus: themeStatus),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0.0, 0.0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.settings,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is NewsSortedState) {
          return SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 130.0),
                  child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.articleList.length,
                      itemBuilder: (context, index) {
                        return NewsBoxWidget(
                          titleColor:
                          themeStatus ? Colors.white : Color(0xff423b3b),
                          authorColor:
                          themeStatus ? Color(0xfff5c125) : Colors.black,
                          containerColor:
                          themeStatus ? Color(0xff262525) : Colors.yellow,
                          descriptionColor:
                          themeStatus ? Colors.white : Colors.black,
                          descriptionTextColor:
                          themeStatus ? Colors.white : Colors.black,
                          author: state.articleList[index].author,
                          title: state.articleList[index].title,
                          description: state.articleList[index].description,
                          url: state.articleList[index].url,
                          urlToImage: state.articleList[index].urlToImage,
                          publishedAt: state.articleList[index].publishedAt,
                          content: state.articleList[index].content,
                          viewClick: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation,
                                    secondaryAnimation) =>
                                    ContentView(themeStatus: themeStatus,
                                        title:state.articleList[index].title,
                                        description: state.articleList[index].description,
                                        url: state.articleList[index].url,
                                        imgUrl: state.articleList[index].urlToImage,
                                        content: state.articleList[index].content,
                                        author: state.articleList[index].author),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0.0, 0.0),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }),
                ),
                Positioned(
                  top: 5,
                  left: 5,
                  right: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.article,
                            color: themeStatus ? Colors.yellow : Colors.black,
                          ),
                          Text('ARTICLES',
                            style: TextStyle(
                              color: themeStatus ? Colors.yellow : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.orange : Colors
                                  .lightGreenAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  ShowPopupDialog(context);
                                },
                                icon: Icon(
                                  Icons.search,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),

                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.orange : Colors
                                  .lightGreenAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  toggleThemeStatus();
                                },
                                icon: Icon(
                                  themeStatus ? Icons.dark_mode : Icons.sunny,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),


                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.orange : Colors
                                  .lightGreenAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<NewsBloc>(context).add(
                                      SortEvent());
                                },
                                icon: Icon(
                                  Icons.sort_by_alpha,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),


                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.orange : Colors
                                  .lightGreenAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<NewsBloc>(context).add(
                                      FetchArticlesEvent());
                                },
                                icon: Icon(
                                  Icons.refresh,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),

                          SizedBox(width: 2,),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.pink : Colors.lime,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                          ProfileView(themeStatus: themeStatus),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0.0, 0.0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.person,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),

                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.pink : Colors.lime,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                          SavedListPage(
                                              themeStatus: themeStatus),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0.0, 0.0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.list,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),

                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.pink : Colors.lime,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                          SettingsView(
                                              themeStatus: themeStatus),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0.0, 0.0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.settings,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is NewsSearchNotFoundState) {
          return SafeArea(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.search_off_outlined,
                        color: themeStatus ? Colors.white : Colors.black,
                      ),
                      Text(
                        'No results found',
                        style: TextStyle(
                          color: themeStatus ? Colors.white : Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 5,
                  right: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.article,
                            color: themeStatus ? Colors.yellow : Colors.black,
                          ),
                          Text('ARTICLES',
                            style: TextStyle(
                              color: themeStatus ? Colors.yellow : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.orange : Colors
                                  .lightGreenAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  ShowPopupDialog(context);
                                },
                                icon: Icon(
                                  Icons.search,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),

                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.orange : Colors
                                  .lightGreenAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  toggleThemeStatus();
                                },
                                icon: Icon(
                                  themeStatus ? Icons.dark_mode : Icons.sunny,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),


                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.orange : Colors
                                  .lightGreenAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<NewsBloc>(context).add(
                                      SortEvent());
                                },
                                icon: Icon(
                                  Icons.sort_by_alpha,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),


                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.orange : Colors
                                  .lightGreenAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<NewsBloc>(context).add(
                                      FetchArticlesEvent());
                                },
                                icon: Icon(
                                  Icons.refresh,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),

                          SizedBox(width: 2,),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.pink : Colors.lime,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                          ProfileView(themeStatus: themeStatus),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0.0, 0.0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.person,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),

                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.pink : Colors.lime,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                          SavedListPage(
                                              themeStatus: themeStatus),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0.0, 0.0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.list,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),

                          SizedBox(width: 2,),

                          Container(
                            decoration: BoxDecoration(
                              color: themeStatus ? Colors.pink : Colors.lime,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                          SettingsView(
                                              themeStatus: themeStatus),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0.0, 0.0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.settings,
                                  color: themeStatus ? Colors.white : Colors
                                      .black,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            height: 100,
            width: 100,
            color: Colors.lightGreenAccent,
          );
        }
      }),
    );
  }
}
