import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleFacebookSignin extends StatefulWidget {
  const GoogleFacebookSignin({Key? key}) : super(key: key);

  @override
  State<GoogleFacebookSignin> createState() => _GoogleFacebookSigninState();
}

final GoogleSignIn _googleSignIn = GoogleSignIn();

class _GoogleFacebookSigninState extends State<GoogleFacebookSignin> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Flutter google signin',
          ),
        ),
        body: buildWidget());
  }

  Widget buildWidget() {
    GoogleSignInAccount? user = _currentUser;

    if (user != null) {
      return Padding(
        padding: EdgeInsets.all(12),
        child: Column(children: [
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName!),
            subtitle: Text(user.email),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Sign in successful',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: signOut,
            child: Text('Sign Out'),
          ),
        ]),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(12),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'You are not signed in',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              await GoogleSignIn().signIn().then((account) {
                setState(() {
                  _currentUser = account;
                });
              });
            },
            child: Text('Sign In'),
          ),
        ]),
      );
    }
  }

  void signOut() {
    GoogleSignIn().disconnect();
  }
}
