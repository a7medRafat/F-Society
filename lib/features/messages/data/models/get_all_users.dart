import 'package:hive/hive.dart';
part 'get_all_users.g.dart';

@HiveType(typeId: 2)
class AllUsersModel extends HiveObject {

  @HiveField(0) String? name;
  @HiveField(1) String? email;
  @HiveField(2) String? phone;
  @HiveField(3) String? uid;
  @HiveField(4) String? image;
  @HiveField(5) String? bio;
  @HiveField(6) bool? isEmailVerified;

  AllUsersModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uid,
    required this.isEmailVerified,
    required this.image,
    required this.bio,
  });

  AllUsersModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
    image = json['image'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'isEmailVerified' : isEmailVerified,
      'image': image,
      'bio' : bio
    };
  }
}
