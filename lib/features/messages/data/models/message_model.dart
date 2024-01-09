class MessageModel {
  String? dateTime;
  String? senderId;
  String? receiverId;
  String? content;

  MessageModel(
      {
      required this.dateTime,
      required this.senderId,
      required this.receiverId,
      required this.content});

  MessageModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTime,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
    };
  }
}
