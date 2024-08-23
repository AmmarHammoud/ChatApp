import 'dart:developer';
import 'package:chat_app/screens/chat_screen/logic/chat_controller.dart';
import 'package:chat_app/screens/home_screen/logic/home_controller.dart';
import 'package:chat_app/shared/components/chat_item/profile_image.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/components/message_item/message_item.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen(
      {super.key,
      required this.name,
      required this.lastSeen,
      required this.image});

  final String name;
  final DateTime lastSeen;
  final String image;

  //List<Widget> messages = [];

  final chatController = Get.put<ChatController>(ChatController())
    ..getChatById(chatId: Get.arguments);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              Get.offNamed('/home');
              Get.find<HomeController>().getAllChatsOfCurrentUser();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ProfileImage(
                image: image,
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  Text(
                    DateFormat('hh:mm').format(lastSeen),
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              )
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.more_vert_outlined)),
          ],
        ),
        body: chatController.state.value != 'loading'
            ? Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    Expanded(
                      child: Obx(() {
                        return ListView.separated(
                            controller: chatController.scrollController,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                chatController.messages[index],
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 5,
                                ),
                            itemCount: chatController.messages.length);
                      }),
                    ),
                    SendingSection(
                      textEditingController:
                          chatController.messageTextController.value,
                      onPressed: () {
                        chatController.sendMessage(
                            chatId: Get.arguments,
                            message: chatController
                                .messageTextController.value.text);
                      },
                    ),
                  ])
            : const Center(child: CircularProgressIndicator()),
      );
    });
  }
}

class SendingSection extends StatefulWidget {
  const SendingSection(
      {super.key,
      required this.onPressed,
      required this.textEditingController});

  final Function()? onPressed;
  final TextEditingController textEditingController;

  @override
  State<SendingSection> createState() => _SendingSectionState();
}

class _SendingSectionState extends State<SendingSection> {
  bool _shoeEmojiPicker = false;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        if (_shoeEmojiPicker) {
          setState(() {
            _shoeEmojiPicker = !_shoeEmojiPicker;
          });
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ValidatedTextField(
                      onTap: () {
                        if (_shoeEmojiPicker) {
                          setState(() {
                            _shoeEmojiPicker = !_shoeEmojiPicker;
                          });
                        }
                      },
                      onEmojiIconPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _shoeEmojiPicker = !_shoeEmojiPicker;
                        });
                      },
                      fontSize: 15,
                      icon: Icons.emoji_emotions_outlined,
                      controller: widget.textEditingController,
                      errorText: 'errorText',
                      hintText: 'Message',
                      onChanged: (x) {}),
                ),
                IconButton(
                  onPressed: widget.onPressed,
                  icon: const Icon(
                    Icons.send,
                    color: Colors.red,
                  ),
                )
              ],
            ),
            if (_shoeEmojiPicker)
              SizedBox(
                height: screenHeight * 0.35, // Adjust the height as needed
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    widget.textEditingController.text += emoji.emoji;
                    log(emoji.emoji);
                  },
                  config: const Config(
                    height: 256,
                    //emojiSet: _emojis,
                    checkPlatformCompatibility: true,
                    //emojiTextStyle: _textStyle,
                    emojiViewConfig: EmojiViewConfig(emojiSizeMax: 28),
                    swapCategoryAndBottomBar: false,
                    skinToneConfig: SkinToneConfig(),
                    categoryViewConfig: CategoryViewConfig(),
                    bottomActionBarConfig: BottomActionBarConfig(),
                    searchViewConfig: SearchViewConfig(),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
