
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_ai/components/button.dart';
import 'package:google_ai/components/chat_message.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late final GenerativeModel model;
  bool isLoading = false;
  late ChatSession chat;
  late final SharedPreferences prefs;
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  List chatData = [];


  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
     prefs = await SharedPreferences.getInstance();
    model = GenerativeModel(
        model: 'gemini-1.0-pro-001',
        apiKey: "AIzaSyDybdEqE",
        generationConfig: GenerationConfig(
          temperature: 0.7,
          topK: 50,
          topP: 0.8,
        ),
        safetySettings: [
          SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
          SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
          SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.high),
          SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.high),
        ],
      //systemInstruction: Content()
    );


    /// initialized chat

     var chatDataPrefs = prefs.getString("chatHistory");
     if(chatDataPrefs != null){
       print("This is Chat data: ${jsonDecode(chatDataPrefs)}");
       List chatList = jsonDecode(chatDataPrefs);
       print("Length: ${chatList.length}");
       List<Content> contentList =[];
       for (var element in chatList) {
         ChatMessage message = ChatMessage(
           text: element["text"],
           isUserMessage: element["isUserMessage"],
         );
           contentList.add(Content.text(element["text"]));
         _messages.insert(0, message);
       }
       chat = model.startChat(
         history: contentList,
       );

     }
     else {
       chat = model.startChat();
     }
     setState(() {

     });
  }


  Future<void> _handleSubmitted(String text) async {
    isLoading = true;
     try{
       _textController.clear();
       ChatMessage message = ChatMessage(
         text: text,
         isUserMessage: true,
       );
       setState(() {
         _messages.insert(0, message);
         chatData.add({"text":text, "isUserMessage":true});
         prefs.setString("chatHistory", jsonEncode(chatData));
       });
       final content = Content.text(text);
       final response = await chat.sendMessage(content);
       print(response.text);
       if(response.text != null ){
          _getBotResponse(response.text??"");
       }
       else {
         print("Response is empty");
         setState(() {
           isLoading = false;
         });
         Fluttertoast.showToast(
             msg: "Something went wrong",
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.BOTTOM,
             timeInSecForIosWeb: 1,
             backgroundColor: const Color(0xFF8B4AFA),
             textColor: Colors.white,
             fontSize: 16.0
         );
       }

     }
     catch(e){
       print("This is errror ${e.toString()}");
       setState(() {
         isLoading = false;
       });
       Fluttertoast.showToast(
           msg: "Something went wrong",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 1,
           backgroundColor: const Color(0xFF2DB2E1),
           textColor: Colors.white,
           fontSize: 16.0
       );
     }
  }

  void _getBotResponse(String userMessage) {
    isLoading = false;
    // Replace this code with actual API integration code
    ChatMessage message = ChatMessage(
      text: userMessage,
      isUserMessage: false,
    );
    setState(() {
      _messages.insert(0, message);
      chatData.add({"text":userMessage, "isUserMessage":false});
      prefs.setString("chatHistory", jsonEncode(chatData));
    });
  }

  final spinkit = const SpinKitWave(
    color: Colors.green,
    size: 50.0,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade200,
        title: const Text('Text Generation'),
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.home)),
        actions: [
          InkWell(
            onTap: () {
              _messages.clear();
              prefs.remove('chatHistory');
              setState(() {
              });
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: CustomButton(text: 'Clear Chat', color: Colors.red,),
            ),
          )

        ],
      ),

      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),

          isLoading? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: spinkit,
          ):const SizedBox(),

          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).dividerColor),
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 2, 10, 20),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                const InputDecoration.collapsed(hintText: "Write prompt"),
              ),
            ),

            IconButton(
              icon: const Icon(Icons.send, color: Colors.greenAccent,),
              onPressed: () => _textController.text.isNotEmpty?_handleSubmitted(_textController.text):null,
            ),
          ],
        ),
      ),
    );
  }
}