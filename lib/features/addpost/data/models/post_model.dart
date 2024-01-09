class PostModel {
  String? postImg;
  String? name;
  String? dateTime;
  String? image;
  String? uid;

  PostModel(
      {required this.postImg,
      required this.name,
      required this.dateTime,
      required this.uid,
      required this.image});

  PostModel.fromJson(Map<String, dynamic> json) {
    postImg = json['postImage'];
    name = json['name'];
    dateTime = json['dateTime'];
    image = json['image'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uid': uid,
      'image': image,
      'postImage': postImg,
      'dateTime': dateTime
    };
  }
}
