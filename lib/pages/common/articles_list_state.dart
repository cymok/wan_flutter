import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_flutter/models/article_item.dart';
import 'package:wan_flutter/pages/common/articles_list_item_widget.dart';
import 'package:wan_flutter/providers/common/articles_list_provider.dart';
import 'package:wan_flutter/utils/toast_utils.dart';

class ArticlesListState<W extends StatefulWidget, T extends ArticlesListProvider> extends State<StatefulWidget>
    with AutomaticKeepAliveClientMixin {
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
    await Provider.of<T>(context, listen: false).refreshList();
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    if (Provider.of<T>(context, listen: false).hasMoreData) {
      await Provider.of<T>(context, listen: false).loadList();
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<T>(
      builder: (context, provider, child) {
        List<ArticleItem> list = provider.itemList;
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
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                var item = list[index];
                // item view
                return ListItem(
                  item: item,
                  index: index,
                  onClick: () {
                    // todo
                    ToastUtils.show("item link = ${item.link}");                  },
                );
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
