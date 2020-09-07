import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

///好友动态-图片轮播
class MineFriends extends StatefulWidget {
  @override
  MineFriendsState createState() => MineFriendsState();
}

class MineFriendsState extends State<MineFriends> {
  // 声明一个list，存放image Widget
  List<Widget> imageList = List();

  @override
  void initState() {
    // TODO: implement initState
    imageList.add(Image.network(
      'https://pics1.baidu.com/feed/08f790529822720e6aa6f6410a5a4d43f31fabb3.jpeg?token=8fb7f32253df1531c46bfa67fe21cc75&s=EC836E99524B10E7113DF0C1030070D0',
      fit: BoxFit.fill,
    ));
    imageList.add(Image.network(
      'https://pics7.baidu.com/feed/9213b07eca80653884f4b8bfe74ce641ac348292.jpeg?token=f1c223af398963687fc1d41ca058526b&s=5A25A944114213E7D66D0917030040C9',
      fit: BoxFit.fill,
    ));
    imageList.add(Image.network(
      'https://pics4.baidu.com/feed/3b87e950352ac65caf49b4788863f51492138a80.jpeg?token=a7dd7eb878a6fbb92255c263cac17547&s=6BA00D89440B0AEF5180B9930100E081',
      fit: BoxFit.fill,
    ));
    imageList.add(Image.network(
      'https://pics7.baidu.com/feed/f11f3a292df5e0fea0f01a102ef173ad5fdf7249.jpeg?token=1908e5b736e045888160bf77893ac19e&s=EE924C83428A3EE50894C09303004093',
      fit: BoxFit.fill,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ListView(
        children: <Widget>[
          firstSwiperView(),

        ],
      ),
    );
  }

  ///实现android中ViewPager轮播的效果
  Widget firstSwiperView() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Swiper(
        itemCount: 4,
        itemBuilder: _swiperBuilder,
        pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.fromLTRB(0, 0, 15, 10),
          builder: DotSwiperPaginationBuilder(
              color: Colors.black54, activeColor: Colors.white),
        ),
        controller: SwiperController(),
        scrollDirection: Axis.horizontal,
        autoplay: true,
        //是否自动播放
        onTap: (index) => print('您点击了第$index'),
      ),
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (imageList[index]);
  }
}

