import 'package:flutter/material.dart';
import 'package:grayquest_app/models/user_provider.dart';
import 'package:grayquest_app/screens/home.dart';
import 'package:grayquest_app/screens/view_albums.dart';
import 'package:grayquest_app/screens/create_post.dart';
import 'package:grayquest_app/screens/log_in.dart';
import 'package:grayquest_app/screens/profile.dart';
import 'package:grayquest_app/screens/todo_list.dart';
import 'package:grayquest_app/screens/view_photos.dart';
import 'package:grayquest_app/screens/view_posts.dart';
import 'package:grayquest_app/utils.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grayquest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: colorCustomGreen,
      ),
      home: LogInPage(),
    );
  }
}
