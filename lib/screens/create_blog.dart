import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';

import 'package:image_picker/image_picker.dart';
import 'package:travel_blog_app/services/crud.dart';
import 'package:travel_blog_app/widgets/logo.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String? authorName, title, desc;

  File? selectedImage;

  CrudMethods crudMethods = CrudMethods();

  bool isLoading = false;

  Future getImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    final File file = File(image!.path);

    setState(() {
      selectedImage = file;
    });
  }

  uploadBlog(BuildContext context) async {
    if (selectedImage != null) {
      setState(() {
        isLoading = true;
      });

      // Upload image to firebase storage

      final Reference firebaseStorageReference = FirebaseStorage.instance
          .ref()
          .child('blogImages')
          .child('${randomAlphaNumeric(9)}.jpg');

      await firebaseStorageReference.putFile(selectedImage!);

      final downloadUrl = await firebaseStorageReference.getDownloadURL();

      Map<String, dynamic> blogMap = {
        "imgUrl": downloadUrl,
        "authorName": authorName!,
        "title": title!,
        "desc": desc!,
        "id": DateTime.now().toString(),
        "favorite": false,
      };

      crudMethods.addData(blogMap).then((reslut) {
        Navigator.pop(context);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields and select an image'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 80,
          title: Logo(size: 40),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                uploadBlog(context);
              },
              icon: Icon(Icons.file_upload),
            ),
          ],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    InkWell(
                      onTap: getImage,
                      child: selectedImage != null
                          ? Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(selectedImage!),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            )
                          : Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black,
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "Author Name"),
                      onChanged: (val) {
                        authorName = val;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "Title"),
                      onChanged: (val) {
                        title = val;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "Description"),
                      onChanged: (val) {
                        desc = val;
                      },
                    ),
                  ],
                ),
              ));
  }
}
