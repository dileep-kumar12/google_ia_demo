import 'package:flutter/material.dart';
import 'package:google_ai/components/button.dart';
import 'package:google_ai/components/custom_carousel.dart';
import 'package:google_ai/screens/chat/chat.dart';
import 'package:google_ai/screens/image_text_input/image_text_input.dart';
import 'package:google_ai/screens/text_generation/text_generation.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade200,
        title: const Text('Google Generative AI'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
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