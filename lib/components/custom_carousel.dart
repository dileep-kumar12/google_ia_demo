import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselScreen extends StatelessWidget {
   CarouselScreen({super.key});

  final List<String> imageUrls = [
    'https://www.onlandscape.co.uk/wp-content/uploads/2023/02/timparkin_collage_composite_landscape_c209c0c0-18fd-4919-8efd-744fb451e9b8.jpg',
    'https://img.freepik.com/premium-photo/tree-earth_926199-9195.jpg',
    'https://img.freepik.com/premium-photo/single-tree-field-standing-protect-other-trees-nearby-it_27550-4222.jpg',
    'https://cdn.pixabay.com/photo/2023/02/13/16/14/ai-generated-7787714_1280.jpg',
    'https://img.freepik.com/premium-photo/paper-cut-world-environment-earth-day-concep-happy-earth-day-april-22-save-earth-environmental-protection-generate-ai_39665-1634.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: imageUrls.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
