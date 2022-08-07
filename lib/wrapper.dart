import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_blog_app/auth_screen.dart';
import 'package:travel_blog_app/screens/home.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

final GoogleSignIn _googleSignIn = GoogleSignIn();

class _WrapperState extends State<Wrapper> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account; // Could be null or have an account
      });
    });
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _currentUser;
    return Scaffold(
      backgroundColor: Colors.black,
      body: user != null
          ? HomePage(
              currentUser: user,
              )
          : AuthScreen(
              handleGoogleSignIn: () async {
                await GoogleSignIn().signIn().then((account) {
                  setState(() {
                    _currentUser = account;
                  });
                });
              },
            ),
    );
  }
}
