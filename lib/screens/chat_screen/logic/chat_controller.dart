import 'dart:convert';
import 'dart:developer';

import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/shared/cash_helper.dart';
import 'package:chat_app/shared/components/chat_item/chat_item.dart';
import 'package:chat_app/shared/components/message_item/message_item.dart';
import 'package:chat_app/shared/constants/constants.dart';
import 'package:chat_app/shared/dio_helper/dio_helper.dart';

import 'package:chat_app/shared/pusher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../shared/constants/string_to_json.dart';

class ChatController extends GetxController with GetTickerProviderStateMixin {
  var state = 'initial'.obs;
  Rx<bool> startAnimation = false.obs;
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
              //index: i,
              messageStatus: messageModel.messageStatus,
              messageModel: messageModel,
              animation: animation.value),
        );
        WidgetsBinding.instance.addPostFrameCallback((_) {
          startAnimation.value = true;
        });
      }
      log(messages.toString());
      moveScrollController();
      state('success');
    }).onError((error, h) {
      log('error getting chat by id: ${error.toString()}');
      state('error');
    });
  }

  final ScrollController scrollController = ScrollController();
  late final Rx<AnimationController> animationController;
  late final Rx<CurvedAnimation> animation;

  late final Rx<AnimationController> fadeAnimationController;
  late final Rx<CurvedAnimation> fadeAnimation;

  var chatPusher = Pusher();
  int roomId = Get.arguments;

  @override
  void onInit() async {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    ).obs;
    animation = CurvedAnimation(
      parent: animationController.value,
      curve: Curves.easeOut,
    ).obs;

    fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 0),
      vsync: this,
    ).obs;
    fadeAnimation = CurvedAnimation(
      parent: animationController.value,
      curve: Curves.easeOut,
    ).obs;

    // chatPusher.init(
    //     onEventx: (PusherEvent e) {
    //       if (e.data == null || e.data.isEmpty) return;
    //       log('on event in CHAT CONTROLLER: ${e.data.runtimeType}');
    //       log('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
    //       try {
    //         var json = jsonDecode('${e.data}');
    //         MessageModel messageModel = MessageModel.fromJson(json['message']);
    //         log('isMe ------------------------------------------ ${messageModel.isMe}');
    //         if (messageModel.isMe) return;
    //         messages.add(
    //           MessageItem(
    //               doAnimation: true,
    //               messageStatus: messageModel.messageStatus,
    //               messageModel: messageModel,
    //               animation: animation.value),
    //         );
    //         moveScrollController();
    //         animationController.value.forward();
    //       } catch (e) {
    //         log('error decoding message model: ${e.toString()}');
    //       }
    //
    //       //state('success');
    //       log('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
    //     },
    //     roomId: roomId);
    super.onInit();
  }

  void sendMessage({required int chatId, required String message}) {
    state('loading when send message');
    if (message.isEmpty) return;
    MessageModel messageModel = MessageModel(
        message: message,
        sendAt: DateFormat('hh:mm').format(DateTime.now()),
        isMe: true);
    DioHelper.sendMessage(
            chatId: chatId, message: message, token: CashHelper.getUserToken()!)
        .then((value) async {
      log(value.data.toString());
      messageModel.messageStatus = MessageStatus.sent;
      log(chatPusher.pusher.channels.toString());
      state('success');
    }).onError((error, h) {
      log('error sending message: ${error.toString()}');
      state('error');
    });
    messageTextController.value.text = '';
    messages.add(
      MessageItem(
        triggerSendingAnimation: true,
        messageStatus: messageModel.messageStatus,
        messageModel: messageModel,
        animation: animation.value,
      ),
    );

    animationController.value.forward();

    moveScrollController();
  }

  void deleteMessage({required MessageItem messageItem}) async {}

  moveScrollController() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  // void triggeX() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     startAnimation.value = true;
  //   });
  // }

  // @override
  // void onReady() {
  //   //WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
  //     //Future.delayed(const Duration(milliseconds: 10000));
  //     startAnimation.value = true;
  //  // });
  //   super.onReady();
  // }

  @override
  void onClose() async {
    scrollController.dispose();
    chatPusher.unsubscribeAndClose(roomId: roomId);
    super.onClose();
  }
}
