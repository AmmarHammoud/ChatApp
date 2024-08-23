import 'dart:developer';

import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/shared/cash_helper.dart';
import 'package:chat_app/shared/components/message_item/message_item.dart';
import 'package:chat_app/shared/dio_helper/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var state = 'initial'.obs;

  //late RxInt chatId;
  var messageTextController = TextEditingController().obs;
  RxList<MessageItem> messages = <MessageItem>[].obs;

  void getChatById({required int chatId, int page = 1}) {
    state('loading');
    messages.clear();
    DioHelper.getChatById(
            chatId: chatId, page: page, token: CashHelper.getUserToken()!)
        .then((value) {
      //log(value.data.toString());
      for (int i = value.data['data'].length - 1; i >= 0; i--) {
        MessageModel messageModel =
            MessageModel.fromJson(value.data['data'][i]);
        messages.add(
          MessageItem(
            isMe: messageModel.isMe,
            messageTime: DateFormat('yy-MM-dd hh:mm').format(DateTime.now()),
            message: messageModel.message,
            animation: animation.value,
          ),
        );
      }
      log(messages.toString());
      state('success');
    }).onError((error, h) {
      log('error getting chat by id: ${error.toString()}');
      state('error');
    });
  }

  final ScrollController scrollController = ScrollController();
  late final animationController;
  late final animation;

  @override
  void onInit() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    ).obs;
    animation = CurvedAnimation(
      parent: animationController.value,
      curve: Curves.easeOut,
    ).obs;
    super.onInit();
  }

  void sendMessage({required int chatId, required String message}) {
    state('loading when send message');
    if (message.isEmpty) return;
    MessageModel messageModel = MessageModel(
        message: message,
        sendAt: DateFormat('yy-MM-dd').format(DateTime.now()),
        isMe: true);
    DioHelper.sendMessage(
            chatId: chatId, message: message, token: CashHelper.getUserToken()!)
        .then((value) {
      log(value.data.toString());
      //getChatById(chatId: chatId);
      state('success');
    }).onError((error, h) {
      log('error sending message: ${error.toString()}');
      state('error');
    });
    messageTextController.value.text = '';
    messages.add(
      MessageItem(
        isMe: messageModel.isMe,
        messageTime: DateFormat('yy-MM-dd hh:mm').format(DateTime.now()),
        message: messageModel.message,
        animation: animation.value,
        doAnimation: true,
      ),
    );

    animationController.value.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
