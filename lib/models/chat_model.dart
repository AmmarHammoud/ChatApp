import 'package:chat_app/models/user_model.dart';

import 'message_model.dart';

class ChatModel {
  late int chatId;
  late UserModel user;
  MessageModel? lastMessage;

  ChatModel.fromJson(Map<String, dynamic> json) {
    chatId = json['id'];
    // user = UserModel.fromJson(json['user']);
    //lastMessage = MessageModel.fromJson(json['last_message']);
  }

  @override
  String toString() {
    return 'chat id: $chatId, user: {user}\n';
  }
}
