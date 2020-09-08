import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';//contentType
import '../config/service_url.dart';
//获取首页主题内容
Future getHomePageContent() async {
  try {
    print('开始获取首页内容');
    Response homeRes;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded") as String;
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    homeRes = await dio.post(servicePath['homePageContent'], data: formData);
    if (homeRes.statusCode == 200) {
      return homeRes.data;
    } else {
      return Exception('接口异常');
    }
  } catch (e) {
    return print('ERROR:==========>${e}');
  }
}