import 'package:flutter/material.dart';
import 'package:wan_flutter/common/my_color.dart';
import 'package:wan_flutter/pages/setting_page.dart';
import 'package:wan_flutter/utils/toast_utils.dart';

class Test2Page extends StatefulWidget {
  const Test2Page({super.key});

  @override
  State createState() => _Test2State();
}

class _Test2State extends State<Test2Page>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        color: MyColor.wxBackground,
        // color: Colors.grey[300]?.withOpacity(0.3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Ink(
              // 背景 有透明度 似乎 外层背景不能设置颜色 非要设置的话要带透明度 withOpacity
              color: Colors.white,
              child: InkWell(
                // InkWell 点击颜色
                splashColor: Colors.red,
                onTap: () {
                  ToastUtils.show("toast");
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  height: 48,
                  child: const Text("我的"),
                ),
              ),
            ),
            const SizedBox(height: 1),
            InkWell(
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
                color: Colors.white,
                alignment: Alignment.center,
                width: double.maxFinite,
                height: 48,
                child: const Text("设置"),
              ),
            ),
            const SizedBox(height: 50),
            GestureDetector( // 无 涟漪效果
              onTap: () {
                ToastUtils.show("GestureDetector");
              },
              child: const Text("GestureDetector 无 涟漪效果"),
            ),
            InkWell( // 有 涟漪效果
              onTap: () {
                ToastUtils.show("InkWell");
              },
              child: const Text("InkWell 有 涟漪效果"),
            ),
            FilledButton(
              style: const ButtonStyle(
                // FilledButton 背景颜色
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
                // 前景色
                foregroundColor: WidgetStatePropertyAll(Colors.purple),
              ),
              onPressed: () {
                ToastUtils.show("FilledButton");
              },
              child: const Text("FilledButton"),
            ),
            OutlinedButton(
              // OutlinedButton 边框颜色
              style: OutlinedButton.styleFrom(
                side: const BorderSide(width: 1.0, color: Colors.purple),
              ),
              onPressed: () {
                ToastUtils.show("OutlinedButton");
              },
              child: const Text("OutlinedButton"),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                // ElevatedButton 背景颜色
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
                // 前景色
                foregroundColor: WidgetStatePropertyAll(Colors.white),
              ),
              onPressed: () {
                ToastUtils.show("ElevatedButton");
              },
              child: const Text("ElevatedButton"),
            ),
            TextButton(
              onPressed: () {
                ToastUtils.show("TextButton");
              },
              child: const Text("TextButton"),
            ),
            Ink(
              // Ink 组件 color decoration 二选一
              // color: Colors.blue,
              decoration: BoxDecoration(
                color: Colors.green, // 设置背景颜色
                borderRadius: BorderRadius.circular(999),
              ),
              child: InkWell(
                splashColor: Colors.red, // 设置点击颜色
                // borderRadius: BorderRadius.circular(8.0),
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 150),
                  child: const Text('InkWell',
                      style: TextStyle(color: Colors.white)),
                ),
                onTap: () {
                  // 处理点击事件
                  ToastUtils.show("InkWell");
                },
              ),
            ),
            InkWell(
              highlightColor: Colors.yellow.withOpacity(0.3),
              splashColor: Colors.red.withOpacity(0.8),
              focusColor: Colors.green.withOpacity(0.0),
              hoverColor: Colors.blue.withOpacity(0.8),
              // borderRadius: BorderRadius.circular(999),
              onTap: () {
                // 处理点击事件
                ToastUtils.show("InkWell");
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text('InkWell'),
              ),
            ),
          ],
        ),
      );
  }
}
