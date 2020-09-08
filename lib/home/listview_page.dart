import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';


class ListViewPage extends StatefulWidget {
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                RaisedButton(
                  onPressed: (){},
                  child: Text("本周排名"),
                  textColor: Colors.black,
                  splashColor: Colors.red,
                  highlightColor: Colors.blue,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.white,
                  disabledElevation: 4,
                  shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                ),
              SizedBox(
                width: 20.0,
              ),
              RaisedButton(
                onPressed: (){},
                child: Text("本周排名"),
                textColor: Colors.black,
                splashColor: Colors.red,
                highlightColor: Colors.blue,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.white,
                disabledElevation: 4,
                shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(50))
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              RaisedButton(
                onPressed: (){},
                child: Text("本周排名"),
                textColor: Colors.black,
                splashColor: Colors.red,
                highlightColor: Colors.blue,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.white,
                disabledElevation: 4,
                shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(50))
                ),
              ),
            ],
          ),
          ListViewDemo(),
        ],
      ),

    );
  }
}
class ListViewDemo extends StatefulWidget {
  @override
  _ListViewDemoState createState() => _ListViewDemoState();
}

class _ListViewDemoState extends State<ListViewDemo> {
  int _itemCount;
  final data = <Color>[
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
  ];

  Widget getRefreshList() {
    return SafeArea(
        child:  Refresh(
          onFooterRefresh: onFooterRefresh,
          onHeaderRefresh: onHeaderRefresh,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                key: Key(index.toString()),
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "item:" + (index + 1).toString(),
                  style: TextStyle(fontSize: 14.0),
                ),
              );
            },
            itemCount: _itemCount,
          ),
        ));
  }

  //下拉
  Future<Null> onFooterRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        _itemCount += 10;
      });
    });
  }
//下拉
  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        _itemCount = 10;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child:  ListView(
        physics:NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 5),
        children: data
            .map((color) => Container(
          alignment: Alignment.center,
          width: 100,
          height: 50,
          color: color,
          child: Text(
            colorString(color),
            style: TextStyle(color: Colors.white, shadows: [
              Shadow(
                  color: Colors.black,
                  offset: Offset(.5, .5),
                  blurRadius: 2)
            ]),
          ),
        ))
            .toList(),
      ),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
