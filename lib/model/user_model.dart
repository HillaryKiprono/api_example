class UserModel {
  final int id;
  final String title;
  final String body;

  UserModel({required this.id, required this.title, required this.body});

  factory UserModel.fromJson(Map<String, dynamic> map){
    return UserModel(
        id: map['id'],
        title: map['title'],
        body: map['body']
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body
    };
  }
}