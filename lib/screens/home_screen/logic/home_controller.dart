import 'dart:developer';

import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/shared/cash_helper.dart';
import 'package:chat_app/shared/dio_helper/dio_helper.dart';
import 'package:get/get.dart';

import '../../../models/chat_model.dart';
import 'home_screen_states.dart';

class HomeController extends GetxController {
  late Rx<HomeScreenStates> state;
  RxList<ChatModel> chats = <ChatModel>[].obs;

  @override
  void onInit() {
    state = HomeScreenStates().obs;
    super.onInit();
  }

  @override
  void onReady() {
    getAllChatsOfCurrentUser();
    super.onReady();
  }

  void getAllChatsOfCurrentUser() {
    state.value = HomeScreenLoadingState();
    int userId = CashHelper.getUser()['id'];
    chats.clear();
    DioHelper.getAllChatsOfCurrentUser(token: CashHelper.getUserToken()!)
        .then((value) {
      //log(value.data.toString());
      for (int i = 0; i < value.data['data'].length; i++) {
        if (value.data['data'][i]['user2_id'] == userId) {
          continue;
        }
        chats.add(ChatModel.fromJson(value.data['data'][i]));
        // chats.elementAt(chats.length - 1).lastMessage =
        //     MessageModel.fromJson(value.data['data']['last_message']);
      }
      log(chats.toString());
      state.value = HomeScreenSuccessState();
    }).onError((error, h) {
      log('error getting chats of current user ${error.toString()}\n ${h.toString()}');
      state.value = HomeScreenErrorState(error.toString());
    });
  }
}
