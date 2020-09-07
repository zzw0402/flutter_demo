import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'listview.dart';
import 'swiper.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var tabTitle = [
    '积分排行',
    '积分记录',
  ];

  List<Widget> _imageList = List();

  @override
  void initState() {
    _imageList.add(Image.network(
      'https://pics1.baidu.com/feed/08f790529822720e6aa6f6410a5a4d43f31fabb3.jpeg?token=8fb7f32253df1531c46bfa67fe21cc75&s=EC836E99524B10E7113DF0C1030070D0',
      fit: BoxFit.fill,
    ));
    _imageList.add(Image.network(
      'https://pics7.baidu.com/feed/9213b07eca80653884f4b8bfe74ce641ac348292.jpeg?token=f1c223af398963687fc1d41ca058526b&s=5A25A944114213E7D66D0917030040C9',
      fit: BoxFit.fill,
    ));
    _imageList.add(Image.network(
      'https://pics4.baidu.com/feed/3b87e950352ac65caf49b4788863f51492138a80.jpeg?token=a7dd7eb878a6fbb92255c263cac17547&s=6BA00D89440B0AEF5180B9930100E081',
      fit: BoxFit.fill,
    ));
    _imageList.add(Image.network(
      'https://pics7.baidu.com/feed/f11f3a292df5e0fea0f01a102ef173ad5fdf7249.jpeg?token=1908e5b736e045888160bf77893ac19e&s=EE924C83428A3EE50894C09303004093',
      fit: BoxFit.fill,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250.0,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('画画的beibei'),
              background: Container(
                child: Swiper(
                  itemCount: 3,
                  autoplay: true,
                  itemBuilder: (BuildContext context,int idnex){
                    return Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        '_imageList',
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                ),
              ),
            ), 
          ),
          SliverToBoxAdapter(
              child: new TabBar(
                tabs: tabTitle.map((f) => Tab(text: f)).toList(),
                indicatorColor: Colors.red,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.red,
                ),
            ),
          SliverFillRemaining(
              child: TabBarView(
                children: tabTitle
                    .map((s) => ListView.builder(
                          itemBuilder: (context, int) => IndexPage(),
                          itemCount: 50,
                        ))
                    .toList(),
                ),
              )
        ],
      ),
      
    );
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;

  const SliverTabBarDelegate(this.widget, {this.color})
      : assert(widget != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: widget,
      color: color,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}


