import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  String profileUrl;
  CustomAvatar({super.key, required this.profileUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 15,
        backgroundImage: CachedNetworkImageProvider(
          profileUrl,
        ),
      ),
    );
  }
}