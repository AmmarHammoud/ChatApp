class UserModel {
  late int id;
  late String userName;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['name'] ?? 'userName';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
      };

  @override
  String toString() {
    return 'id: $id, user name: $userName';
  }
}
