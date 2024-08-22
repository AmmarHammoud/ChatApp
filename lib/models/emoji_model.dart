class EmojiModel {
  final String code;
  final String char;
  final String description;

  EmojiModel(
      {required this.code, required this.char, required this.description});

  factory EmojiModel.fromJson(Map<String, dynamic> json) {
    return EmojiModel(
      code: json['code'],
      char: json['char'],
      description: json['description'],
    );
  }
}
