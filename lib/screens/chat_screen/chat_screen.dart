import 'dart:developer';
import 'package:chat_app/shared/components/chat_item/profile_image.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/components/message_item/message_item.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/message_model.dart';
import '../../shared/load_emojies.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(
      {super.key,
      required this.name,
      required this.lastSeen,
      required this.image});

  final String name;
  final DateTime lastSeen;
  final String image;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  List<Widget> messages = [];

  //List<Widget> messageAnimation = [];
  final ScrollController _scrollController = ScrollController();

  void _sendMessage(TextEditingController c) {
    final message = c.text;
    if (message.isEmpty) return;

    final animationController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    final animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );
    setState(() {
      messages.add(
        MessageItem(
          isMe: true,
          messageTime: DateFormat('yy-MM-dd hh:mm').format(DateTime.now()),
          message: message,
          animation: animation,
        ),
      );
      animationController.forward();

      // final maxScroll = _scrollController.position.maxScrollExtent;
      // log(maxScroll.toString());
      // _scrollController.animateTo(maxScroll,
      //     duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var t = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ProfileImage(
              image: widget.image,
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name),
                Text(
                  DateFormat('hh:mm').format(widget.lastSeen),
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
      body: Column(children: [
        Expanded(
          child: ListView.separated(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => messages[index],
              separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
              itemCount: messages.length),
        ),
        SendingSection(
          textEditingController: t,
          onPressed: () {
            _sendMessage(t);
          },
        ),
      ]),
    );
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
                    onTap: (){
                      if(_shoeEmojiPicker){
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
                  config: Config(
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
