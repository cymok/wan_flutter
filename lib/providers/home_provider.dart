import 'package:flutter/cupertino.dart';
import 'package:wan_flutter/models/article_item.dart';
import 'package:wan_flutter/models/banner_item.dart';
import 'package:wan_flutter/services/api_service.dart';

class HomeProvider with ChangeNotifier {
  List<BannerItem> bannerList = [];
  List<ArticleItem> itemList = [];
  int firstPage = 0;
  int currentPage = 0;
  bool isLoading = false;
  bool hasMoreData = true;

  HomeProvider() {
    // loadList();
    // 在 pull to refresh 的 initLoad 处理
  }

  final ApiService _apiService = ApiService();

  Future<void> loadList() async {
    if (isLoading || !hasMoreData) return;

    isLoading = true;
    notifyListeners();

    try {
      List<ArticleItem> list;
      if (currentPage == firstPage) {
        // 首次加载加载、刷新
        // 异步等待三个接口
        // banner
        List<BannerItem> bannerList = await _apiService.getBannerList();
        this.bannerList = bannerList;
        // 列表
        List<ArticleItem> topList = await _apiService.getHomeTopList();
        list = await _apiService.getHomeList(currentPage.toString());
        itemList.clear(); // 放在获取数据后，不然 UI 列表会短暂清空
        itemList.addAll(topList);
        itemList.addAll(list);
      } else {
        // 加载更多
        list = await _apiService.getHomeList(currentPage.toString());
        itemList.addAll(list);
      }

      if (list.length < 10) {
        hasMoreData = false;
      } else {
        currentPage++;
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshList() async {
    currentPage = firstPage;
    hasMoreData = true;
    await loadList(); // 重新加载第一页数据
  }
}
