// lib/views/widgets/image_widget.dart
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;

  const ImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return const SizedBox();
    }

    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          imageUrl,
          height: 400,
          fit: BoxFit.cover,
        ),
      ),
      onTap: () {
        showGeneralDialog(
          context: context,
          transitionDuration: const Duration(milliseconds: 300),
          barrierDismissible: true,
          barrierLabel: '',
          pageBuilder: (context, animation1, animation2) {
            return Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SingleChildScrollView(
                    child: InteractiveViewer(
                      minScale: 0.1,
                      maxScale: 5,
                      child: Image.network(imageUrl),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
