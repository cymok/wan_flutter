import 'package:flutter/widgets.dart';
import 'package:wan_flutter/models/article_item.dart';

// Dart 没有专门的 interface 关键字，
// 取而代之的是使用 abstract class 来达到相同的目的
abstract class ArticlesListProvider with ChangeNotifier {
  List<ArticleItem> itemList = [];
  int firstPage = 1; // 让子类去设置 0 or 1
  int currentPage = 0; // 页码，有的接口是从 0 起，有的接口是从 1 起
  bool isLoading = false;
  bool hasMoreData = true;
  bool ignoreHasMoreData = false; // fixme 有的接口返回列表条数跟参数设定不一致，改不了别人的接口，只好忽略处理

  // 接口方法，抽象方法，需要实现类去实现，调用不同的接口获取文章列表数据
  Future<List<ArticleItem>> fetchArticlesList();

  initFirstPage(int firstPage) {
    this.firstPage = firstPage;
    currentPage = firstPage;
  }

  Future<void> loadList() async {
    if (isLoading || !hasMoreData) return;

    isLoading = true;
    notifyListeners();

    try {
      List<ArticleItem> list = await fetchArticlesList();

      // todo
      // 每页条数跟接口保持一致，默认 10
      // 返回不一致的接口由子类修改 ignoreHasMoreData 去忽略
      if (list.length < 10 && !ignoreHasMoreData) {
        itemList.addAll(list);
        hasMoreData = false;
      } else {
        itemList.addAll(list);
        currentPage++;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshList() async {
    currentPage = firstPage;
    itemList.clear();
    hasMoreData = true;
    await loadList(); // 重新加载第一页数据
  }
}
