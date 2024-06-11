import 'package:flutter/material.dart';
import 'package:google_ai/components/button.dart';
import 'package:google_ai/components/custom_carousel.dart';
import 'package:google_ai/screens/chat/chat.dart';
import 'package:google_ai/screens/image_text_input/image_text_input.dart';
import 'package:google_ai/screens/text_generation/text_generation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isGemini = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade200,
        title: const Text('Google Generative AI'),
        actions:  [
          PopupMenuButton<String>(
            color: Colors.lightBlue,
            icon: Icon(Icons.more_vert),
            onSelected: (String result) {
              if (result == 'Gemini') {
               setState(() {
               isGemini = true;
               });
              } else if (result == 'more') {
                setState(() {
                  isGemini = false;
                });
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(

                value: 'Gemini',
                child: Text('Gemini', style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white
                ),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'more',
                child: Text('More',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white
                  ),),
              ),
            ],
          ),

        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          isGemini?Column(
            children: [
              InkWell(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>  Chat() ));},
                  child:  CustomButton(text: "AI Chat with History", color: Colors.deepPurpleAccent, height: 40, widgth: 300, fontSize: 20,)),
              const SizedBox(height: 20),
              InkWell(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>  TextGeneration() ));},
                  child:  CustomButton(text: "Generate Text using Prompt", color: Colors.greenAccent, height: 40, widgth: 300, fontSize: 19,)),
              const SizedBox(height: 20),
              InkWell(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>  ImageTextInput() ));},
                  child:  CustomButton(text: "Text and image as input", color: Colors.orange, height: 40, widgth: 300, fontSize: 20,)),
            ],
          )
              :Column(
            children: [
              InkWell(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>  Chat() ));},
                  child:  CustomButton(text: "Face Detector", color: Colors.deepPurpleAccent, height: 40, widgth: 300, fontSize: 20,)),
              const SizedBox(height: 20),
              InkWell(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>  TextGeneration() ));},
                  child:  CustomButton(text: "Object Detector", color: Colors.greenAccent, height: 40, widgth: 300, fontSize: 19,)),
              const SizedBox(height: 20),
            ],
          ),
          const SizedBox(height: 60),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text("Introduction to Google Gemini AI. Like ChatGPT or Hanooman, Google Gemini AI is designed to understand different information modes, such as text, images, audio, video, computer code, and more. In addition, it's excellent at several coding tasks, such as translating Code between languages."),
          ),

          const SizedBox(height: 60,),
          CarouselScreen(),

        ],
      ),
    );
  }
}