import 'package:flutter/material.dart';

import 'constants.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? size;

  const AppNetworkImage({required this.imageUrl, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: imageUrl.isNotEmpty
            ? Image.network(
                "$smallImagesBaseUrl$imageUrl",
                height: 150,
              )
            : Image.network("https://via.placeholder.com/150"));
  }
}
