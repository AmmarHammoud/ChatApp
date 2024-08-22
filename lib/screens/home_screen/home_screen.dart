import 'package:chat_app/shared/constants.dart';
import 'package:flutter/material.dart';

import '../../shared/components/chat_item/chat_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
            itemBuilder: (context, index) => ChatItem(
                name: 'ab yasen',
                lastMessage: 'lastMessage',
                messageStatus: MessageStatus.seen,
                lastSeen: DateTime.now()),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
                ),
            itemCount: 10),
      ),
    );
  }
}
