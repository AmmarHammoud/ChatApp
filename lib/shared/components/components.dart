import 'dart:developer';

import 'package:chat_app/models/emoji_model.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../load_emojies.dart';

navigateTo(context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

navigateAndFinish(context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false,
  );
}

class ValidatedTextField extends StatefulWidget {
  final GlobalKey<FormState>? validator;
  final String errorText;
  final String hintText;
  final bool hasNextText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextEditingController controller;
  final bool enable;
  final IconData? icon;
  final Widget? suffixIcon;
  final bool obscureText;
  final double fontSize;
  final double radius;
  final Function()? onEmojiIconPressed;
  final Function()? onTap;

  const ValidatedTextField(
      {Key? key,
      required this.controller,
      this.validator,
      required this.errorText,
      required this.hintText,
      required this.onChanged,
      this.onEmojiIconPressed,
      this.onTap,
      this.onFieldSubmitted,
      this.hasNextText = true,
      this.enable = true,
      this.icon,
      this.suffixIcon,
      this.obscureText = false,
      this.fontSize = 20.0,
      this.radius = 15.0})
      : super(key: key);

  @override
  State<ValidatedTextField> createState() => _ValidatedTextFieldState();
}

class _ValidatedTextFieldState extends State<ValidatedTextField> {
  bool _showEmojiPicker = false;

  List<CategoryEmoji> _emojis = [];
  late TextStyle _textStyle;
  late TextEditingController _controller;

  @override
  void initState() {
    // 1. Define Custom Font & Text Style
    _textStyle = DefaultEmojiTextStyle.copyWith(
      fontFamily: GoogleFonts.notoEmoji().fontFamily,
      //fontSize: fontSize,
    );

    // 2. Use EmojiTextEditingController
    _controller = EmojiTextEditingController(emojiTextStyle: _textStyle);
    super.initState();
    // loadEmojis().then((emojis) {
    //   setState(() {
    //     _emojis = emojis;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    TextInputType? textInputType;
    if (widget.hintText == 'email') {
      textInputType = TextInputType.emailAddress;
    } else if (widget.hintText == 'phone number') {
      textInputType = TextInputType.phone;
    }

    return Column(
      children: [
        Form(
          key: widget.validator,
          child: TextFormField(
            onTap: widget.onTap,
            //focusNode: FocusScope.of(context).unfocus(),
            //onFieldSubmitted: onFieldSubmitted,
            controller: widget.controller,
            enabled: widget.enable,
            // textInputAction:
            //     hasNextText ? TextInputAction.next : TextInputAction.done,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            obscureText: widget.obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return widget.errorText;
              }
              return null;
            },
            onChanged: widget.onChanged,
            style: TextStyle(fontSize: widget.fontSize),
            decoration: InputDecoration(
              suffixIcon: widget.suffixIcon,
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
              ),
              //prefixIcon: Icon(icon),
              prefixIcon: IconButton(
                  onPressed: widget.onEmojiIconPressed,
                  icon: Icon(widget.icon)),
            ),
          ),
        ),
      ],
    );
  }
}

class MyEmojiPicker extends StatelessWidget {
  const MyEmojiPicker({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500, // Adjust the height as needed
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {
          //controller.text += emoji.emoji;
          log(emoji.emoji);
          // Get the code point of the emoji
          int codePoint = emoji.emoji.runes.first;

          // Convert the code point to a Unicode string
          String unicode = 'U+${codePoint.toRadixString(16).toUpperCase()}';

          //for(int i = 0; i < emoji.emoji.characters.length; i++){log(emoji.emoji.characters.elementAt(i));}
          log(unicode);
        },
        customWidget: (config, state, showSearchBar) {
          //return Container(child: Text(config.emojiSet[0].emoji[0].emoji),);
          return Image.asset(
            'assets/emojis/facebook/1f606.png',
            width: 24,
            height: 24,
          );
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
    );
  }
}
