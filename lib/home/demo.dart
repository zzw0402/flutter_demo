import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RefreshPage extends StatefulWidget {
  RefreshPage({Key key}) : super(key: key);

  _RefreshPageState createState() => _RefreshPageState();
}

class _RefreshPageState extends State<RefreshPage> {
  List _dataSources = List();
  ScrollController _scrollController = ScrollController();
  int _page = 1; //请求第几页数据，用于分页请求数据
  bool _haveMore = true; //是否还有更多的数据可以请求

  //网络请求数据
  _requestData() async {
    String urlStr =
        "http://www.phonegap100.com/appapi.php?a=getPortalList&catid=20&page=$_page";
    var response = await Dio().get(urlStr);
    if (response.statusCode == 200) {
      setState(() {
        List resultList = jsonDecode(response.data)["result"];
        if (this._page == 1) {
          //第一次加载或者下拉加载
          this._dataSources = resultList;
        } else {
          //上拉刷新（将新加载的数据拼接到原来的数据数组中）
          this._dataSources.addAll(resultList);
        }
        this._page++; //每请求成功一次，page都要加1
        /**
         * 这里根据当前返回的数组长度是否小于pagesize来判断接下来是否还有更多数据
         * 这里的pagesize是20
         */
        if (resultList.length < 20) {
          this._haveMore = false;
        }
      });
      // print(this._dataSources);
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  }

  //下拉刷新
  /**
   * 注意，这里只是给大家演示一下下拉刷新组件，所以下拉刷新的逻辑写的比较简单
   * 如果真的在项目中使用的话，大家还是思考全面，不要简单拷贝如下代码！
   */
  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2), () {
      print("请求数据完成");
      this._page = 1;
      _requestData();
    });
  }

  @override
  void initState() {
    super.initState();
    //页面一加载就执行网络请求
    this._requestData();

    //监听滚动条的滚动事件
    _scrollController.addListener(() {
      print(_scrollController.position.pixels); //滚动的距离
      print(_scrollController.position.maxScrollExtent); //最大滚动范围
      //当滚动到最底部的时候，加载新的数据
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //当还有更多数据的时候才会进行加载新数据
        if (this._haveMore) {
          this._requestData();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("refreshDemo")),
      body: _dataSources.length == 0
          ? _loadMoreWidget()
          : RefreshIndicator(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: this._dataSources.length,
                itemBuilder: (context, index) {
                  /**
                   * 当当前index等于数据源数据的长度减1的时候，
                   * 说明当前的ListTile是最后一个ListTile，
                   * 此时需要上拉加载新的数据，因此要在最底部显示一个加载中的圈圈
                   */
                  if (index == this._dataSources.length - 1) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                            title: Text(this._dataSources[index]["title"],
                                maxLines: 1)),
                        Divider(),
                        _loadMoreWidget()
                      ],
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        ListTile(
                            title: Text(this._dataSources[index]["title"],
                                maxLines: 1)),
                        Divider()
                      ],
                    );
                  }
                },
              ),
              onRefresh: _refreshData,
            ),
    );
  }

  //加载中的圈圈
  Widget _loadMoreWidget() {
    if (this._haveMore) {
      //还有更多数据可以加载
      return Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("加载中......"),
              CircularProgressIndicator(
                strokeWidth: 1,
              )
            ],
          ),
        ),
      );
    } else {
      //当没有更多数据可以加载的时候，
      return Center(
        child: Text("我是有底线的"),
      );
    }
  }
}