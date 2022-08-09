import 'package:flutter/material.dart';
import 'package:popular_people_app/utilities/utils/constants.dart';

class LargeNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? size;

  const LargeNetworkImage({required this.imageUrl, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: imageUrl.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "$largeImagesBaseUrl$imageUrl",
                ),
              )
            : Image.network("https://via.placeholder.com/150"));
  }
}
