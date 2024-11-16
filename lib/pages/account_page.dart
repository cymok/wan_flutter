// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:wan_flutter/common/my_color.dart';
import 'package:wan_flutter/pages/setting_page.dart';
import 'package:wan_flutter/utils/toast_utils.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State createState() => _AccountState();
}

class _AccountState extends State<AccountPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: MyColor.wxBackground,
      child: ListView(
        children: [
          ColoredBox(
            color: MyColor.wxForeground,
            child: InkWell(
              onTap: () {
                ToastUtils.show("登录");
              },
              child: Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                // height: 150,
                child: Row(
                  children: [
                    SizedBox(width: 30),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        "assets/splash_1080.jpg",
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 50),
                        Text(
                          "未登录",
                          style: TextStyle(fontSize: 18, color: MyColor.primaryText),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              "用户名: null",
                              style: TextStyle(fontSize: 14, color: MyColor.secondaryText),
                            ),
                            SizedBox(width: 15),
                            Text(
                              "id: -1",
                              style: TextStyle(fontSize: 14, color: MyColor.secondaryText),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Text(
                          "邮箱: null",
                          style: TextStyle(fontSize: 14, color: MyColor.secondaryText),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                    Spacer(flex: 1),
                    Image.asset(
                      "assets/images/icon_arrow_right.png",
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(width: 16),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          ColoredBox(
            color: MyColor.wxForeground,
            child: InkWell(
              onTap: () {
                ToastUtils.show("积分排行");
              },
              child: Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/icon_conan_selected.png",
                      width: 28,
                      height: 28,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "积分排行",
                      style: TextStyle(fontSize: 16, color: MyColor.primaryText),
                    ),
                    Spacer(flex: 1),
                    Text(
                      "积分: 1234",
                      style: TextStyle(fontSize: 14, color: MyColor.secondaryText),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "排行: 2345",
                      style: TextStyle(fontSize: 14, color: MyColor.secondaryText),
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
          ),
          SizedBox(height: 10),
          ColoredBox(
            color: MyColor.wxForeground,
            child: InkWell(
              onTap: () {
                ToastUtils.show("收藏文章");
              },
              child: Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/icon_article.png",
                      width: 28,
                      height: 28,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "收藏文章",
                      style: TextStyle(fontSize: 16, color: MyColor.primaryText),
                    ),
                    Spacer(flex: 1),
                    Text(
                      "收藏量: 99 篇",
                      style: TextStyle(fontSize: 14, color: MyColor.secondaryText),
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
          ),
          SizedBox(height: 0.5),
          ColoredBox(
            color: MyColor.wxForeground,
            child: InkWell(
              onTap: () {
                ToastUtils.show("分享文章");
              },
              child: Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/icon_share.png",
                      width: 28,
                      height: 28,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "分享文章",
                      style: TextStyle(fontSize: 16, color: MyColor.primaryText),
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
          ),
          SizedBox(height: 0.5),
          ColoredBox(
            color: MyColor.wxForeground,
            child: InkWell(
              onTap: () {
                ToastUtils.show("收藏网站");
              },
              child: Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/icon_site.png",
                      width: 28,
                      height: 28,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "收藏网站",
                      style: TextStyle(fontSize: 16, color: MyColor.primaryText),
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
          ),
          SizedBox(height: 10),
          ColoredBox(
            color: MyColor.wxForeground,
            child: InkWell(
              onTap: () {
                var result = Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingPage()),
                );
                result.then((result) => {
                      // 处理页面返回结果
                      if (result != null)
                        {
                          ToastUtils.show(result),
                        }
                    });
              },
              child: Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/icon_settings.png",
                      width: 28,
                      height: 28,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "设置",
                      style: TextStyle(fontSize: 16, color: MyColor.primaryText),
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
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
