import 'package:chat_app/shared/cash_helper.dart';

class MessageModel {
  late String message;
  late String sendAt;
  late bool isMe;
  late int id;
  late int chatId;

  MessageModel(
      {required this.message, required this.sendAt, required this.isMe});

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatId = json['chat_id'];
    message = json['message'];
    isMe = CashHelper.getUserId()! == json['user']['id'];
    sendAt = json['updated_at'].toString().substring(14, 18);
  }

  @override
  String toString() {
    return 'message: $message';
  }
}
