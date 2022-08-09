import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:popular_people_app/managers/app_state_manager.dart';
import 'package:popular_people_app/models/popular_people_model.dart';
import 'package:popular_people_app/ui/base/base_view_model.dart';
import 'package:provider/provider.dart';

class PeopleViewModel extends BaseViewModel {
  final PagingController<int, PopularPeopleModel> popularPeopleController =
      PagingController(firstPageKey: 1);
  late AppStateManager appStateManager;
  void init(BuildContext ctx) {
    appContext = ctx;
    appStateManager = Provider.of<AppStateManager>(ctx, listen: false);

    popularPeopleController.addPageRequestListener(fetchPopularPeople);
  }

  Future fetchPopularPeople(int pageKey) async {
    try {
      bool resp = await appStateManager.fetchPopularPeople(page: pageKey);
      if (resp) {
        final isLastPage = (pageKey * 20) > appStateManager.totalNumberOfPeople;
        if (isLastPage) {
          popularPeopleController
              .appendLastPage(appStateManager.currentPopularPeople);
        } else {
          popularPeopleController.appendPage(
              appStateManager.currentPopularPeople, pageKey + 1);
        }
      } else {
        popularPeopleController.appendPage([], pageKey);
      }
    } catch (e) {
      print(e);
      popularPeopleController.error = e;
    }
  }
}
