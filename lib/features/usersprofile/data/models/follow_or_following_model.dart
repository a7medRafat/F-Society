class FollowOrFollowingModel {
  String? senderUid;
  String? receiverUid;
  String? name;
  String? image;

  FollowOrFollowingModel(
      {required this.senderUid, required this.receiverUid, required this.name, required this.image});

  FollowOrFollowingModel.fromJson(Map<String, dynamic> json) {
    senderUid = json['senderUid'];
    receiverUid = json['receiverUid'];
    name = json['name'];
    image = json['image'];
  }


  Map<String, dynamic> toMap() {
    return {
      'senderUid': senderUid,
      'receiverUid': receiverUid,
      'name': name,
      'image': image,
    };
  }

}