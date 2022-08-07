class Blogs {
  String? id;
  String? title;
  String? desc;
  String? authorName;
  String? imgUrl;
  bool? favorite;

  Blogs({
    this.authorName,
    this.desc,
    this.id,
    this.imgUrl,
    this.title,
  });

  Blogs fromJson(Map<String, dynamic> json) {
    return Blogs(
      id: json['id'],
      authorName: json['authorName'],
      title: json['title'],
      desc: json['desc'],
      imgUrl: json['imgUrl'],
    );
  }
}
