import 'package:flutter/material.dart';
import 'package:popular_people_app/models/popular_people_model.dart';
import 'package:popular_people_app/nav/pages.dart';
import 'package:popular_people_app/theme/popular_people_theme.dart';
import 'package:popular_people_app/ui/base/base_view.dart';
import 'package:popular_people_app/ui/views/people/details/view_model.dart';
import 'package:popular_people_app/utilities/utils/app_bar.dart';
import 'package:popular_people_app/utilities/utils/app_button.dart';
import 'package:popular_people_app/utilities/utils/constants.dart';

import '../../../../utilities/utils/large_network_image.dart';

class PopularPeoplesDetails extends StatefulWidget {
  final PopularPeopleModel popularPeopleModel;
  static MaterialPage page(PopularPeopleModel popularPeopleModel) {
    return MaterialPage(
        key: ValueKey(PopularPeoplePages.peoplesDetailsPath),
        name: PopularPeoplePages.peoplesDetailsPath,
        child: PopularPeoplesDetails(popularPeopleModel: popularPeopleModel));
  }

  const PopularPeoplesDetails({Key? key, required this.popularPeopleModel})
      : super(key: key);

  @override
  State<PopularPeoplesDetails> createState() => _PopularPeoplesDetailsState();
}

class _PopularPeoplesDetailsState extends State<PopularPeoplesDetails> {
  @override
  Widget build(BuildContext context) {
    return BaseView<PopularPeoplesDetailsViewModel>(
      model: PopularPeoplesDetailsViewModel(),
      onModelReady: (model) => model.onInit(context),
      builder: (context, model, _) => Scaffold(
        appBar: PopularPeopleAppBar.show(
          title: '${widget.popularPeopleModel.name}s Details',
          showBack: true,
          automaticallyImplyLeading: true,
          key: const Key('popular_people_appbar'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              LargeNetworkImage(
                imageUrl: widget.popularPeopleModel.profilePath!,
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Known for',
                          style: PopularPeopleTheme.appTextTheme.headline2),
                      Text(widget.popularPeopleModel.knownForDepartment!,
                          style: PopularPeopleTheme.appTextTheme.bodyText2),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gender',
                          style: PopularPeopleTheme.appTextTheme.headline2),
                      Text(
                          widget.popularPeopleModel.gender == 1
                              ? 'female'
                              : 'male',
                          style: PopularPeopleTheme.appTextTheme.bodyText2),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Popularity',
                          style: PopularPeopleTheme.appTextTheme.headline2),
                      Text(widget.popularPeopleModel.popularity.toString(),
                          style: PopularPeopleTheme.appTextTheme.bodyText2),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              AppButton(
                buttonText: "Save Image",
                onTap: () async => await model.savePopularPersonsImageToGallery(
                    "$largeImagesBaseUrl${widget.popularPeopleModel.profilePath}"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
