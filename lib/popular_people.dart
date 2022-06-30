import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:popular_people_app/managers/app_state_manager.dart';
import 'package:popular_people_app/managers/provider_setup.dart';
import 'package:provider/provider.dart';

import 'nav/app_router.dart';

class PopularPeople extends StatefulWidget {
  const PopularPeople({Key? key}) : super(key: key);

  @override
  State<PopularPeople> createState() => _PopularPeopleState();
}

class _PopularPeopleState extends State<PopularPeople> {
  final _appStateManager = AppStateManager();
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(appStateManager: _appStateManager);
    providers
        .add(ChangeNotifierProvider(create: (context) => _appStateManager));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<AppStateManager>(
        builder: (context, appManager, child) {
          return MaterialApp(
            home: Router(
              routerDelegate: _appRouter,
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),
          );
        },
      ),
    );
  }
}
