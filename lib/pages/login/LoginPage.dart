import 'package:flutter/material.dart';
import 'package:flutterdemo/api/api_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //焦点
  FocusNode _focusNodeUserName = new FocusNode();
  FocusNode _focusNodePassWord = new FocusNode();
  FocusNode _focusNodeKey = new FocusNode();

  //用户名输入控制器，监听用户名输入框操作
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _userPassWordController = new TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  var _password = ''; //用户名
  var _username = ''; //密码
//  var _keycode = '';  //验证码
//  static var _randomStr =
//      DateTime.now().millisecondsSinceEpoch.toString(); //时间戳
  var _isShowPad = false;  //是否显示密码
  var _isShowClear = false; //是否显示输入框尾部的清除按钮
//  var imageUrl = Constant.keyUrl + "_randomStr";

  @override
  void initState() {
    // TODO: implement initState
    //设置焦点监听
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);
//    _focusNodeKey.addListener(_focusNodeListener);
    //监听用户名输入框的输入改变
    _userNameController.addListener(() {
      print(_userNameController.text);

      //监听文本框输入变化，当有内容时，显示尾部清楚按钮，否则不显示
      if(_userNameController.text.length > 0){
        _isShowClear = true;
      }else{
        _isShowClear = false;
      }
      setState(() {});
    });
    super.initState();
  }

  //生命周期
  @override
  void dispose(){
    // TODO: implement dispose
    //移除监听焦点
    _focusNodeUserName.removeListener(_focusNodeListener);
    _focusNodePassWord.removeListener(_focusNodeListener);
//    _focusNodeKey.removeListener(_focusNodeListener);
    _userNameController.dispose();
    super.dispose();
  }


  //监听焦点
  Future _focusNodeListener()async{
    if(_focusNodeUserName.hasFocus){
      print("用户名框获取焦点");
      //取消密码框的焦点状态
      _focusNodePassWord.unfocus();
//      _focusNodeKey.unfocus();
    }
    if(_focusNodePassWord.hasFocus){
      print("密码框获取焦点");
      //取消用户名框的焦点状态
      _focusNodeUserName.unfocus();
//      _focusNodeKey.unfocus();
    }
//    if(_focusNodeKey.hasFocus){
//      print("验证码框获取焦点");
//      //取消用户名框密码框的焦点状态
//      _focusNodeUserName.unfocus();
//      _focusNodePassWord.unfocus();
//    }
  }

  //验证用户名
  String validataUserName(value){
    //正则匹配手机号
//    RegExp exp = RegExp(
//        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$'
//    );
    if(value.isEmpty){
      return "用户名不能为空!";
    }
    return null;
  }

  //验证密码
  String validatePassWord(value){
    if(value.isEmpty){
      return '密码不能为空!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    print("----------login 页面 刷新----build----------");
    //logon图片区域
    Widget loginImageArea = Container(
//  获取屏幕宽度
      width: MediaQuery.of(context).size.width,
//      child: Image.asset("assets/icon_login_backgroup.png"),
    );


    //文本输入框区域
    Widget inputTextArea = Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: Colors.white,
      ),
      child: Form(
        key: _formkey,
        child: Column(
          // 通常容器空间需要根据内容的大小而撑开的时候用
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _userNameController,
              focusNode: _focusNodeUserName,
              // 设置键盘类型
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "账号",
                hintText: "请输入账号",
                prefix: Icon(Icons.person, color: Colors.indigoAccent),
                //  尾部添加清除按钮
                suffix: (_isShowClear)
                  ? IconButton(
                      icon: Icon(Icons.clear),
                  onPressed: () {
                      _userNameController.clear();
                  },
                ) : null
              ),
              // 保存数据
              validator: validataUserName,
              onSaved: (String value) {
                _username = value;
              },
            ),
            TextFormField(
              controller: _userPassWordController,
              focusNode: _focusNodePassWord,
              decoration: InputDecoration(
                labelText: "密码",
                hintText: "请输入密码",
                prefixIcon: Icon(Icons.lock, color: Colors.indigoAccent),
                // 是否显示密码
                suffix: IconButton(
                  icon: Icon(
                      (_isShowPad) ? Icons.visibility : Icons.visibility_off
                  ),
                  // 点击改变显示或者隐藏密码
                  onPressed: () {
                    setState(() {
                      _isShowPad = !_isShowPad;
                    });
                  },
                ),
              ),
              obscureText: !_isShowPad,
              // 保存数据
              validator: validatePassWord,
              onSaved: (String value) {
                _password = value;
              },
            ),
//            TextFormField(
//              focusNode: _focusNodeKey,
//              decoration: InputDecoration(
//                labelText: "验证码",
//                hintText: "请输入验证码",
//                prefixIcon: Icon(Icons.beenhere, color: Colors.indigoAccent),
//                // 是否显示验证码
//                suffix: InkWell(
//                  onTap: () {
//                    setState(() {
//                      int date = DateTime.now().millisecondsSinceEpoch;
//                      _imageUrl = Constant.keyUrl + "$date";
//                      _randomStr = date.toString();
//                    });
//                  },
//                  child: Image.network(_imageUrl, height: 30, width: 80),
//                ),
//              ),
//              // 保存数据
//              onSaved: (String value) {
//                _keycode = value;
//              },
//            ),
          ],
        ),
      ),
    );


    // 登录按钮区域
    Widget loginButtonArea = Container(
      margin: EdgeInsets.only(left: 30.0, right: 30.0),
      height: 55.0,
      child: RaisedButton(
        color: Colors.indigoAccent,
        child: Text("登录", style: Theme.of(context).primaryTextTheme.headline1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: () {
          // 点击登录按钮，解除焦点，回收键盘
          _focusNodeUserName.unfocus();
          _focusNodePassWord.unfocus();

          if(_formkey.currentState.validate()) {
//            //只有输入通过验证，才会执行这里
//            _formKey.currentState.save();
//            //todo 登录操作
//            print("$_username + $_password");
//            UserManager.save('name', _username);
//            UserManager.save('pass', _password);
//            _login(_username, _password, _keycode, _randomStr, context);
          }
        },
      ),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      // 外层添加一个手势，用于点击空白部分回收键盘
      body: GestureDetector(
        onTap: () {
          // 点击空白部分回收键盘
          print("点击了空白部分");
          _focusNodeUserName.unfocus();
          _focusNodePassWord.unfocus();
          _focusNodeKey.unfocus();
        },
        child: ListView(
          padding: EdgeInsets.only(top: 0),
          children: <Widget>[
            loginImageArea,
            SizedBox(height: 70),
            inputTextArea,
            SizedBox(height: 80),
            loginImageArea,
          ],
        ),
      ),
    );
  }
}
