// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:popular_people_app/utilities/utils/app_loading_indicator.dart';

abstract class BaseLoadMore<T extends StatefulWidget> extends State<T> {
  int currentPage = 1;

  int? lastPage;

  bool get hasNextPage => currentPage <= lastPage!;

  /// Widget to show when the list gotten is empty
  Widget emptyListWidget();

  /// Assign parsed list gotten from api call.
  List get data;

  /// Parse dataItem to any suitable class
  /// Returns a widget to be displayed in the ListView
  Widget listTile(var dataItem);

  /// Function would contain the api call
  /// [lastPage] would be gotten from the response
  Future<bool> loadFunction();

  // First time api call is made, show loading indicator at the center
  ValueNotifier<bool> _initialLoad = ValueNotifier<bool>(false);

  // Trigger when initialLoad has an error & currentPage is 1
  ValueNotifier<bool> _initialLoadHasError = ValueNotifier<bool>(false);

  Future<void> refresh() async {
    _initialLoad.value = true;
    if (_initialLoadHasError.value) _initialLoadHasError.value = false;
    currentPage = 1;
    lastPage = null;
    loadFunction().then((value) {
      _initialLoad.value = false;
      currentPage++;
      return value;
    });
    // refresh occurs when currentPage = 1
  }

  @override
  void initState() {
    super.initState();
    initLoad();
  }

  void initLoad() {
    _initialLoad.value = true;
    loadFunction.call().then((value) {
      _initialLoad.value = false;
    });
  }

  @override
  void dispose() {
    _initialLoad.dispose();
    _initialLoadHasError.dispose();
    super.dispose();
  }

  void onError() async {
    if (currentPage == 1 && lastPage == null) {
      // error occurred during initial load
      _initialLoadHasError.value = true;
    } else {
      _initialLoadHasError.value = false;
    }
  }

  /// Widget to build before the list
  Widget widgetBeforeList() => SizedBox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widgetBeforeList() != null) widgetBeforeList(),
            Expanded(
                child: ValueListenableBuilder<bool>(
              valueListenable: _initialLoad,
              builder: (context, initialLoad, child) {
                if (initialLoad) return AppLoadingIndicator();

                return ValueListenableBuilder<bool>(
                    valueListenable: _initialLoadHasError,
                    builder: (context, hasError, child) {
                      if (hasError) return errorWidget();

                      if (data.isEmpty) {
                        return emptyListWidget();
                      }

                      return LoadMore(
                        onLoadMore: () => loadFunction(),
                        child: ListView.separated(
                          padding: EdgeInsets.only(bottom: 160),
                          itemCount: data.length,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              listTile(data.elementAt(index)),
                          separatorBuilder: (context, index) => separator,
                        ),
                        delegate: LoadMoreDelg(),
                        isFinish: !hasNextPage,
                      );
                    });
              },
            ))
          ],
        ),
      ),
    );
  }

  Widget get separator => SizedBox(
        height: 20,
      );

  Widget errorWidget() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("An error occurred while loading"),
                const SizedBox(
                  height: 5,
                ),
                IconButton(
                    onPressed: () {
                      refresh();
                    },
                    icon: Icon(Icons.refresh))
              ],
            ),
          ),
        );
      },
    );
  }
}

class LoadMoreDelg extends LoadMoreDelegate {
  const LoadMoreDelg();

  @override
  Widget buildChild(LoadMoreStatus status,
      {builder = DefaultLoadMoreTextBuilder.chinese}) {
    switch (status) {
      case LoadMoreStatus.fail:
        return Text("An error occurred.");

      case LoadMoreStatus.idle:
        return SizedBox();

      case LoadMoreStatus.loading:
        return Center(
          child: CircularProgressIndicator(),
        );

      case LoadMoreStatus.nomore:
        return SizedBox();

      default:
        return SizedBox();
    }
  }
}
