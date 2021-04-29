import 'package:flutter/material.dart';
import 'package:flutter_pagination/paged_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Pagination'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> items;
  bool isLoading = false;


  @override
  void initState() {
    items = List.generate(20, (index) => "Item $index");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: PagedListView<String>(
          items: items,
          // 'isLoading' will control the visibility of the loader
          isLoading: isLoading,
          itemBuilder: (context, item) {
            return ListTile(
              title: Text(
                item,
              ),
            );
          },
          itemPerPage: 10,
          totalSize: 24,
          totalPage: 3,
          onNewLoad: (items, nextPage) {
            setState(() {
              // change the state of the loading
              // for making the loader visible
              isLoading = true;
              // now the loading is visible
              // it's time to fetch new data
              fetchNewData();
            });
          },
        ),
      ),
    );
  }

  void fetchNewData() {
    Future.delayed(Duration(seconds: 5,), (){
      setState(() {
        items.addAll(List.generate(20, (index) => "Item $index"));
        // after fetching and adding more data, change the loading state
        isLoading = false;
      });
    });
  }
}
