import 'package:wan_flutter/api/services/wan_service.dart';
import 'package:wan_flutter/models/article_item.dart';
import 'package:wan_flutter/providers/common/articles_list_provider.dart';

class SubscribeTabProvider extends ArticlesListProvider {
  final String id;

  final WanService _apiService = WanService();

  SubscribeTabProvider(this.id) {
    // loadList();
    // 在 pull to refresh 的 initLoad 处理
  }

  @override
  Future<List<ArticleItem>> fetchArticlesList() {
    return _apiService.getSubscribeList(id, currentPage);
  }
}
