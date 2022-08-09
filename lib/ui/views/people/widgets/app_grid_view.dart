import 'package:flutter/material.dart';

Widget gridView({
  required int itemCount,
  required Widget Function(BuildContext context, int index) itemBuilder,
  EdgeInsets? padding,
}) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 14,
        childAspectRatio: 1),
    itemBuilder: itemBuilder,
    itemCount: itemCount,
    padding: padding,
    physics: ScrollPhysics(),
  );
}
