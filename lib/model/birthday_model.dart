// 誕生日データモデル

class BirthdayData {
  final String name;
  final DateTime birthday;
  final String imagePath;

  BirthdayData({
    required this.name,
    required this.birthday,
    required this.imagePath,
  });
}

//birthdayカードモデル
class BirthdayCardModel {
  final String id;
  final String senderName;
  final String message;
  final String imageUrl;

  BirthdayCardModel({
    required this.id,
    required this.senderName,
    required this.message,
    required this.imageUrl,
  });
}
