import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:popular_people_app/models/popular_people_model.dart';
import 'package:popular_people_app/nav/pages.dart';
import 'package:popular_people_app/ui/base/base_view.dart';
import 'package:popular_people_app/ui/views/people/view_model.dart';
import 'package:popular_people_app/ui/views/people/widgets/popular_peoples_card.dart';

class PeopleView extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      child: const PeopleView(),
      key: ValueKey(PopularPeoplePages.peoplePath),
      name: PopularPeoplePages.peoplePath,
    );
  }

  const PeopleView({Key? key}) : super(key: key);

  @override
  State<PeopleView> createState() => _PeopleViewState();
}

class _PeopleViewState extends State<PeopleView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<PeopleViewModel>(
      model: PeopleViewModel(),
      onModelReady: (model) => model.init(context),
      builder: (context, model, _) => Scaffold(
        body: Column(
          key: Key('peoples_view_column'),
          children: [
            Expanded(
              child: PagedListView(
                key: const Key('peoples_view_paged_listview'),
                pagingController: model.popularPeopleController,
                builderDelegate: PagedChildBuilderDelegate<PopularPeopleModel>(
                  itemBuilder: (BuildContext context, item, int index) =>
                      PopularPeoplesCard(popularPeopleModel: item),
                  noItemsFoundIndicatorBuilder: (_) =>
                      const Center(child: Text("No popular person found")),
                  noMoreItemsIndicatorBuilder: (_) => const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("No more popular people found"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
