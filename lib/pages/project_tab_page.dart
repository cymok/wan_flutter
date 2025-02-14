import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_flutter/models/article_item.dart';
import 'package:wan_flutter/pages/common/articles_list_state.dart';
import 'package:wan_flutter/providers/project_tab_provider.dart';
import 'package:wan_flutter/providers/project_tab_provider_new.dart';

class ProjectTabPage extends StatefulWidget {
  final String tabId;

  const ProjectTabPage({super.key, required this.tabId});

  @override
  State createState() => _ProjectTabStateNew();
}

class _ProjectTabStateNew extends ArticlesListState<ProjectTabPage, ProjectTabProviderNew> {}

class _ProjectTabState extends State<ProjectTabPage> with AutomaticKeepAliveClientMixin {
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
    await Provider.of<ProjectTabProvider>(context, listen: false).refreshList();
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    if (Provider.of<ProjectTabProvider>(context, listen: false).hasMoreData) {
      await Provider.of<ProjectTabProvider>(context, listen: false).loadList();
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ProjectTabProvider>(
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
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                var item = list[index];
                return Container(
                  width: double.maxFinite,
                  height: 100,
                  child: ListTile(
                    title: Text('${item.title}'),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
