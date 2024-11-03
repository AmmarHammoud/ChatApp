import 'dart:developer';

import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/screens/chat_screen/logic/chat_controller.dart';
import 'package:chat_app/shared/constants/constants.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class MessageItem extends StatelessWidget {
  MessageItem({
    super.key,
    required this.messageModel,
    required this.animation,
    this.triggerSendingAnimation = false,
    // this.messageStatus = MessageStatus.sending,
    this.onTap,
    this.onDoubleTap,
  });

  MessageModel messageModel;
  Animation<double> animation;
  final bool triggerSendingAnimation;
  // MessageStatus messageStatus;
  final Function()? onTap;
  final Function()? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        //Get.find<ChatController>().deleteMessage(messageItem: this);
        log('screen width * message length: ${screenWidth * messageModel.message.length * 0.19}');
      },
      onDoubleTap: onDoubleTap,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: triggerSendingAnimation
              ? Offset(-screenWidth * 0.002, screenWidth * 0.005)
              : const Offset(0, 0),
          end: const Offset(0, 0),
        ).animate(animation),
        child: Align(
          alignment:
              messageModel.isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
              minWidth: screenWidth * .21,
              maxWidth: screenWidth * 0.75,
            ),
            width: messageModel.message.length * screenWidth * 0.03,
            decoration: BoxDecoration(
              color: messageModel.isMe ? Colors.green[800] : Colors.grey[700],
              borderRadius: messageModel.isMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
            ),
            // margin: messageModel.isMe
            //     ? EdgeInsets.only(
            //         left: 0.25 * screenWidth, right: 0.05 * screenWidth)
            //     : EdgeInsets.only(
            //         left: 0.05 * screenWidth, right: 0.25 * screenWidth),
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    messageModel.message,
                    textAlign: TextAlign.left,
                    style: const TextStyle(color: Colors.white),
                    //overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        messageModel.sendAt,
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                      SizedBox(
                        width: screenWidth * 0.01,
                      ),
                      if(messageModel.isMe) messageStateIcon(
                          messageStatus: messageModel.status,
                          color: Colors.grey[300]!)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
