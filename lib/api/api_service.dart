import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutterdemo/util/http_util.dart';


class ApiService {
//  static const base_url = 'https://test.nofetel.com/';
  static const base_url = 'https://1.nofetel.com/';
  ///登录
  static const login_url='VendingSystem/common/login';

  ///登录 无需要 验证码
  static const login_url2='VendingSystem/login';

  ///角色效验
  static const user_check_url='VendingSystem/app/home/getRoles';

  ///微信二维码获取设备id
  static const get_weChat_devCode_url='/VendingSystem/wxc/qr/getDevIdByQrCode?code=';

  ///效验设备 是否可用
  static const is_dev_url='/VendingSystem/dev/isBelongToLoginUser?needBind=true&devId=';

  ///设备信息 包括轮播图
  static const device_url = 'VendingSystem/front/dev/getInfo?devId=';

  ///商品列表
  static const shop_list_url = 'VendingSystem/front/item/getDevItemInfo?devId=';

  ///设备功能配置表
  static const model_config__url = 'VendingSystem/front/dev/getModelConfig?model=';

  ///补货开锁 蓝牙设备
  static const open_dev_url = 'VendingSystem/app/openN750Lock?devId=';

  ///获取单个开柜秘钥(仅限蓝牙设备)
  static const get_ble_key_url = 'VendingSystem/app/devs/payCode?useOrigin=true&forward=now&devId=';

  ///设置缺货
  static const set_no_shop_url = '/VendingSystem/dev/editCellItemAmount';

  ///更换商品
  static const update_shop_url = 'VendingSystem/app/devs/replaceItem';

  ///获取设备电量
  static const get_power_url = 'VendingSystem/front/dev/editDevVoltage?devId=';

  ///更换的所有商品列表
  static const product_list_url = 'VendingSystem/app/devs/items?devId=';

  ///一键补货 解锁
  static const get_ble_key_one_url = 'VendingSystem/front/repair/getDevOldKey?useOrigin=true&forward=now&devId=';

  ///重置设备秘钥
  static const update_dev_key_url = 'VendingSystem/app/appCreateInitialCode?devId=';

  ///保存初始化秘钥
  static const add_first_key_url = 'VendingSystem/bindingDev/saveInitialCode?devId=';
  ///保存单个开柜成功秘钥
  static const add_key_url = 'VendingSystem/front/smallWxpay/savePayCode?devId=';

  /// ----------------------------------------------------------------------
  static getData(String url,
      {data,Function success, Function fail, Function complete}) async {
    try {
      var response = await HttpUtil().get(url,data: data);
      if (response.statusCode == 200) {
        var result = json.decode(response.toString());
        success(result);
      } else {
        throw Exception('"Request failed with status: ${response.statusCode}"');
      }
    } catch (e) {
      fail(e);
    } finally {
      if (complete != null) {
        complete();
      }
    }
  }

  static postData(String url,
      {data,query,Options options,Function success, Function fail, Function complete}) async {
    try {
      var response = await HttpUtil().post(url,data: data,query:query,options: options);
      if (response.statusCode == 200) {
        var result = json.decode(response.toString());
        success(result);
      } else {
        throw Exception('"Request failed with status: ${response.statusCode}"');
      }
    } catch (e) {
      fail(e);
    } finally {
      if (complete != null) {
        complete();
      }
    }
  }
}
