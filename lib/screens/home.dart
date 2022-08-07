import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:travel_blog_app/screens/create_blog.dart';
import 'package:travel_blog_app/services/crud.dart';
import 'package:travel_blog_app/widgets/blog.dart';
import 'package:travel_blog_app/widgets/logo.dart';

class HomePage extends StatefulWidget {
  final GoogleSignInAccount? currentUser;
  HomePage({required this.currentUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CrudMethods crudMethods = CrudMethods();

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(widget.currentUser!.displayName!),
            accountEmail: Text(
              widget.currentUser!.email,
            ),
            currentAccountPicture: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.red, width: 2),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                    widget.currentUser!.photoUrl!,
                  ))),
            ),
          ),
          ListTile(
            title: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                GoogleSignIn().disconnect();
                Navigator.pushReplacementNamed(context, '/');
              },
              child: Text('Log out'),
            ),
          )
        ],
      )),
      appBar: AppBar(
        toolbarHeight: 80,
        title: Logo(size: 40),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                });
              },
              icon: Icon(Icons.search))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: crudMethods.getData(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Could not get blogs. Check connection',
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              Center(
                child: CircularProgressIndicator(),
              );
            }

            return snapshot.data!.docs.length > 0
                ? Blog(
                    snapshot: snapshot,
                    isSearching: isSearching,
                  )
                : Center(
                    child: Text('No data available yet'),
                  );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: ((context) => CreateBlog()))),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

final fetchedVideosStreamProvider =
    StreamProvider<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final CrudMethods crudMethods = CrudMethods();
  return crudMethods.getData();
});
