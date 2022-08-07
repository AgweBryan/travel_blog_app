import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatelessWidget {
  final String? imgUrl;
  final String? title;
  final String? authorName;
  final String? desc;
  DetailPage({this.imgUrl, this.title, this.authorName, this.desc});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: height * .5,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        image: NetworkImage(imgUrl!), fit: BoxFit.cover)),
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
                        title!,
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height,
                width: double.infinity,
                color: Colors.transparent,
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: height * .56,
                  decoration: BoxDecoration(
                    color: ThemeData.dark().backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        desc!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 30),
                      Text(
                        authorName!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: height * .135,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back)),
                    Expanded(child: SizedBox()),
                    IconButton(
                        onPressed: () async {
                          final response = await http.get(Uri.parse(imgUrl!));
                          final bytes = response.bodyBytes;
                          final temp = await getTemporaryDirectory();
                          final path = '${temp.path}/image.jpg';
                          File(path).writeAsBytes(bytes);
                          await Share.shareFiles([path], text: desc!);
                        },
                        icon: Icon(Icons.share))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
