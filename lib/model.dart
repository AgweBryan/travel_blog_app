class UserDetails {
  String? displayName;
  String? email;
  String? photoUrl;

  UserDetails({this.displayName, this.email, this.photoUrl});

  UserDetails fromJson(Map<String, dynamic> json) {
    return UserDetails(
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['displayName'] = displayName;
    data['email'] = email;
    data['photoUrl'] = photoUrl;

    return data;
  }
}
