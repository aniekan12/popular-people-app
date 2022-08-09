import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:popular_people_app/ui/base/base_view_model.dart';

class PopularPeoplesDetailsViewModel extends BaseViewModel {
  onInit(BuildContext ctx) {
    appContext = ctx;
  }

  savePopularPersonsImageToGallery(String imageUrl) async {
    String path = imageUrl;
    GallerySaver.saveImage(path).then((bool? success) {
      notifyListeners();
      if (success!) {}
    });
  }
}
