import 'dart:developer';

import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/shared/cash_helper.dart';
import 'package:chat_app/shared/dio_helper/dio_helper.dart';
import 'package:get/get.dart';

import '../../../models/chat_model.dart';

class HomeController extends GetxController {
  var state = 'initial'.obs;
  RxList<ChatModel> chats = <ChatModel>[].obs;

  // @override
  // void onInit() {
  //   getAllChatsOfCurrentUser(userId: CashHelper.getUserId()!);
  //   super.onInit();
  // }

  @override
  void onReady() {
    getAllChatsOfCurrentUser();
    super.onReady();
  }

  void getAllChatsOfCurrentUser() {
    state('loading');
    int userId = CashHelper.getUserId()!;
    chats.clear();
    DioHelper.getAllChatsOfCurrentUser(
            token: CashHelper.getUserToken()!, userId: userId)
        .then((value) {
      //log(value.data.toString());
      for (int i = 0; i < value.data['data']['participants'].length; i++) {
        if (value.data['data']['participants'][i]['user']['id'] == userId) {
          continue;
        }
        chats.add(ChatModel.fromJson(value.data['data']['participants'][i]));
        chats.elementAt(chats.length - 1).lastMessage =
            MessageModel.fromJson(value.data['data']['last_message']);
      }
      log(chats.toString());
      state('success');
    }).onError((error, h) {
      log('error getting chats of current user ${error.toString()}\n ${h.toString()}');
      state('error');
    });
  }
}
