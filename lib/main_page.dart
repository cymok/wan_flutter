import 'package:flutter/material.dart';
import 'package:wan_flutter/pages/account_page.dart';
import 'package:wan_flutter/pages/home_page.dart';
import 'package:wan_flutter/pages/project_page.dart';
import 'package:wan_flutter/pages/square_page.dart';
import 'package:wan_flutter/pages/subscribe_page.dart';
import 'package:wan_flutter/utils/log_utils.dart';
import 'package:wan_flutter/utils/toast_utils.dart';

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({super.key, required this.title});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 5, vsync: this);
    controller.addListener(() {
      // 监听点击
      if (controller.indexIsChanging) {
        // 只有点击 tabbar 响应
        // LogUtils.log(
        //     "indexIsChanging preIndex=${controller.previousIndex} curIndex=${controller.index}");
      } else {
        // 点击 tabbar 和 滑动 tabbarview 都响应
        LogUtils.log(
            "not indexIsChanging preIndex=${controller.previousIndex} curIndex=${controller.index}");
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late DateTime? lastPopTime;
    // return SafeArea(child: myScaffold());
    return myScaffold();
    // todo 拦截返回无效 未找到原因
    return WillPopScope(
      // 拦截返回键
      onWillPop: () async {
        if (lastPopTime == null ||
            DateTime.now().difference(lastPopTime!) >
                const Duration(seconds: 1)) {
          LogUtils.log("再按一次退出");
          lastPopTime = DateTime.now();
          ToastUtils.show("再按一次退出");
          return Future.value(false);
        } else {
          LogUtils.log("退出");
          lastPopTime = DateTime.now();
          // 退出app
          return Future.value(true);
          // await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      },
      child: myScaffold(),
    );
  }

  Scaffold myScaffold() => Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        bottomNavigationBar: Container(
          color: Colors.grey[100],
          // height: 60,
          child: TabBar(
            controller: controller,
            tabs: const [
              Tab(
                text: "推荐",
                icon: Icon(Icons.home_outlined),
              ),
              Tab(
                text: "项目",
                icon: Icon(Icons.business_center_outlined),
              ),
              Tab(
                text: "广场",
                icon: Icon(Icons.crop_square),
              ),
              Tab(
                text: "订阅",
                icon: Icon(Icons.subscript_outlined),
              ),
              Tab(
                text: "我的",
                icon: Icon(Icons.manage_accounts_outlined),
              ),
            ],
          ),
        ),
        body: Container(
          // 设置 状态栏高度 的边距
          // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: TabBarView(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(), // 禁止滑动
            children: const [
              HomePage(),
              ProjectPage(),
              SquarePage(),
              SubscribePage(),
              AccountPage(),
            ],
          ),
        ),
      );
}
