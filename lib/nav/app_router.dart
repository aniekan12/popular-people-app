import 'package:flutter/cupertino.dart';
import 'package:popular_people_app/managers/app_state_manager.dart';
import 'package:popular_people_app/nav/pages.dart';
import 'package:popular_people_app/route.dart';
import 'package:popular_people_app/ui/views/people/details/view.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  AppRouter({
    required this.appStateManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
  }
  final AppStateManager appStateManager;
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePop,
      pages: [
        if (appStateManager.isInitialized) PeopleView.page(),
        if (!appStateManager.isInitialized) PeopleView.page(),
        if (appStateManager.popularPeopleModel != null)
          PopularPeoplesDetails.page(appStateManager.popularPeopleModel!)
      ],
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    return;
  }

  bool _handlePop(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    if (route.settings.name == PopularPeoplePages.peoplePath)
      appStateManager.closeApp();

    return true;
  }
}
