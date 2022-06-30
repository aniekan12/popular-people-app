import 'package:flutter/material.dart';
import 'package:popular_people_app/theme/popular_people_theme.dart';

class AppLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: PopularPeopleTheme.primary,
      ),
    );
  }
}
