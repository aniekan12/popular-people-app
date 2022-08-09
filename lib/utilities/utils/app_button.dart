import 'package:flutter/material.dart';
import 'package:popular_people_app/theme/popular_people_theme.dart';

class AppButton extends StatefulWidget {
  final Function onTap;
  final String buttonText;
  final bool isLoading;
  final bool isPrimary;
  final bool isActive;
  const AppButton(
      {Key? key,
      required this.onTap,
      required this.buttonText,
      this.isLoading = false,
      this.isPrimary = true,
      this.isActive = true})
      : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          if (widget.isActive) {
            widget.onTap();
          }
        },
        splashColor: PopularPeopleTheme.primary,
        child: Container(
          height: 50,
          width: 300,
          decoration: BoxDecoration(
            color: widget.isActive
                ? widget.isPrimary
                    ? PopularPeopleTheme.primary
                    : themeData.backgroundColor
                : Colors.grey,
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.isLoading ? 'processing...' : widget.buttonText,
            style: PopularPeopleTheme.appTextTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
