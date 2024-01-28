import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsBoxWidget extends StatefulWidget {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  final VoidCallback viewClick;
  final Color authorColor;
  final Color titleColor;
  final Color descriptionTextColor;
  final Color descriptionColor;
  final Color containerColor;

  const NewsBoxWidget(
      {Key? key,
      required this.containerColor,
      required this.authorColor,
      required this.descriptionColor,
      required this.descriptionTextColor,
      required this.titleColor,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content,
      required this.viewClick})
      : super(key: key);

  @override
  State<NewsBoxWidget> createState() => _NewsBoxWidgetState();
}

class _NewsBoxWidgetState extends State<NewsBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: widget.containerColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10,),
              Icon(Icons.article,color: widget.titleColor,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      widget.author,
                      style: TextStyle(
                        fontSize: 30,
                          color: widget.authorColor, fontWeight: FontWeight.bold),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),

              Container(
                width: 350,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 18,
                      color: widget.titleColor, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),

              SizedBox(height: 20,),

              Container(
                color: Colors.white,
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(
                    image: NetworkImage(widget.urlToImage),
                  ),
                ),
              ),

              SizedBox(height: 20,),

              // Container(
              //   width: 350,
              //   child: Text(
              //     widget.description,
              //     style: TextStyle(
              //         color: widget.descriptionTextColor,
              //         ),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              //
              //
              // SizedBox(height: 20,),


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
                        widget.viewClick();
                        //redirectToGoogle(widget.url);
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

              // SizedBox(height: 20,),
              //
              // Text(
              //   widget.publishedAt,
              //   style: TextStyle(
              //       color: Colors.blueGrey, fontWeight: FontWeight.bold),
              //   textAlign: TextAlign.center,
              // ),

              SizedBox(height: 10,),


            ],
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