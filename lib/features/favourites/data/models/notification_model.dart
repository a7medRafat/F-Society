class NotificationModel {
  String? title;
  String? body;
  String? bio;
  String? senderUid;
  String? receiverUid;
  String? postId;
  String? image;
  String? type;
  String? fcmToken;

  NotificationModel(
      {required this.title,
      required this.body,
      required this.bio,
      required this.senderUid,
      required this.receiverUid,
      required this.postId,
      required this.type,
      required this.fcmToken,
      required this.image});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    bio = json['bio'];
    senderUid = json['senderUid'];
    receiverUid = json['receiverUid'];
    postId = json['postId'];
    image = json['image'];
    type = json['type'];
    fcmToken = json['fcmToken'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'bio': bio,
      'senderUid': senderUid,
      'receiverUid': receiverUid,
      'postId': postId,
      'image': image,
      'type': type,
      'fcmToken': fcmToken,
    };
  }
}
