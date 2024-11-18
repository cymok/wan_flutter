import 'package:wan_flutter/api/services/wan_service.dart';
import 'package:wan_flutter/models/article_item.dart';
import 'package:wan_flutter/providers/common/articles_list_provider.dart';

class SquareProvider extends ArticlesListProvider {
  SquareProvider() {
    // 广场接口页面从 0 起
    initFirstPage(0);
    ignoreHasMoreData = true; // fixme 有的接口返回列表条数跟参数设定不一致，改不了别人的接口，只好忽略处理
  }

  final WanService _apiService = WanService();

  @override
  Future<List<ArticleItem>> fetchArticlesList() {
    return _apiService.getSquareList(currentPage);
  }
}
