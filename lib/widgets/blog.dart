import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/details_page.dart';

class Blog extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final bool? isSearching;
  Blog({required this.snapshot, this.isSearching});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  List<QueryDocumentSnapshot<Object?>>? allBlogs;

  @override
  void initState() {
    super.initState();

    allBlogs = widget.snapshot.data!.docs;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.all(16), children: [
      widget.isSearching!
          ? Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: TextField(
                decoration: InputDecoration(hintText: 'Search title'),
                onChanged: searchBlogs,
              ),
            )
          : Container(),
      ...allBlogs!.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        return SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(
                              imgUrl: data['imgUrl'],
                              title: data['title'],
                              authorName: data['authorName'],
                              desc: data['desc'],
                            ))),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(data['imgUrl']),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Center(
                        child: Text(
                          data['title'],
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                data['desc'],
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '--> ${data['authorName']}',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(
                height: 16,
              )
            ],
          ),
        );
      }).toList(),
    ]);
  }

  void searchBlogs(String value) {
    final suggestions =
        widget.snapshot.data!.docs.where((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      final blogTitle = data['title'].toLowerCase();
      final input = value.toLowerCase();

      return blogTitle.contains(input);
    }).toList();

    setState(() {
      allBlogs = suggestions;
    });
  }
}
