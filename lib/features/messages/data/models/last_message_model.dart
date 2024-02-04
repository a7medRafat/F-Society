class LastMsgModel {
  String? name;
  String? image;
  String? lastMessage;
  String? receiverId;

  LastMsgModel({
    required this.name,
    required this.image,
    required this.lastMessage,
    required this.receiverId,
  });

  LastMsgModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    lastMessage = json['lastMessage'];
    receiverId = json['receiverId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'lastMessage': lastMessage,
      'receiverId': receiverId,
    };
  }
}
