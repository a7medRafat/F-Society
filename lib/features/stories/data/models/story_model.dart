class StoryModel {
  String? storyImage;
  String? image;
  String? userId;
  String? date;
  String? expiryDate;
  String? name;

  StoryModel(
      {required this.storyImage,
      required this.image,
      required this.userId,
      required this.name,
      required this.date,
      required this.expiryDate});

  StoryModel.fromJson(Map<String, dynamic> json) {
    storyImage = json['storyImage'];
    image = json['image'];
    userId = json['userId'];
    name = json['name'];
    date = json['date'];
    date = json['expiryDate'];
  }

  Map<String, dynamic> toMap() {
    return {
      'storyImage': storyImage,
      'image': image,
      'userId': userId,
      'name': name,
      'date': date,
      'expiryDate': expiryDate,
    };
  }
}
