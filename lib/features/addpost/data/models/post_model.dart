import 'package:hive/hive.dart';


part 'post_model.g.dart';
@HiveType(typeId: 1)
class PostModel extends HiveObject{

  @HiveField(0) String? postImg;
  @HiveField(1) String? name;
  @HiveField(2) String? dateTime;
  @HiveField(3) String? image;
  @HiveField(3) String? bio;
  @HiveField(4) String? uid;
  @HiveField(5) String? deviceToken;

  PostModel(
      {required this.postImg,
      required this.name,
      required this.dateTime,
      required this.uid,
      required this.bio,
      required this.image,
      required this.deviceToken,
      });

  PostModel.fromJson(Map<String, dynamic> json) {
    postImg = json['postImage'];
    name = json['name'];
    dateTime = json['dateTime'];
    image = json['image'];
    uid = json['uid'];
    bio = json['bio'];
    deviceToken = json['deviceToken'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uid': uid,
      'image': image,
      'postImage': postImg,
      'dateTime': dateTime,
      'bio': bio,
      'deviceToken': deviceToken,
    };
  }
}
