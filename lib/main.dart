import 'package:flutter/material.dart';
import 'package:grayquest_app/models/user_provider.dart';

import 'package:grayquest_app/screens/log_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grayquest_app/utils.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
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
        textTheme: GoogleFonts.alegreyaSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: LogInPage(),
    );
  }
}
