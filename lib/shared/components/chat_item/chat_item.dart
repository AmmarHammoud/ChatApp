import 'dart:developer';

import 'package:chat_app/screens/chat_screen/chat_screen.dart';
import 'package:chat_app/shared/components/chat_item/last_seen.dart';
import 'package:chat_app/shared/components/chat_item/name_and_last_message.dart';
import 'package:chat_app/shared/components/chat_item/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';

class ChatItem extends StatelessWidget {
  const ChatItem(
      {super.key,
      required this.name,
      required this.lastMessage,
      required this.messageStatus,
      required this.isMe,
      required this.lastSeen,
      required this.chatId, this.image = 'assets/images/batman.png'});

  final String name;
  final String lastMessage;
  final MessageStatus messageStatus;
  final bool isMe;
  final String lastSeen;
  final int chatId;
  final String image;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
            () => ChatScreen(
                name: name,
                lastSeen: lastSeen,
                image: 'assets/images/batman.png'),
            arguments: chatId);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Container(color: Colors.red, width: 100,),
          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: const ProfileImage(
                  image: 'assets/images/batman.png',
                ),
                onTap: () {
                  log('image');
                },
              ),
              const SizedBox(
                width: 15,
              ),
              NameAndLastMessage(
                  name: name,
                  isMe: isMe,
                  messageStatus: messageStatus,
                  lastMessage: lastMessage)
            ],
          ),
          LastSeen(lastSeen: lastSeen)
        ],
      ),
    );
  }
}
