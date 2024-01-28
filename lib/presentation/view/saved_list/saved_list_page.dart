import 'package:flutter/material.dart';

class SavedListPage extends StatefulWidget {
  final bool themeStatus;
  const SavedListPage({Key? key, required this.themeStatus}) : super(key: key);

  @override
  State<SavedListPage> createState() => _SavedListPageState();
}

class _SavedListPageState extends State<SavedListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.themeStatus?Colors.black:Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.list,
                    color:widget.themeStatus?Colors.yellow:Colors.black,
                  ),
                  Text('Saved Articles',
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.search_off_outlined,
                          color:widget.themeStatus?Colors.yellow:Colors.black,
                        ),
                        Text('No saved articles',
                          style: TextStyle(
                            color: widget.themeStatus?Colors.yellow:Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
