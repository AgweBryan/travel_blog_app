import 'package:flutter/material.dart';
import '/widgets/logo.dart';
import 'package:travel_blog_app/widgets/logo.dart';

class AuthScreen extends StatelessWidget {
  final Function? handleGoogleSignIn;
  AuthScreen({required this.handleGoogleSignIn});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage('assets/captainAmerica.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.9), BlendMode.darken),
            )),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * .15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Logo(
                      size: 50,
                    ),
                  ),
                  SizedBox(
                    height: height * .10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'WATCH TV SHOWS & MOVIES ANYWHERE. ANYTIME.',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    onTap: () {
                      handleGoogleSignIn!();
                    },
                    child: SizedBox(
                      height: 70,
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          color: Colors.red,
                          child: Row(
                            children: [
                              Container(
                                  color: Colors.grey.shade100,
                                  alignment: Alignment.center,
                                  child: Image.asset('assets/google_logo.png')),
                              Expanded(
                                  child: Container(
                                color: Colors.red,
                                alignment: Alignment.center,
                                child: Text(
                                  'Sign in with google',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
