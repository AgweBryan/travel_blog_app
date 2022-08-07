import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_blog_app/login.dart';
import 'package:travel_blog_app/screens/home.dart';
import 'package:travel_blog_app/wrapper.dart';
// import './screens//home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: TripBlogApp()));
}

class TripBlogApp extends StatelessWidget {
  const TripBlogApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      // home: HomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => Wrapper(),
      },
      // home: GoogleFacebookSignin(),
      debugShowCheckedModeBanner: false,
    );
  }
}
