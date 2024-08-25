
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  const MessageItem(
      {super.key,
      required this.isMe,
      required this.message,
      required this.messageTime,
      required this.animation,
      this.doAnimation = false});

  final bool isMe;
  final String message;
  final String messageTime;
  final Animation<double> animation;
  final bool doAnimation;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {},
      child: SlideTransition(
        position: Tween<Offset>(
          // begin: const Offset(1, 0),
          // end: const Offset(0, 0),
          begin: doAnimation
              ? Offset(0, screenHeight * 0.005)
              : const Offset(0, 0),
          end: const Offset(0, 0),
        ).animate(animation),
        child: Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.green[800] : Colors.grey[700],
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    //bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
          ),
          margin: isMe
              ? EdgeInsets.only(
                  left: 0.25 * screenWidth, right: 0.05 * screenWidth)
              : EdgeInsets.only(
                  left: 0.05 * screenWidth, right: 0.25 * screenWidth),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: Colors.white),
                  //overflow: TextOverflow.ellipsis,
                ),
                Text(
                  messageTime,
                  style: TextStyle(color: Colors.grey[300]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
