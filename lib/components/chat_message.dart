
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ai/components/custom_avatar.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUserMessage;
  final String imageUrlBot = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQF-DXpljPVse5mSN9XZQl6UYDEDgDc6s4j0Q&s';
  final String imageUrlUser = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9FOpl3qrxmtiS63oN1Vz_v_B_wmQQfzUXNw&s';
  final bool isImage;
  final String image;


  const ChatMessage({super.key, required this.text, required this.isUserMessage, this.isImage= false,  this.image = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: isUserMessage
          ? Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 280,
                margin: const EdgeInsets.only(right: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(text, softWrap: true,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.end,

                  ),
                ),
              ),
              image.isNotEmpty && isImage ? Container(
                  padding: EdgeInsets.only(right: 10),
                  alignment: Alignment.centerRight,
                  child: Image.file(File(image), height: 100, width: 100,)
              ):const SizedBox(),
            ],
          ),
          Container(
            // margin: const EdgeInsets.only(right: 16.0),
            child: CustomAvatar(profileUrl: imageUrlUser,),
          ),
        ],
      ): Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
             margin: EdgeInsets.only(right: 12.0, bottom: 16),
            child: CustomAvatar(profileUrl: imageUrlBot,)
          ),
          Expanded(
            child: Container(
              // margin: const EdgeInsets.only(top: 12.0),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}




