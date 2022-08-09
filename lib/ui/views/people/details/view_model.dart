import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:popular_people_app/ui/base/base_view_model.dart';
import 'package:popular_people_app/utilities/utils/flush_bar.dart';

class PopularPeoplesDetailsViewModel extends BaseViewModel {
  onInit(BuildContext ctx) {
    appContext = ctx;
  }

  savePopularPersonsImageToGallery(String imageUrl) async {
    GallerySaver.saveImage(imageUrl).then((bool? success) {
      notifyListeners();
      if (success!) {
        ACFlushBar.success(context: appContext, message: 'Image Saved!');
      } else {
        ACFlushBar.error(context: appContext);
      }
    });
  }
}
