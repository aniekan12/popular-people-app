import 'package:flutter/material.dart';
import 'package:popular_people_app/managers/app_state_manager.dart';
import 'package:popular_people_app/models/popular_people_model.dart';
import 'package:popular_people_app/theme/popular_people_theme.dart';
import 'package:popular_people_app/utilities/utils/network_image.dart';
import 'package:provider/provider.dart';

class PopularPeoplesCard extends StatelessWidget {
  final PopularPeopleModel popularPeopleModel;
  const PopularPeoplesCard({Key? key, required this.popularPeopleModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<AppStateManager>(context, listen: false)
            .popularPeopleModel = popularPeopleModel;
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 30,
          child: Row(
            children: [
              Column(
                children: [
                  AppNetworkImage(imageUrl: popularPeopleModel.profilePath!),
                ],
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  popularPeopleModel.name!,
                  style: PopularPeopleTheme.appTextTheme.headline2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
