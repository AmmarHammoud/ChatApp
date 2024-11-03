import 'package:chat_app/shared/cash_helper.dart';

import '../shared/constants/constants.dart';

class MessageModel {
  late String message;
  late String sendAt;
  late bool isMe;
  late int id;
  late int chatId;
  late MessageStatus status = MessageStatus.sending;

  MessageModel({
    required this.message,
    required this.sendAt,
    required this.isMe,
    this.status = MessageStatus.sending,
  });

  MessageStatus _checkMessageStatus(String status) {
    if (status == 'sent') {
      return MessageStatus.sent;
    } else if (status == 'delivered') {
      return MessageStatus.delivered;
    } else if (status == 'seen') {
      return MessageStatus.seen;
    }
    return MessageStatus.sending;
  }

  MessageModel.fromJson(Map<String, dynamic> json) {
    int currentUserId = CashHelper.getUser()['id'];
    id = json['id'];
    chatId = json['conversation_id'];
    message = json['message'];
    isMe = currentUserId == json['user_id'];
    sendAt = json['updated_at'].toString().substring(14, 19);
    status = _checkMessageStatus(json['status']);
  }

  @override
  String toString() {
    return '{message: $message}';
  }
}
