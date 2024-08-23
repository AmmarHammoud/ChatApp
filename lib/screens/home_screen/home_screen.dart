import 'package:chat_app/screens/home_screen/logic/home_controller.dart';
import 'package:chat_app/shared/cash_helper.dart';
import 'package:chat_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/components/chat_item/chat_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  var homeController =
      Get.put<HomeController>(HomeController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('WhatsApp'),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        body: homeController.state.value != 'loading'
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
                      itemBuilder: (context, index) => ChatItem(
                          chatId: homeController.chats[index].chatId,
                          isMe: homeController.chats[index].lastMessage?.isMe ??
                              false,
                          name: homeController.chats[index].user.userName,
                          lastMessage: homeController
                                  .chats[index].lastMessage?.message ??
                              '',
                          messageStatus: MessageStatus.seen,
                          lastSeen: DateTime.now()),
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
