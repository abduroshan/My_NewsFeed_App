import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_feed_app/presentation/view/news_feed/news_feed.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> navigateToNewsFeed() async {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const NewsFeed(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Virtual News',
              style: TextStyle(
                color: Color(0xff2a2828),
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            // const Text(
            //   'Articles at your fingertips',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: 17,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            ElevatedButton(
              onPressed: () {
                navigateToNewsFeed();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Adjust the value as needed
                ),
                primary: Colors.yellowAccent, // Background color
                onPrimary: Colors.black, // Text color
              ),
              child: Text('Start Reading',
              style: TextStyle(
                color: Color(0xff2a2828),
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
