import 'dart:async';

import 'package:flutter/material.dart';

import 'popular_people.dart';

void main() async {
  await runZonedGuarded(() async {
    runApp(const PopularPeople());
  }, ((error, stack) => {}));
}
