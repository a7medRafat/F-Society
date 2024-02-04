class FollowersModel {
  String? senderUid;
  String? receiverUid;
  String? name;
  String? image;
  String? bio;

  FollowersModel(
      {required this.senderUid, required this.receiverUid, required this.name, required this.image ,required this.bio});

  FollowersModel.fromJson(Map<String, dynamic> json) {
    senderUid = json['senderUid'];
    receiverUid = json['receiverUid'];
    name = json['name'];
    image = json['image'];
    bio = json['bio'];
  }


  Map<String, dynamic> toMap() {
    return {
      'senderUid': senderUid,
      'receiverUid': receiverUid,
      'name': name,
      'image': image,
      'bio': bio,
    };
  }

}