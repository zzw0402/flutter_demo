import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'listview_page.dart';


class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var tabTitle = [
    '积分排行',
    '积分记录',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTitle.length,
        child: Scaffold(
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
                    itemBuilder: (BuildContext context,int index){
                      return Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                          'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
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
                          itemBuilder: (context, int) => ListViewPage(),
                          itemCount: 50,
                        ))
                    .toList(),
                ),
              )
          ],
        ),
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


