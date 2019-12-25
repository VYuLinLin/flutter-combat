import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewRoute extends StatefulWidget {
  @override
  _ListViewState createState() => _ListViewState();
}

class _ListViewState extends State<ListViewRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('listView'),),
      body: Column(
        children: <Widget>[
          ListTile(title: Text('滚动列表-表头', style: TextStyle(color: Colors.blue)),),
          Expanded(
            child: ListView.builder(
              itemCount: 100,
              itemExtent: 50,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(title: Text('$index'),);
              },
            ),
          )
        ],
      ),
    );
  }
}

class ListViewSeparatedRoute extends StatelessWidget {
  Widget devider1 = Divider(color: Colors.blue);
  Widget devider2 = Divider(color: Colors.red);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListView.separated'),),
      body: ListView.separated(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(title: Text('$index'),);
        },
        separatorBuilder: (BuildContext context, int index) {
          return index % 2 == 0 ? devider1 : devider2;
        },
      ),
    );
  }
}