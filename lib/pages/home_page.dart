import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_flutter/common/my_color.dart';
import 'package:wan_flutter/models/article_item.dart';
import 'package:wan_flutter/models/banner_item.dart';
import 'package:wan_flutter/pages/common/articles_list_item_widget.dart';
import 'package:wan_flutter/pages/common/banner_widget.dart';
import 'package:wan_flutter/providers/home_provider.dart';
import 'package:wan_flutter/utils/toast_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: MyColor.wxBackground,
      // child: const Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Text("推荐"),
      //   ],
      // ),
      child: HomeContainerPage(),
    );
  }
}

class HomeContainerPage extends StatefulWidget {
  const HomeContainerPage({super.key});

  @override
  State<StatefulWidget> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainerPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late RefreshController _refreshController;

/*
  late ScrollController _scrollController;
  void _scrollListener() {
    print(
        "Scroll position: ${_scrollController.position.pixels}, Max: ${_scrollController.position.maxScrollExtent}");

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print("Reached the bottom");
      // 到达底部，加载更多数据
      Provider.of<ProjectTabProvider>(context, listen: false).loadList();
    }
  }
*/

  @override
  void initState() {
    super.initState();
    // _scrollController = ScrollController();
    // _scrollController.addListener(_scrollListener);
    _refreshController = RefreshController(initialRefresh: true);
  }

  @override
  void dispose() {
    // _scrollController.removeListener(_scrollListener);
    // _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    // 调用 provider 的 resetList 方法来刷新数据
    await Provider.of<HomeProvider>(context, listen: false).refreshList();
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    if (Provider.of<HomeProvider>(context, listen: false).hasMoreData) {
      await Provider.of<HomeProvider>(context, listen: false).loadList();
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        List<BannerItem> bannerList = provider.bannerList;
        List<ArticleItem> itemList = provider.itemList;
        return Container(
          alignment: Alignment.center,
          child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.separated(
              // ListView.builder
              // ListView.separated 可以在 ListView.builder 基础上在每个 Item 间隙/间隔 设置一个 Widget
              itemCount: itemList.length + 1, // + 1 个 Banner
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  // banner view
                  return BannerWidget(
                    bannerList: bannerList,
                    onClick: (item) {
                      // todo
                      ToastUtils.show("banner url = ${item.url}");
                    },
                    onChange: (index, reason) {
                      // LogUtils.log("Banner onChange index = ${index}, type = ${reason.name}");
                    },
                  );
                } else {
                  var item = itemList[index - 1]; // 减去 Banner 的位置
                  // item view
                  return ListItem(
                    item: item,
                    index: index,
                    onClick: () {
                      // todo
                      ToastUtils.show("item link = ${item.link}");
                    },
                  );
                }
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 10);
              },
            ),
          ),
        );
      },
    );
  }
}
