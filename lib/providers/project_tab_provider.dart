import 'package:flutter/widgets.dart';
import 'package:wan_flutter/api/services/wan_service.dart';
import 'package:wan_flutter/models/article_item.dart';

class ProjectTabProvider with ChangeNotifier {
  final String cid;
  List<ArticleItem> itemList = [];
  int firstPage = 1;
  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;

  ProjectTabProvider(this.cid) {
    // loadList();
    // 在 pull to refresh 的 initLoad 处理
  }

  final WanService _apiService = WanService();

  Future<void> loadList() async {
    if (isLoading || !hasMoreData) return;

    isLoading = true;
    notifyListeners();

    try {
      List<ArticleItem> list = await _apiService.getProjectList(cid, currentPage);
      if (currentPage == firstPage) {
        itemList.clear();
      }
      itemList.addAll(list);

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
