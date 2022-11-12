import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewScreen extends StatelessWidget {
  final File imageFile;
  const ImageViewScreen({Key? key, required this.imageFile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: FileImage(imageFile),
    );
  }
}