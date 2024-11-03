import 'package:chat_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';

class NameAndLastMessage extends StatelessWidget {
  const NameAndLastMessage(
      {super.key,
      required this.name,
      required this.messageStatus,
      required this.isMe,
      required this.lastMessage});

  final String name;
  final MessageStatus messageStatus;
  final String lastMessage;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            if (isMe) messageStateIcon(messageStatus: messageStatus),
            const SizedBox(
              width: 2,
            ),
            Expanded(
              child: Text(
                lastMessage,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
