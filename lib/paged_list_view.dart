import 'package:flutter/material.dart';

typedef PagedWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class PagedListView<T> extends StatelessWidget {

  final PagedWidgetBuilder<T> itemBuilder;
  final List<T> items;
  final bool isLoading;
  final _scrollController = ScrollController();
  final Function onNewLoad;

  PagedListView({
    @required this.items,
    @required this.itemBuilder,
    @required this.isLoading,
    @required this.onNewLoad,
  });

  @override
  Widget build(BuildContext context) {

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // this condition will be execute when you are in bottom of the list
        // then callback function will be trigger which we pass through parameter
        // will be execute for loading more new data
        this.onNewLoad();
      }
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          flex: 1,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return itemBuilder(context, items[index]);
            },
          ),
        ),
        isLoading ? Container(
          height: 50,
          child: Center(
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: RefreshProgressIndicator(),
                  ),
                  WidgetSpan(
                    child: SizedBox(
                      width: 10,
                    ),
                  ),
                  TextSpan(
                      text: "Loading",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black45,
                      )
                  ),
                ],
              ),
            ),
          ),
        ) : SizedBox(),
      ],
    );
  }
}
