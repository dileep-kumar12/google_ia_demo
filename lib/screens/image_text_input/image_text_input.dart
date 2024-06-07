
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_ai/components/button.dart';
import 'package:google_ai/components/chat_message.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class ImageTextInput extends StatefulWidget {
  @override
  _ImageTextInputState createState() => _ImageTextInputState();
}

class _ImageTextInputState extends State<ImageTextInput> {
  late final GenerativeModel model;
  bool isLoading = false;
  XFile? _image;


  @override
  void initState() {
    model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: "AIzaSyCt5G3ZJczijZkiX1btqa0nwAK6BRHM1a8",
    );
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

    /// this code user for image and text input
     final prompt = TextPart(text);
     var imageByte = await _image?.readAsBytes();
     var imageMimeType = "image/jpg";
     final imageParts = [  DataPart(imageMimeType, imageByte!) ];

     final response = await model.generateContent([
       Content.multi(
           [prompt, ...imageParts]
       )
     ]);

    _getBotResponse(response.text??"");
    _image = null;
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

  Future<void> _pickImage() async {
    print("picke image functino called");
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });

    }
  }

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
          _image != null ? Container(
            padding: EdgeInsets.only(right: 10),
               alignment: Alignment.centerRight,
              child: Image.file(File(_image!.path), height: 100, width: 100,)
          ):const SizedBox(),
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
              icon: const Icon(Icons.add_photo_alternate_rounded, color: Colors.greenAccent,),
              onPressed: () => _pickImage(),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.greenAccent,),
              onPressed: () => _image != null?_handleSubmitted(_textController.text):print("please select picture"),
            ),
          ],
        ),
      ),
    );
  }
}