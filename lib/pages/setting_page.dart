// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:wan_flutter/common/my_color.dart';
import 'package:wan_flutter/utils/toast_utils.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State createState() => _SettingState();
}

class _SettingState extends State<SettingPage> {
  void onBackPressed() {
    Navigator.pop(context, "返回键");
  }

  @override
  Widget build(BuildContext context) {
    // 设置 显示/隐藏 状态栏和导航栏（全屏模式）

    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); // 正常
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // 全屏 粘性状态栏 可下拉 自动隐藏
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack); //
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);

    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Colors.red));

    return PopScope(
      // WillPopScope(
      // onWillPop: () async {
      //   onBackPressed();
      //   return false;
      // },
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        onBackPressed();
      },
      child: Scaffold(
        body: Container(
          // margin: EdgeInsets.only(top: MediaQuery
          //     .of(context)
          //     .padding
          //     .top),
          color: MyColor.wxBackground,
          child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    ToastUtils.show("缓存清理");
                  },
                  child: Container(
                    color: MyColor.wxForeground,
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          "缓存清理",
                          style: TextStyle(
                              fontSize: 16, color: MyColor.primaryText),
                        ),
                        Spacer(flex: 1),
                        Text(
                          "0.00KB",
                          style: TextStyle(
                              fontSize: 14, color: MyColor.secondaryText),
                        ),
                        SizedBox(width: 10),
                        Image.asset(
                          "assets/images/icon_arrow_right.png",
                          width: 25,
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 0.5),
                InkWell(
                  onTap: () {
                    ToastUtils.show("深色模式");
                  },
                  child: Container(
                    color: MyColor.wxForeground,
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          "深色模式",
                          style: TextStyle(
                              fontSize: 16, color: MyColor.primaryText),
                        ),
                        Spacer(flex: 1),
                        Text(
                          "跟随系统",
                          style: TextStyle(
                              fontSize: 14, color: MyColor.secondaryText),
                        ),
                        SizedBox(width: 10),
                        Image.asset(
                          "assets/images/icon_arrow_right.png",
                          width: 25,
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    ToastUtils.show("网站");
                  },
                  child: Container(
                    color: MyColor.wxForeground,
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          "网站",
                          style: TextStyle(
                              fontSize: 16, color: MyColor.primaryText),
                        ),
                        Spacer(flex: 1),
                        Text(
                          "WanAndroid",
                          style: TextStyle(
                              fontSize: 14, color: MyColor.secondaryText),
                        ),
                        SizedBox(width: 10),
                        Image.asset(
                          "assets/images/icon_arrow_right.png",
                          width: 25,
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 0.5),
                InkWell(
                  onTap: () {
                    ToastUtils.show("反馈/建议");
                  },
                  child: Container(
                    color: MyColor.wxForeground,
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          "反馈/建议",
                          style: TextStyle(
                              fontSize: 16, color: MyColor.primaryText),
                        ),
                        Spacer(flex: 1),
                        Text(
                          "feedback@android.com",
                          style: TextStyle(
                              fontSize: 14, color: MyColor.secondaryText),
                        ),
                        SizedBox(width: 10),
                        Image.asset(
                          "assets/images/icon_arrow_right.png",
                          width: 25,
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 0.5),
                InkWell(
                  onTap: () {
                    ToastUtils.show("崩溃日志上报");
                  },
                  child: Container(
                    color: MyColor.wxForeground,
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          "崩溃日志上报",
                          style: TextStyle(
                              fontSize: 16, color: MyColor.primaryText),
                        ),
                        Spacer(flex: 1),
                        Text(
                          "report@android.com",
                          style: TextStyle(
                              fontSize: 14, color: MyColor.secondaryText),
                        ),
                        SizedBox(width: 10),
                        Image.asset(
                          "assets/images/icon_arrow_right.png",
                          width: 25,
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 0.5),
                InkWell(
                  onTap: () {
                    ToastUtils.show("APP 源码");
                  },
                  child: Container(
                    color: MyColor.wxForeground,
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          "APP 源码",
                          style: TextStyle(
                              fontSize: 16, color: MyColor.primaryText),
                        ),
                        Spacer(flex: 1),
                        Image.asset(
                          "assets/images/icon_arrow_right.png",
                          width: 25,
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 0.5),
                InkWell(
                  onTap: () {
                    ToastUtils.show("关于 APP");
                  },
                  child: Container(
                    color: MyColor.wxForeground,
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          "关于 APP",
                          style: TextStyle(
                              fontSize: 16, color: MyColor.primaryText),
                        ),
                        Spacer(flex: 1),
                        Image.asset(
                          "assets/images/icon_arrow_right.png",
                          width: 25,
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    ToastUtils.show("退出");
                  },
                  child: Container(
                    color: MyColor.wxForeground,
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "退出",
                      style:
                      TextStyle(fontSize: 16, color: MyColor.primaryText),
                    ),
                  ),
                ),
              ],
          ),
        ),
      ),
    );
  }
}
