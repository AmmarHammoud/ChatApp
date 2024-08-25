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
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(name),
        Row(
          children: [
            if (isMe)
              Icon(
                messageStatus == MessageStatus.sent
                    ? Icons.done
                    : messageStatus == MessageStatus.delivered
                        ? Icons.done_all
                        : Icons.watch_later_outlined,
                color: messageStatus == MessageStatus.seen
                    ? Colors.blue
                    : Colors.grey,
                size: 16,
              ),
            const SizedBox(
              width: 2,
            ),
            Text(
              lastMessage,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
          ],
        ),
      ],
    );
  }
}
