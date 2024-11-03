import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:wan_flutter/models/article_item.dart';
import 'package:wan_flutter/models/api_response.dart';
import 'package:wan_flutter/models/articles_tree_item.dart';
import 'package:wan_flutter/services/api_service.dart';

class ProjectTabProvider with ChangeNotifier {
  final String cid;
  List<ArticleItem> itemList = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;

  ProjectTabProvider(this.cid) {
    // loadList();
    // 在 pull to refresh 的 initLoad 处理
  }

  final ApiService _apiService = ApiService();

  Future<void> loadList() async {
    if (isLoading || !hasMoreData) return;

    isLoading = true;
    notifyListeners();

    try {
      List<ArticleItem> list =
          await _apiService.getProjectList(cid, currentPage.toString());

      if (list.length < 10) {
        itemList.addAll(list);
        hasMoreData = false;
      } else {
        itemList.addAll(list);
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
    currentPage = 1;
    itemList.clear();
    hasMoreData = true;
    await loadList(); // 重新加载第一页数据
  }
}
