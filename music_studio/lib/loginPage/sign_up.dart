import 'dart:async';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


var _phone = new TextEditingController();
var _password = new TextEditingController();
var _passwordsure = new TextEditingController();
var _verification = new TextEditingController();
var flag;

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("lib/assets/loginPage/login.jpg"),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leadingWidth: 75.0,
            leading: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: TextButton(
                onPressed: () {//清除数据
                  _phone.clear();
                  _password.clear();
                  _passwordsure.clear();
                  _verification.clear();
                  Navigator.pushNamed(context, '/login');
                },
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                        TextStyle(color: Colors.white)),
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
                child: Text("<返回",textAlign: TextAlign.center,),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text("注册"),
          ),
          body: SingleChildScrollView(
            child: Layout(),
          )),
    );
  }
}

class Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 100),
          Text(
            "欢迎来到这个注册界面",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
              child: Theme(
                data: ThemeData(
                    primaryColor: Colors.white,
                    hintColor: Colors.white), //点击文本框时边框颜色 and 提示字颜色
                child: TextField(
                  controller: _phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11)
                  ], //只允许输入数字
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "手机号",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30), //初始文本框为圆角边框
                      borderSide: BorderSide(
                          width: 2, color: Colors.white), //初始时文本框边框颜色
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)), //输入时文本框为圆角边框
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
            child: Theme(
              data: ThemeData(
                  primaryColor: Colors.white, hintColor: Colors.white),
              child: TextField(
                obscureText: true,
                style: TextStyle(color: Colors.white),
                controller: _password,
                decoration: InputDecoration(
                  labelText: "密码",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(width: 2, color: Colors.white),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
            child: Theme(
              data: ThemeData(
                  primaryColor: Colors.white, hintColor: Colors.white),
              child: TextField(
                obscureText: true,
                style: TextStyle(color: Colors.white),
                controller: _passwordsure,
                decoration: InputDecoration(
                  labelText: "确认密码",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(width: 2, color: Colors.white),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, //将验证码和按钮分别和两侧对齐
              children: <Widget>[
                Container(
                  height: 50.0,
                  width: 125.0,
                  child: TextField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    controller: _verification,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(width: 2, color: Colors.white)),
                      labelText: '验证码',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                VerButton()
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: InkWell(
              onTap: () {
                var phonenumber = _phone.text;
                var passwordnumber = _password.text;
                var passwordsurenumber = _passwordsure.text;
                var verification = _verification.text;
                // print(flag);
                if (passwordnumber == passwordsurenumber &&
                    passwordsurenumber.isNotEmpty &&
                    verification == flag &&
                    passwordnumber.isNotEmpty &&
                    phonenumber.isNotEmpty) {
                  // _insert(phonenumber, passwordnumber, context);
                } else if (phonenumber.isEmpty)
                  Fluttertoast.showToast(msg: "请输入手机号!");
                else if (passwordnumber != passwordsurenumber)
                  Fluttertoast.showToast(msg: "密码不一致!");
                else if (passwordnumber.isEmpty)
                  Fluttertoast.showToast(msg: "请输入密码!");
                else if (verification.isEmpty)
                  Fluttertoast.showToast(msg: "请输入验证码!");
                else if (verification != flag)
                  Fluttertoast.showToast(msg: "验证码错误!");
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  "注册",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class VerButton extends StatefulWidget {
  VerButton({Key key}) : super(key: key);

  @override
  _VerButtonState createState() => _VerButtonState();
}

class _VerButtonState extends State<VerButton> {
  bool clickable = true; //确定按钮是否可以按下
  String buttonText = "发送验证码";
  int count = 60;
  Timer timer; //设定计时器
  TextEditingController mController = new TextEditingController();

//验证用户是否在数据库内
//setState函数需要在可变组件内使用，故_check函数需要定义在组件内作为内置函数方可使用
//   _check(String username, BuildContext context) async {
//     var url = Uri.parse(Api.url + '/user/check?username=' + username);
//     var response = await http.post(url);
//     print('Response body: ${response.body}');
//     if (response.body == '1') {
//       //respons返回1说明用户在数据库中存在，不可以发送验证码
//       Fluttertoast.showToast(msg: '手机号已注册!');
//     } else {
//       setState(() {
//         _buttonClickListen(); //监听函数，用于设置按钮的是否可点
//       });
//       print('生成验证码：' + flag); //将生成的4位随机验证码打印到终端
//       Fluttertoast.showToast(msg: '验证码已发送!');
//     }
//   }

  void _buttonClickListen() {
    setState(() {
      if (clickable) {
        //当按钮可点击时
        clickable = false; //按钮状态标记
        _initTimer();
        flag = _randomBit(4);
      } //当按钮不可点击时
      return null; //返回null按钮禁止点击
    });
  }

  _randomBit(int len) {//随机生成四位数字
    String scope = '0123456789';
    String result = '';
    for (int i = 0; i < len; i++) {
      result = result + scope[Random().nextInt(scope.length)];
    }
    return result;
  }

  void _initTimer() {
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      count--;
      setState(() {
        if (count == 0) {
          timer.cancel(); //倒计时结束取消定时器
          count = 60; //重置时间
          clickable = true;
          buttonText = '发送验证码'; //重置按钮文本
        } else {
          buttonText = '${count}S'; //更新文本内容
        }
      });
    });
  }

  void dispose() {
    timer?.cancel(); //销毁计时器
    timer = null;
    mController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_phone.text.length == 11 && clickable == true) {
          String username = _phone.text;
          // _check(username, context);
        } else {
          if (clickable == true) {
            if (_phone.text.isEmpty)
              Fluttertoast.showToast(msg: '请输入手机号！');
            else if (_phone.text.length != 11)
              Fluttertoast.showToast(msg: '请输入正确的手机号！');
          }
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
        height: 50,
        width: 125,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(30)),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// _insert(String username, String password, BuildContext context) async {
//   var url = Uri.parse(Api.url + '/user/insert');
//   var url_check = Uri.parse(Api.url + '/user/check?username=' + username);
//   var response_check = await http.post(url_check);
//   if (response_check.body == '1')
//     Fluttertoast.showToast(msg: '该手机号已注册！');
//   else {
//     var response = await http.post(url,
//         headers: {"content-type": "application/json"},
//         body: '{"username": "${username}", "password": "' +
//             Api.md5(password) +
//             '"}');
//     print('Response body: ${response.body}');
//     Fluttertoast.showToast(msg: '注册成功!');
//     _phone.clear();
//     _password.clear();
//     _passwordsure.clear();
//     _verification.clear();
//     Navigator.pushNamed(context, '/login');
//   }
// }
