import 'package:chat_app/screens/home_screen/logic/home_controller.dart';
import 'package:chat_app/screens/home_screen/logic/home_screen_states.dart';
import 'package:chat_app/shared/cash_helper.dart';
import 'package:chat_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../shared/components/chat_item/chat_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController =
      Get.put<HomeController>(HomeController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          // leading: null,
          automaticallyImplyLeading: false,
          title: const Text('ChatApp'),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        body: homeController.state.value is! HomeScreenLoadingState
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                // child: ListView.separated(
                //     itemBuilder: (context, index) => ChatItem(
                //         name: 'ab yasen',
                //         lastMessage: 'lastMessage',
                //         messageStatus: MessageStatus.seen,
                //         lastSeen: DateTime.now()),
                //     separatorBuilder: (context, index) => const SizedBox(
                //           height: 5,
                //         ),
                //     itemCount: 10),
                child: Obx(() {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => ChatItem(
                          //image: CashHelper.getUserId()! == 7 ? 'assets/images/superman.png' : 'assets/images/batman.png',
                          chatId: homeController.chats[index].chatId,
                          isMe: homeController.chats[index].lastMessage?.isMe ??
                              false,
                          // name: homeController.chats[index].user.userName,
                          name: 'homeController.chats[index].user.userName',
                          lastMessage: homeController
                                  .chats[index].lastMessage?.message ??
                              'lastMessage',
                          messageStatus: MessageStatus.seen,
                          lastSeen: DateFormat('yy-MM-dd hh:mm')
                              .format(DateTime.now())),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 5,
                          ),
                      itemCount: homeController.chats.length);
                }),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      );
    });
  }
}
