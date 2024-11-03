import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_flutter/common/my_color.dart';
import 'package:wan_flutter/pages/project_tab_page.dart';
import 'package:wan_flutter/providers/project_provider.dart';
import 'package:wan_flutter/providers/project_tab_provider.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State createState() => _ProjectState();
}

class _ProjectState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // `initState` 是在 StatefulWidget 被插入到树中时调用的第一个方法。
    // 它只会执行一次，并且通常用于初始化状态、订阅流或者监听器等操作。
    // 如果你需要在 Widget 第一次构建时进行一些初始化操作，可以将这些代码放在 `initState` 中。

    // 在页面初始化时触发网络请求
    // Future.microtask(() {
    // Provider.of<ProjectProvider>(context, listen: false).getTabList();
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // listen: false：不会在 Provider 的数据改变时触发 Widget 重建
      Provider.of<ProjectProvider>(context, listen: false).getProjectTree();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // `didChangeDependencies`: `didChangeDependencies` 在 `initState` 之后立即调用，并且可能会被多次调用。
    // - 当 State 对象的依赖关系发生变化时。例如，在 `build` 方法中使用了 `InheritedWidget`，当该 `InheritedWidget` 发生变化时，`didChangeDependencies` 就会被调用。
    // - 在父级 Widget 调用 `didChangeDependencies` 时，子级 Widget 的 `didChangeDependencies` 也会被调用。
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ProjectProvider>(
      builder: (_, provider, child) {
        // print("tab len = ${provider.tabList.length}");
        return Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          color: MyColor.wxBackground,
          child: DefaultTabController(
            length: provider.tabList.length,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TabBar(
                  // controller: ,
                  isScrollable: true,
                  // indicatorPadding: EdgeInsets.zero, // 去掉指示器的空白
                  // labelPadding: EdgeInsets.zero,     // 去掉标签的空白
                  tabs: provider.tabList.map((e) => Tab(text: e.name)).toList(),
                ),
                Expanded(
                  child: TabBarView(
                    children:
                        // provider.tabList.map((e) => myTabPager(e)).toList()
                        provider.tabList.map((e) {
                      var cid = "${e.id}";
                      return Center(
                        // test
                        // child: Text("${e.name}"),
                        child: ChangeNotifierProvider(
                          create: (_) {
                            return ProjectTabProvider(cid);
                          },
                          child: ProjectTabPage(tabId: cid),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
