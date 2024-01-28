import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentView extends StatefulWidget {
  final bool themeStatus;
  final String title;
  final String description;
  final String url;
  final String imgUrl;
  final String content;
  final String author;

  const ContentView(
      {Key? key,
      required this.themeStatus,
      required this.title,
      required this.description,
      required this.url,
      required this.imgUrl,
      required this.content,
      required this.author})
      : super(key: key);

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.themeStatus ? Colors.black : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.view_column_outlined,
                      color:widget.themeStatus?Colors.yellow:Colors.black,
                    ),
                    Text('View Content',
                    style: TextStyle(
                      color: widget.themeStatus?Colors.yellow:Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: widget.themeStatus ? Colors.yellow : Colors.black,
                      ),
                    )
                  ],
                ),

                Text(widget.author,
                  style: TextStyle(
                    color: widget.themeStatus?Colors.yellow:Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10,),

                Text(widget.title,
                  style: TextStyle(
                    color: widget.themeStatus?Colors.white:Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 10,),

                Image(image: NetworkImage(widget.imgUrl)),

                SizedBox(height: 10,),

                Text(widget.description,
                  style: TextStyle(
                    color: widget.themeStatus?Colors.white:Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),

                SizedBox(height: 10,),

                Text(widget.content,
                  style: TextStyle(
                    color: widget.themeStatus?Colors.white:Colors.black,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.start,
                ),

                SizedBox(height: 15,),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color:  Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(onPressed: (){
                          redirectToGoogle(widget.url);
                        }, child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Visit Content',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


void redirectToGoogle(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}