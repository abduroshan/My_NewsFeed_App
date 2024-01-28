import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_feed_app/presentation/bloc/news/news_bloc.dart';

import 'app/my_app.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(create: (context) => NewsBloc()),
        // Add more BlocProviders for other BLoCs if needed
      ],
      child: const MyApp(),
    ),
  );
}
