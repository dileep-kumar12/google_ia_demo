
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_ai/components/button.dart';
import 'package:google_ai/components/chat_message.dart';
import 'package:google_generative_ai/google_generative_ai.dart';


class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late final GenerativeModel model;
  bool isLoading = false;
  late ChatSession chat;


  @override
  void initState() {
    model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: "AIzaSyCt5G3ZJczijZkiX1btqa0nwAK6BRHM1a8",
      generationConfig: GenerationConfig(temperature: 0.6),
    );
    /// initialized chat
     chat = model.startChat();
    super.initState();
  }

  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  Future<void> _handleSubmitted(String text) async {
    isLoading = true;
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      isUserMessage: true,
    );
    setState(() {
      _messages.insert(0, message);
    });


    final content = Content.text(text);
    final response = await chat.sendMessage(content);
    print(response.text);
    _getBotResponse(response.text??"");
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
              setState(() {
                _messages.clear();
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
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}