import 'package:appbar_search/data.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LiveSearch(),
    );
  }
}

class LiveSearch extends StatefulWidget {
  @override
  _LiveSearchState createState() => _LiveSearchState();
}

class _LiveSearchState extends State<LiveSearch> {
  TextEditingController _controllerSearch = TextEditingController();
  Widget searchTextField;
  bool search = false;
  Color _bgColor = Colors.blue;
  List list = List<String>();

  @override
  void initState() {
    super.initState();
    list.addAll(items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _bgColor,
        title: searchTextField,
        actions: <Widget>[
          (!search)
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      searchTextField = appSearch(context);
                      _bgColor = Colors.white;
                      search = !search;
                    });
                  })
              : IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      list.clear();
                      list.addAll(items);
                      _controllerSearch.clear();
                    });
                  })
        ],
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, int index) {
          return ListTile(
            title: Text(
              list[index],
              style: TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }

  Widget appSearch(BuildContext context) {
    return TextField(
      controller: _controllerSearch,
      style: TextStyle(color: Colors.black, fontSize: 18),
      decoration: InputDecoration(
          icon: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  searchTextField = Text("List Users");
                  search = !search;
                  _bgColor = Colors.blue;
                  _controllerSearch.clear();
                  list.clear();
                  list.addAll(items);
                });
              }),
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.grey)),
      onChanged: (value) {
        _searchName(value);
      },
    );
  }

  _searchName(String name) {
    if (name.isNotEmpty) {
      setState(() {
        list.clear();
        items.forEach((item) {
          if (item.toLowerCase().contains(name.toLowerCase())) {
            list.add(item);
          }
        });
      });
    } else {
      setState(() {
        list.clear();
        list.addAll(items);
      });
    }
  }
}
