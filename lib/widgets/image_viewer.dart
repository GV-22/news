import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  final String imageUrl;
  final double size;
  
  const ImageViewer({
    required this.imageUrl,
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        height: size,
        width: double.infinity,
        errorWidget: (context, url, error) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/img_not_found.jpg',
              fit: BoxFit.cover,
              height: size,
              width: size,
            ),
          );
        },
        placeholder: (context, url) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/img_placeholder.jpg',
              fit: BoxFit.cover,
              height: size,
              width: size,
            ),
          );
        },
      ),
    );
  }
}
