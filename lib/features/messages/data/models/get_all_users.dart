class GetAllUsersModel {
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? image;
  String? bio;
  bool? isEmailVerified;

  GetAllUsersModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uid,
    required this.isEmailVerified,
    required this.image,
    required this.bio,
  });

  GetAllUsersModel.fromJson(Map<String, dynamic> json) {
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
